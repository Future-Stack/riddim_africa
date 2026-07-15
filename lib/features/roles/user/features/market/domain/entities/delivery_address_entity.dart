class DeliveryAddressEntity {
  final String id;
  final String label;
  final String address;
  final bool isDefault;

  const DeliveryAddressEntity({
    required this.id,
    required this.label,
    required this.address,
    this.isDefault = false,
  });
}
