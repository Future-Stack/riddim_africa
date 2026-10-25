import '../../domain/entities/delivery_address_entity.dart';

class DeliveryAddressModel extends DeliveryAddressEntity {
  const DeliveryAddressModel({
    required super.id,
    required super.label,
    required super.address,
    super.isDefault = false,
    super.fullName,
    super.phoneNumber,
    super.email,
    super.city,
    super.streetAddress,
    super.specialInstruction,
    super.latitude,
    super.longitude,
  });

  factory DeliveryAddressModel.fromJson(Map<String, dynamic> json) {
    final street = json['streetAddress'] as String? ?? '';
    final city = json['city'] as String? ?? '';
    final fullAddr = json['address'] as String? ??
        (street.isNotEmpty && city.isNotEmpty
            ? '$street, $city'
            : (street.isNotEmpty ? street : city));

    return DeliveryAddressModel(
      id: (json['shippingInfoId'] ?? json['id'] ?? '').toString(),
      label: (json['label'] ?? 'HOME').toString(),
      address: fullAddr,
      isDefault: json['isDefault'] as bool? ?? false,
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      city: json['city'] as String?,
      streetAddress: json['streetAddress'] as String?,
      specialInstruction: json['specialInstruction'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'fullName': fullName ?? '',
      'phoneNumber': phoneNumber ?? '',
      'email': email ?? '',
      'city': city ?? '',
      'streetAddress': streetAddress ?? address,
      'specialInstruction': specialInstruction ?? '',
      'latitude': latitude ?? 0.3236,
      'longitude': longitude ?? 32.5806,
      'isDefault': isDefault,
    };
  }
}
