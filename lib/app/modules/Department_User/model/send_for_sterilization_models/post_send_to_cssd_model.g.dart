// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_send_to_cssd_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSendToCssd _$PostSendToCssdFromJson(Map<String, dynamic> json) =>
    PostSendToCssd(
      location: json['location'] as String,
      priority: json['priority'] as String,
      remarks: json['Remarks'] as String,
      sendcssditems: (json['sendcssditems'] as List<dynamic>)
          .map((e) => Sendcssditem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostSendToCssdToJson(PostSendToCssd instance) =>
    <String, dynamic>{
      'location': instance.location,
      'priority': instance.priority,
      'Remarks': instance.remarks,
      'sendcssditems': instance.sendcssditems,
    };

Sendcssditem _$SendcssditemFromJson(Map<String, dynamic> json) => Sendcssditem(
      productname: json['Productname'] as String,
      productId: (json['ProductId'] as num).toInt(),
      qty: (json['Qty'] as num).toInt(),
    );

Map<String, dynamic> _$SendcssditemToJson(Sendcssditem instance) =>
    <String, dynamic>{
      'Productname': instance.productname,
      'ProductId': instance.productId,
      'Qty': instance.qty,
    };
