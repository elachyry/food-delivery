import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as loc;

import 'package:multi_languges/repositories/place/place_repository.dart';
import 'package:multi_languges/utils/constants/image_constants.dart';
import 'package:http/http.dart' as http;

import '../../controllers/location_controller.dart';
import '../../models/place.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final String key = 'AIzaSyA52adhAtOF_JtvChF7AXSaHwLqNRd5ozE';

  LatLng? destenation = const LatLng(23.705781388493826, -15.942762382328512);
  Location location = Location();
  loc.LocationData? _currentPosition;
  final Completer<GoogleMapController?> _controller = Completer();
  String? _address;

  final searchController = TextEditingController();
  final focusNode = FocusNode();

  bool satelliteMode = false;
  // bool outOfCity = false;
  // bool isClear = true;

  final locationController = Get.put(LocationController());

  GoogleMapController? mapController;

  // List<PlaceAutoComplete> autoComplete = [];
  Place? searchPlace;
  double cityRange = 0.0;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
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
          Expanded(
            child: Container(
              // margin: const EdgeInsets.symmetric(),
              padding: const EdgeInsets.only(
                right: 12,
              ),
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.black)),
              alignment: Alignment.center,
              child: Obx(
                () => TextField(
                  controller: searchController,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: !locationController.isClear.value
                        ? IconButton(
                            onPressed: () {
                              // setState(() {
                              //   searchController.clear();
                              // });
                              locationController.isClear.value = true;
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
                      // print('value $value');
                      locationController.getAutoCompleteList(value);
                      // print('auto complete loist $autoComplete');

                      if (value.isEmpty) {
                        locationController.isClear.value = true;
                      } else {
                        locationController.isClear.value = false;
                      }
                    });
                    // context
                    //     .read<AutocompleteBloc>()
                    //     .add(LoadAutocomplete(input: value));
                  },
                ),
              ),
            ),
          )
        ],
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          GoogleMap(
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
            onCameraIdle: () async {
              locationController.isLoading.value = true;

              getAddressFromLatLng();
              await checkLocationRange(
                  destenation!.latitude, destenation!.longitude);
              locationController.isLoading.value = false;

              // print('isInRange $isInRange');
              // if (!isInRange) {
              //   setState(() {
              //     outOfCity = false;
              //   });
              // } else {
              //   setState(() {
              //     outOfCity = true;
              //   });
              // }
            },
            // onTap: (latLng) => print(latLng),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                mapController = controller;
              });
              _controller.complete(controller);
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

          // Positioned(
          //   top: 40,
          //   right: 20,
          //   left: 20,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         color: Colors.black,
          //       ),
          //       color: Colors.white,
          //     ),
          //     padding: const EdgeInsets.all(20),
          //     child: Text(
          //       _address ?? 'Pick your destenation address',
          //       overflow: TextOverflow.visible,
          //       softWrap: true,
          //     ),
          //   ),
          // ),

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
                          child: Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                                // shape: const StadiumBorder(),
                              ),
                              onPressed: _address == null ||
                                      !locationController.isWithinRange.value ||
                                      locationController.isLoading.value
                                  ? null
                                  : () {},
                              child: locationController.isLoading.value
                                  ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : Text(!locationController.isWithinRange.value
                                      ? 'Sorry, we don\'t deliver here'
                                      : 'Delivery here'.tr),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),

          Obx(() {
            if (locationController.autoComplete.isEmpty ||
                locationController.isClear.value) {
              return Container();
            }
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: ListView.builder(
                itemCount: locationController.autoComplete.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    locationController.autoComplete[index].description,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  onTap: () async {
                    focusNode.unfocus();
                    // getPlace(locationController.autoComplete[index].id);
                    final place = await PlaceRepository()
                        .getPlace(locationController.autoComplete[index].id);
                    setState(() {
                      destenation = LatLng(place.lat, place.lng);
                    });
                    // final GoogleMapController? controller =
                    //     await _controller.future;

                    // controller?.animateCamera(
                    //   CameraUpdate.newCameraPosition(
                    //     CameraPosition(
                    //       target: destenation!,
                    //       zoom: 16,
                    //     ),
                    //   ),
                    // );

                    if (mapController != null) {
                      await mapController!.animateCamera(
                        CameraUpdate.newLatLngZoom(destenation!, 16),
                      );
                    }
                    // print(
                    //     'Place id ${locationController.autoComplete[index].description}');
                    // print('Place on tap ${searchPlace}');
                    locationController.isClear.value = true;

                    searchController.clear();
                    // context.read<PlaceBloc>().add(
                    //       LoadPlace(id: state.autocomplete[index].id),
                    //     );
                  },
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  // getAutoCompleteList(String input) async {
  //   autoComplete = [];
  //   PlaceRepository placeRepository = PlaceRepository();
  //   autoComplete = await placeRepository.getAutocomplete(input);
  //   print('auto complete $autoComplete');
  // }

  // getPlace(String id) async {
  //   print('search place id $id');
  //   PlaceRepository placeRepository = PlaceRepository();
  //   searchPlace = await placeRepository.getPlace(id);
  //   print('search place id ${searchPlace!.name}');
  // }

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
      locationController.isLoading.value = false;

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

  Future<void> checkLocationRange(double userLat, double userLng) async {
    const String city = 'Dakhla'; // Replace with the desired city name

    final geocodingUrl = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=$city&key=$key');

    final geocodingResponse = await http.get(geocodingUrl);
    final geocodingData = json.decode(geocodingResponse.body);

    // print('geocodingData $geocodingData');
    final double latitude =
        geocodingData['results'][0]['geometry']['location']['lat'];
    final double longitude =
        geocodingData['results'][0]['geometry']['location']['lng'];

    final String placeId = geocodingData['results'][0]['place_id'];

    final placesUrl = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key');

    final placesResponse = await http.get(placesUrl);
    final placesData = json.decode(placesResponse.body);

    final Map<String, dynamic> boundaries =
        placesData['result']['geometry']['viewport']['northeast'];

    final double boundaryLatitude = boundaries['lat'];
    final double boundaryLongitude = boundaries['lng'];

    // print('boundaryLatitude $boundaryLatitude');
    // print('boundaryLongitude $boundaryLongitude');

    const double radius = 6371; // Earth's radius in kilometers

    final double centerDistance = calculateDistance(
        latitude, longitude, boundaryLatitude, boundaryLongitude, radius);
    final double locationDistance =
        calculateDistance(latitude, longitude, userLat, userLng, radius);
    // print(
    //     'locationDistance <= centerDistance ${locationDistance <= centerDistance}');

    setState(() {
      cityRange = centerDistance;
      locationController.isWithinRange.value =
          locationDistance <= centerDistance;
    });
  }

  double calculateDistance(
      double lat1, double lon1, double lat2, double lon2, double radius) {
    final double dLat = radians(lat2 - lat1);
    final double dLon = radians(lon2 - lon1);

    final double a = pow(sin(dLat / 2), 2) +
        cos(radians(lat1)) * cos(radians(lat2)) * pow(sin(dLon / 2), 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return radius * c;
  }

  double radians(double degrees) {
    return degrees * (pi / 180);
  }
}
