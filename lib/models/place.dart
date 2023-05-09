class Place {
  final String id;
  final String name;
  final double lat;
  final double lng;

  Place({
    this.id = '',
    this.name = '',
    required this.lat,
    required this.lng,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['place_id'],
      name: json['formatted_address'],
      lat: json['geometry']['location']['lat'],
      lng: json['geometry']['location']['lng'],
    );
  }
}
