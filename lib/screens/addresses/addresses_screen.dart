import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_stepper/easy_stepper.dart';

import 'package:get/get.dart';
import 'package:food_delivery_express/controllers/auth/auth_controller.dart';
import 'package:food_delivery_express/controllers/auth/user_controller.dart';
import 'package:food_delivery_express/controllers/checkout_controller.dart';
import 'package:food_delivery_express/models/Address.dart';
import 'package:food_delivery_express/models/user.dart';
import 'package:food_delivery_express/widgets/checkout/edit_address.dart';
import 'package:food_delivery_express/widgets/checkout/show_modal_bottom_sheet_add_address.dart';

class AddressesScreen extends StatelessWidget {
  AddressesScreen({super.key});
  final userController = Get.put(UserController());
  final checkoutController = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    userController.getUserData();
    final user = userController.myData;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white60,
            child: IconButton(
              icon:
                  const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'addresses'.tr,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SizedBox(
        child: Obx(() {
          if (userController.myData.isEmpty) {
            return const Expanded(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          return user['addresses'].isEmpty
              ? Center(
                  child: TextButton.icon(
                      onPressed: () {
                        showInputDialog(context);
                        // showModalBottomSheetAddAddress(context);
                      },
                      icon: const Icon(Icons.add_circle_outline_sharp),
                      label: Text(
                        'add_address'.tr,
                        style: const TextStyle(fontSize: 18),
                      )),
                )
              : ListView.builder(
                  itemCount: user['addresses'].length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                          title: Text(
                            user['addresses'][index]['address'].toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              '+212${user['addresses'][index]['phoneNumber']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue.shade300,
                                ),
                                onPressed: () {
                                  editAddressDialog(
                                    context,
                                    user['addresses'][index]['address']
                                        .toUpperCase(),
                                    user['addresses'][index]['phoneNumber'],
                                    user['addresses'][index]['id'],
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: () async {
                                  try {
                                    final List<Address> addresses = [];
                                    final addressData =
                                        userController.myData['addresses'];
                                    if (addressData != null) {
                                      for (var element in addressData) {
                                        addresses.add(Address.fromMap(element));
                                      }
                                    }
                                    int index = 0;

                                    for (var i = 0; i < addresses.length; i++) {
                                      if (addresses[i].id ==
                                          user['addresses'][index]['id']) {
                                        index = i;
                                        break;
                                      }
                                    }
                                    addresses.removeAt(index);
                                    final data = userController.myData;
                                    checkoutController.isLoading.value = true;
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(AuthController
                                            .instance.auth.currentUser!.uid)
                                        .update(User(
                                                fullName: data['fullName'],
                                                email: data['email'],
                                                phoneNumber:
                                                    data['phoneNumber'],
                                                password: data['password'],
                                                addresses: addresses)
                                            .toMap());

                                    userController.getUserData();
                                    checkoutController.isLoading.value = false;
                                    // getUserData();
                                    userController.showSnackBarSuccess(
                                        'your_profile_has_been_updated'.tr);
                                  } catch (e) {
                                    checkoutController.isLoading.value = false;
                                    // print('error $e');
                                    userController.showSnackBarError();
                                    rethrow;
                                  }
                                },
                              ),
                            ],
                          )),
                    ),
                  ),
                );
        }),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showInputDialog(context);
          },
          child: const Icon(Icons.add)),
    );
  }
}
