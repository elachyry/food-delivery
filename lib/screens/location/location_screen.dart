import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multi_languges/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:multi_languges/blocs/geolocation/geolocation_bloc.dart';
import 'package:multi_languges/widgets/location/location_search_box.dart';

import '../../blocs/place/place_bloc.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bloc.BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceLoading) {
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: bloc.BlocBuilder<GeolocationBloc, GeolocationState>(
                    builder: (context, state) {
                      if (state is GeolocationLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GeolocationLoaded) {
                        return Map(
                          lat: state.position.latitude,
                          lng: state.position.altitude,
                        );
                      } else {
                        return Text(
                            'an_error_occurred_please_try_again_later'.tr);
                      }
                    },
                  ),
                ),
                const LocationSearch(),
                const SaveLocation(),
              ],
            );
          } else if (state is PlaceLoaded) {
            print('PlaceLoaded');
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Map(
                    lat: state.place.lat,
                    lng: state.place.lng,
                  ),
                ),
                const LocationSearch(),
                const SaveLocation(),
              ],
            );
          } else {
            return Text('an_error_occurred_please_try_again_later'.tr);
          }
        },
      ),
    );
  }
}

class LocationSearch extends StatelessWidget {
  const LocationSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Column(
        children: [
          const LocationSearchBox(),
          bloc.BlocBuilder<AutocompleteBloc, AutocompleteState>(
            builder: (context, state) {
              if (state is AutocompleteLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AutocompleteLoaded) {
                return state.autocomplete.isNotEmpty
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: ListView.builder(
                          itemCount: state.autocomplete.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(
                              state.autocomplete[index].description,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            onTap: () {
                              context.read<PlaceBloc>().add(
                                    LoadPlace(id: state.autocomplete[index].id),
                                  );
                            },
                          ),
                        ),
                      )
                    : Container();
              } else {
                return Text('an_error_occurred_please_try_again_later'.tr);
              }
            },
          ),
        ],
      ),
    );
  }
}

class SaveLocation extends StatelessWidget {
  const SaveLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 20,
      right: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            textStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
            shape: const StadiumBorder(),
          ),
          onPressed: () {},
          child: Text('save'.tr),
        ),
      ),
    );
  }
}

class Map extends StatelessWidget {
  final double lat;
  final double lng;
  const Map({super.key, required this.lat, required this.lng});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(lat, lng),
        zoom: 10,
      ),
    );
  }
}
