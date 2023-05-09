import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../blocs/cart/cart_bloc.dart';
import '../../models/menu_item.dart';

class CartItem extends StatelessWidget {
  final CartLoaded state;
  final int index;
  const CartItem({
    super.key,
    required this.elements,
    required this.state,
    required this.index,
  });

  final String elements;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      child: Dismissible(
        key: const ValueKey(1),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red,
          ),
          padding: const EdgeInsets.only(
            right: 25,
          ),
          margin: const EdgeInsets.all(5),
          alignment: Alignment.centerRight,
          child: const Icon(
            Bootstrap.trash,
            color: Colors.white,
            size: 35,
          ),
        ),
        child: Card(
          elevation: 3,
          child: Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Checkbox(
                  value: true,
                  onChanged: (value) {},
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox(
                    width: 90,
                    height: 90,
                    child: Image.network(
                      (state.cart
                              .itemQuantity(state.cart.menuItems)
                              .keys
                              .elementAt(index) as MenuItem)
                          .imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 90,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (state.cart
                                .itemQuantity(state.cart.menuItems)
                                .keys
                                .elementAt(index) as MenuItem)
                            .name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        child: Text(
                          elements,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey, fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            (state.cart
                                    .itemQuantity(state.cart.menuItems)
                                    .keys
                                    .elementAt(index) as MenuItem)
                                .price
                                .toStringAsFixed(2),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                          ),
                          Text(
                            'Dh',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
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
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state2) {
                    return SizedBox(
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<CartBloc>().add(
                                    AddItem(
                                        menuItem: state.cart
                                            .itemQuantity(state.cart.menuItems)
                                            .keys
                                            .elementAt(index) as MenuItem),
                                  );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                color: Theme.of(context).primaryColorDark,
                                child: const Icon(
                                  Bootstrap.plus,
                                  size: 28,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.05)),
                            child: Text(
                              '${state.cart.itemQuantity(state.cart.menuItems).entries.elementAt(index).value}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<CartBloc>().add(
                                    RemoveItem(
                                        menuItem: state.cart
                                            .itemQuantity(state.cart.menuItems)
                                            .keys
                                            .elementAt(index) as MenuItem),
                                  );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                color: Colors.grey.shade200,
                                child: const Icon(
                                  Bootstrap.dash,
                                  size: 28,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
