// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hotel _$HotelFromJson(Map<String, dynamic> json) => Hotel(
  hotelId: json['hotelId'] as String? ?? '', // Provide a default empty string
  location: json['location'] as String? ?? '', // Provide a default empty string
  amenities: (json['amenities'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList() ?? [], // Provide an empty list if null
  comment: (json['comment'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList() ?? [], // Provide an empty list if null
  description: json['description'] as String? ?? '', // Provide a default empty string
  hotelName: json['hotelName'] as String? ?? '', // Provide a default empty string
  imageUrl: (json['imageUrl'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList() ?? [], // Provide an empty list if null
  price: (json['price'] as num?)?.toDouble() ?? 0.0, // Provide a default value of 0.0
  rating: (json['rating'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList() ?? [], // Provide an empty list if null
  spaceRooms: (json['spaceRooms'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList() ?? [], // Provide an empty list if null
);

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
  'hotelId': instance.hotelId,
  'amenities': instance.amenities,
  'comment': instance.comment,
  'description': instance.description,
  'hotelName': instance.hotelName,
  'imageUrl': instance.imageUrl,
  'price': instance.price,
  'rating': instance.rating,
  'spaceRooms': instance.spaceRooms,
  'location': instance.location,
};

