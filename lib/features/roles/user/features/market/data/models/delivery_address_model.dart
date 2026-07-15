import '../../domain/entities/delivery_address_entity.dart';

class DeliveryAddressModel extends DeliveryAddressEntity {
  const DeliveryAddressModel({
    required super.id,
    required super.label,
    required super.address,
    super.isDefault = false,
  });

  factory DeliveryAddressModel.fromJson(Map<String, dynamic> json) {
    return DeliveryAddressModel(
      id: json['id'] as String,
      label: json['label'] as String,
      address: json['address'] as String,
      isDefault: json['isDefault'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'address': address,
      'isDefault': isDefault,
    };
  }
}
