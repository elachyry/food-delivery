class PlaceAutoComplete {
  final String id;
  final String description;

  PlaceAutoComplete({
    required this.id,
    required this.description,
  });

  factory PlaceAutoComplete.fromJson(Map<String, dynamic> json) {
    return PlaceAutoComplete(
      id: json['place_id'],
      description: json['description'],
    );
  }
}
