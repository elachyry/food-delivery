import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:badges/badges.dart' as badges;
import 'package:multi_languges/blocs/filters/filters_bloc.dart';
import 'package:multi_languges/utils/app_routes.dart';

import 'package:multi_languges/utils/constants/image_constants.dart';
import 'package:multi_languges/widgets/filter/show_filter_modal_bottom_sheet.dart';

class DashboardHead extends StatelessWidget {
  const DashboardHead({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstants.dashboardBackground),
                  fit: BoxFit.cover),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deliver to',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Colors.white.withOpacity(0.4),
                          ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          'Hay Salam, Dakhla',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                          textAlign: TextAlign.start,
                        ),
                        const Icon(
                          Icons.arrow_drop_down_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -5, end: 2),
                    badgeContent: const Text('0'),
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
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.20 -
                MediaQuery.of(context).padding.top,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, right: 12, left: 12, bottom: 5),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    LineAwesomeIcons.search,
                    size: 35,
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
                          child: Text(
                              'an_error_occurred_please_try_again_later'.tr),
                        );
                      }
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'What are you craving?',
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
          ),
        ],
      ),
    );
  }
}
