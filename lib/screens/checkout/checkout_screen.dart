import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:multi_languges/blocs/cart/cart_bloc.dart';
import 'package:multi_languges/controllers/auth/user_controller.dart';
import 'package:multi_languges/controllers/order_controller.dart';
import 'package:multi_languges/screens/dashboard/dashbord_screen.dart';
import 'package:multi_languges/screens/dashboard/tab_screen.dart';
import 'package:multi_languges/screens/orders/orders_screen.dart';

import '../../models/menu_item.dart';
import '../../models/payment_methde.dart';
import '../../widgets/checkout/checkout_confirmation_dialog.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
    required this.total,
    required this.itemQuantity,
    required this.itemSubtotal,
  });

  final double total;
  final Map<String, Map<MenuItem, int>> itemQuantity;
  final Map<String, double> itemSubtotal;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final userController = Get.put(UserController());
  String? _currentAddressValue;
  String _currentPaymentValue = PaymentMethode.paymentMethodes[0].name;

  final orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    _currentAddressValue = userController.myData['addresses'][0]['name'];
  }

  @override
  Widget build(BuildContext context) {
    final user = userController.myData;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white60,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Checkout',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.all(5),
              margin:
                  const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 5),
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Select an Address',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 25,
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                    child: ListView.builder(
                      itemCount: user['addresses'].length,
                      itemBuilder: (context, index) => RadioListTile(
                        groupValue: _currentAddressValue,
                        title: Text(
                          user['addresses'][index]['name'].toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        value: user['addresses'][index]['name'],
                        onChanged: (val) {
                          setState(() {
                            _currentAddressValue = val as String;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 5,
                right: 5,
              ),
              margin: const EdgeInsets.only(
                top: 15,
                left: 5,
                right: 5,
              ),
              height: MediaQuery.of(context).size.height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Select Payment Method',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 25,
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: PaymentMethode.paymentMethodes.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: Radio(
                          value: PaymentMethode.paymentMethodes[index].name,
                          groupValue: _currentPaymentValue,
                          onChanged: (val) {
                            setState(() {
                              _currentPaymentValue = val as String;
                            });
                          },
                        ),
                        title: Text(
                          PaymentMethode.paymentMethodes[index].name
                              .toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        trailing: PaymentMethode.paymentMethodes[index].image,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(5),
              margin:
                  const EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 5),
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total :',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 25),
                    ),
                    Row(
                      children: [
                        Text(
                          widget.total.toStringAsFixed(2),
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Theme.of(context).primaryColor,
                                  ),
                        ),
                        Text(
                          'Dh',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Obx(
                    () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: orderController.isLoading.value
                          ? null
                          : () async {
                              // print('quantity : ${widget.itemQuantity}');
                              // print('subtotal : ${widget.itemSubtotal}');
                              bool shoudCheckout =
                                  await CheckoutConfirmationDialog.show(context)
                                      as bool;
                              if (shoudCheckout) {
                                await orderController
                                    .addOrder(
                                  widget.itemQuantity,
                                  widget.itemSubtotal,
                                  _currentPaymentValue,
                                  _currentAddressValue as String,
                                )
                                    .then((value) {
                                  context
                                      .read<CartBloc>()
                                      .add(const ClearCart());
                                  Get.off(() => const OrdersScreen());
                                });
                              }
                            },
                      child: orderController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              'Checkout',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(

      //   onPressed: () {},
      //   label: Text(
      //     'Checkout',
      //     style: Theme.of(context).textTheme.titleMedium!.copyWith(
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold,
      //         ),
      //   ),
      // ),
    );
  }
}
