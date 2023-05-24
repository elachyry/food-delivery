import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:multi_languges/models/restaurant.dart';
import 'package:multi_languges/widgets/dashboard/restaurant_item.dart';

import '../../blocs/favorites/favorites_bloc.dart';
import '../../controllers/restaurant_controller.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final focuseNode = FocusNode();
  String search = '';
  final restaurantController = Get.put(RestaurantController());

  @override
  Widget build(BuildContext context) {
    focuseNode.requestFocus();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        ),
        centerTitle: true,
        title: Text(
          'Search',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            TextField(
              focusNode: focuseNode,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Bootstrap.search,
                  // size: 35,
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: 'What are you craving?',
                hintStyle: const TextStyle(fontSize: 16),
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
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
            Expanded(
              child: SizedBox(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('restaurants')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                          child: Center(
                        child: CircularProgressIndicator(),
                      ));
                    }
                    return BlocBuilder<FavoritesBloc, FavoritesState>(
                        builder: (context, state) {
                      if (state is FavoritesLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is FavoritesLoaded) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                            if (data['name']
                                .toString()
                                .toLowerCase()
                                .contains(search.toLowerCase())) {
                              Restaurant restaurant = Restaurant.fromFirestore(
                                  snapshot.data!.docs[index]);
                              final isFavorite = state.favorites.contains(
                                  restaurantController.restaurants[index].id);
                              return RestaurantItem(
                                  restaurant: restaurant,
                                  isFavorite: isFavorite);
                            } else {
                              return Container();
                            }
                          },
                        );
                      } else {
                        return Text(
                            'an_error_occurred_please_try_again_later'.tr);
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
