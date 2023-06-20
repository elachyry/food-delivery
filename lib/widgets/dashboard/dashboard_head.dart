import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:badges/badges.dart' as badges;
import 'package:food_delivery_express/blocs/filters/filters_bloc.dart';
import 'package:food_delivery_express/screens/location/navigation_screen.dart';
import 'package:food_delivery_express/utils/app_routes.dart';

import 'package:food_delivery_express/utils/constants/image_constants.dart';
import 'package:food_delivery_express/widgets/filter/show_filter_modal_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../controllers/auth/user_controller.dart';
import '../../screens/search/search_screen.dart';

class DashboardHead extends StatefulWidget {
  const DashboardHead({
    super.key,
  });

  @override
  State<DashboardHead> createState() => _DashboardHeadState();
}

class _DashboardHeadState extends State<DashboardHead> {
  final focuseNode = FocusNode();

  final userController = Get.put(UserController());
  String? deliveryTo;

  Future<void> getAddress() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      deliveryTo = sharedPreferences.getString('deliveryTo');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    // userController.getUserData();
    // List<Place> userLocations = [];

    // List<dynamic> addresses = userController.myData['addresses'];
    // for (var element in addresses) {
    //   userLocations.add(Place.fromMap(element));
    // }
    return Container(
      color: Colors.grey.shade200,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: 150,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstants.dashboardBackground),
                  fit: BoxFit.cover),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'deliver_to'.tr,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) =>
                                          const NavigationScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  deliveryTo ?? "select_a_location".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    fullscreenDialog: true,
                                    builder: (context) =>
                                        const NavigationScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is CartLoaded) {
                          int itemCount = 0;

                          state.cart
                              .itemQuantity(state.cart.menuItems)
                              .forEach((key, value) {
                            for (var element in value.entries) {
                              itemCount += element.value;
                            }
                          });

                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            child: badges.Badge(
                              position:
                                  badges.BadgePosition.topEnd(top: -5, end: 2),
                              badgeContent: Text(itemCount.toString()),
                              child: IconButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.cartScreenRoute);
                                },
                                icon: const Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Center(
                            child: Text(
                                'an_error_occurred_please_try_again_later'.tr),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 160 - MediaQuery.of(context).padding.top,
            left: 20,
            right: 20,
            child: TextField(
              focusNode: focuseNode,
              onTap: () {
                focuseNode.unfocus();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ));
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Bootstrap.search,
                  // size: 35,
                ),
                suffixIcon: BlocBuilder<FiltersBloc, FiltersState>(
                  builder: (context, state) {
                    if (state is FiltersLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is FiltersLoaded) {
                      return InkWell(
                        onTap: () {
                          for (var e in state.filter.categoryFilters) {
                            context.read<FiltersBloc>().add(
                                  CategoryFilterUpdate(
                                    categoryFilter: e.copyWith(
                                      value: false,
                                    ),
                                  ),
                                );
                          }
                          showFilterModalBotomSheet(context);
                        },
                        child: const Icon(
                          LineAwesomeIcons.filter,
                          size: 30,
                        ),
                      );
                    } else {
                      return Center(
                        child:
                            Text('an_error_occurred_please_try_again_later'.tr),
                      );
                    }
                  },
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'what_are_you_craving'.tr,
                hintStyle: const TextStyle(fontSize: 13),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
