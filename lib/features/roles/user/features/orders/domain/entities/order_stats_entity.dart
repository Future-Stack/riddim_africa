class OrderStatsEntity {
  final int total;
  final int processing;
  final int shipped;
  final int delivered;

  const OrderStatsEntity({
    this.total = 0,
    this.processing = 0,
    this.shipped = 0,
    this.delivered = 0,
  });
}
