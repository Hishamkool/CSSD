// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_used_items_body_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostUsedItemsEntryModel _$PostUsedItemsEntryModelFromJson(
        Map<String, dynamic> json) =>
    PostUsedItemsEntryModel(
      uentry: (json['uentry'] as List<dynamic>)
          .map((e) => Uentry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostUsedItemsEntryModelToJson(
        PostUsedItemsEntryModel instance) =>
    <String, dynamic>{
      'uentry': instance.uentry,
    };

Uentry _$UentryFromJson(Map<String, dynamic> json) => Uentry(
      productId: (json['productId'] as num).toInt(),
      location: json['location'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$UentryToJson(Uentry instance) => <String, dynamic>{
      'productId': instance.productId,
      'location': instance.location,
      'quantity': instance.quantity,
    };
