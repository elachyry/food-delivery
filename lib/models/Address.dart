import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String id;
  final String address;
  final String phoneNumber;
  const Address({
    required this.id,
    required this.address,
    required this.phoneNumber,
  });

  Address copyWith({
    String? id,
    String? address,
    String? phoneNumber,
  }) {
    return Address(
      id: id ?? this.id,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as String,
      address: map['address'] as String,
      phoneNumber: map['phoneNumber'] as String,
    );
  }

  @override
  List<Object> get props => [
        id,
        address,
        phoneNumber,
      ];
}
