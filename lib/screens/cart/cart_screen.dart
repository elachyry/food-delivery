import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:multi_languges/models/menu_item.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../widgets/cart/cart_bottom_nav_bar.dart';
import '../../widgets/cart/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey.shade200,
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
          'Cart',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: const CartBottomNavBar(),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CartLoaded) {
                    return state.cart.menuItems.isEmpty
                        ? Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nothing to show!',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(
                                        fontSize: 25,
                                      ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.65,
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: state.cart
                                    .itemQuantity(state.cart.menuItems)
                                    .keys
                                    .length,
                                itemBuilder: (context, index) {
                                  String elements = '';
                                  int size = (state.cart
                                          .itemQuantity(state.cart.menuItems)
                                          .keys
                                          .elementAt(index) as MenuItem)
                                      .elements
                                      .length;
                                  int i = 0;
                                  for (var e in (state.cart
                                          .itemQuantity(state.cart.menuItems)
                                          .keys
                                          .elementAt(index) as MenuItem)
                                      .elements) {
                                    if (i == size - 1) {
                                      elements +=
                                          '${e['quantity']}x${e['name']}';
                                    } else {
                                      elements +=
                                          '${e['quantity']}x${e['name']}, ';
                                    }
                                    i++;
                                  }
                                  return CartItem(
                                    elements: elements,
                                    state: state,
                                    index: index,
                                  );
                                }),
                          );
                  } else {
                    return Center(
                      child:
                          Text('an_error_occurred_please_try_again_later'.tr),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
