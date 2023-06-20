import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:geocoder2/geocoder2.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:location/location.dart' as loc;
import 'package:location/location.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:food_delivery_express/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:food_delivery_express/blocs/geolocation/geolocation_bloc.dart';
import 'package:food_delivery_express/widgets/location/location_search_box.dart';

import '../../blocs/place/place_bloc.dart';
import '../../utils/constants/image_constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LatLng? destenation = const LatLng(23.705781388493826, -15.942762382328512);
  Location location = Location();
  loc.LocationData? _currentPosition;
  final Completer<GoogleMapController?> _controller = Completer();
  String? _address;

  final searchController = TextEditingController();
  bool satelliteMode = false;
  bool isClear = true;

  @override
  void initState() {
    super.initState();
    // getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          ),
          bloc.BlocBuilder<AutocompleteBloc, AutocompleteState>(
            builder: (context, state) {
              if (state is AutocompleteLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AutocompleteLoaded) {
                return Expanded(
                  child: Container(
                    // margin: const EdgeInsets.symmetric(),
                    padding: const EdgeInsets.only(
                      right: 12,
                    ),
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.black)),
                    alignment: Alignment.center,
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: !isClear
                            ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    context
                                        .read<AutocompleteBloc>()
                                        .add(const LoadAutocomplete(input: ''));
                                    searchController.clear();
                                    isClear = true;
                                  });
                                },
                                icon: const Icon(
                                  Icons.clear,
                                ),
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'enter_your_location'.tr,
                        // contentPadding: const EdgeInsets.only(
                        //     bottom: 5, right: 5, left: 20),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 0.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isClear = false;
                        });
                        context
                            .read<AutocompleteBloc>()
                            .add(LoadAutocomplete(input: value));
                      },
                    ),
                  ),
                );
              } else {
                return Text('an_error_occurred_please_try_again_later'.tr);
              }
            },
          ),
        ],
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          bloc.BlocBuilder<PlaceBloc, PlaceState>(
            builder: (context, state) {
              if (state is PlaceLoading) {
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: destenation!,
                        zoom: 16,
                      ),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      mapType: satelliteMode ? MapType.hybrid : MapType.normal,
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition? position) {
                        if (destenation != position!.target) {
                          setState(() {
                            destenation = position.target;
                          });
                        }
                      },
                      onCameraIdle: () => getAddressFromLatLng(),
                      // onTap: (latLng) => print(latLng),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ));

                // const LocationSearch(),
                // const SaveLocation(),
              } else if (state is PlaceLoaded) {
                // setState(() {
                // });
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  destenation = LatLng(state.place.lat, state.place.lng);
                });
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: GoogleMap(
                    mapType: satelliteMode ? MapType.hybrid : MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    onCameraMove: (CameraPosition? position) {
                      if (destenation != position!.target) {
                        setState(() {
                          destenation = position.target;
                        });
                      }
                    },
                    onCameraIdle: () => getAddressFromLatLng(),
                    initialCameraPosition: CameraPosition(
                      target: LatLng(state.place.lat, state.place.lng),
                      zoom: 16,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                );
                // const LocationSearch(),
                // const SaveLocation()
              } else {
                return Text('an_error_occurred_please_try_again_later'.tr);
              }
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              ImageConstants.mapMarker,
              height: 45,
              width: 45,
            ),
          ),
          Positioned(
            right: 10,
            bottom: MediaQuery.of(context).size.height * 0.22 + 10,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              // padding: const EdgeInsets.all(8),
              child: IconButton(
                icon: Icon(
                  Icons.satellite_alt_outlined,
                  color:
                      satelliteMode ? Theme.of(context).primaryColorDark : null,
                ),
                onPressed: () {
                  setState(() {
                    satelliteMode = !satelliteMode;
                  });
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.22,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 15, right: 15, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Delivery Location',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Icon(
                            Bootstrap.geo,
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 13,
                          child: Text(
                            _address ?? 'Pick your destenation address',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                              // shape: const StadiumBorder(),
                            ),
                            onPressed: _address == null ? null : () {},
                            child: Text('Delivery here'.tr),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
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
                              print('id ${state.autocomplete[index].id}');
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

  getAddressFromLatLng() async {
    try {
      GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: destenation!.latitude,
        longitude: destenation!.longitude,
        googleMapApiKey: 'AIzaSyA52adhAtOF_JtvChF7AXSaHwLqNRd5ozE',
      );
      setState(() {
        _address = data.address;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    final GoogleMapController? controller = await _controller.future;

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    if (permissionGranted == loc.PermissionStatus.granted) {
      location.changeSettings(accuracy: loc.LocationAccuracy.high);
      _currentPosition = await location.getLocation();
      controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              _currentPosition!.latitude as double,
              _currentPosition!.longitude as double,
            ),
            zoom: 16,
          ),
        ),
      );
      setState(() {
        destenation = LatLng(
          _currentPosition!.latitude as double,
          _currentPosition!.longitude as double,
        );
      });
    }
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
