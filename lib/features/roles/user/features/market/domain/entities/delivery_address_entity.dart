class DeliveryAddressEntity {
  final String id;
  final String label;
  final String address;
  final bool isDefault;
  final String? fullName;
  final String? phoneNumber;
  final String? email;
  final String? city;
  final String? streetAddress;
  final String? specialInstruction;
  final double? latitude;
  final double? longitude;

  const DeliveryAddressEntity({
    required this.id,
    required this.label,
    required this.address,
    this.isDefault = false,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.city,
    this.streetAddress,
    this.specialInstruction,
    this.latitude,
    this.longitude,
  });
}
