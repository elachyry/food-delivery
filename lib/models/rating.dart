import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final String id;
  final String custmerId;
  final double rate;
  final String comment;

  const Rating({
    this.id = '',
    required this.custmerId,
    required this.rate,
    required this.comment,
  });

  factory Rating.fromFirestore(DocumentSnapshot snap) {
    // print('id ${snap.id}');
    // print('custmerId ${snap['custmerId']}');
    // print('stars ${snap['stars']}');
    // print('comment ${snap['comment']}');
    return Rating(
      id: snap.id,
      custmerId: snap['custmerId'],
      rate: snap['stars'],
      comment: snap['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'custmerId': custmerId,
      'stars': rate,
      'comment': comment,
    };
  }

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      custmerId: json['custmerId'],
      rate: json['rating'].toDouble(),
      comment: json['comment'],
    );
  }

  @override
  List<Object?> get props => [id, custmerId, rate, comment];
}
