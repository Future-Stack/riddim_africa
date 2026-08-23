class ChartDataPoint {
  final String label;
  final double value;
  final String percentageChange;
  final String dateSubtitle;

  const ChartDataPoint({
    required this.label,
    required this.value,
    this.percentageChange = '+0%',
    this.dateSubtitle = '',
  });
}

class ArtistRevenueEntity {
  final double totalRevenueMonth;
  final double revenueGrowthPercentage;
  final double settledRevenue;
  final double payoutInProgress;
  final String currency;
  final List<ChartDataPoint> weeklyAnalytics;
  final List<ChartDataPoint> monthlyAnalytics;
  final List<ChartDataPoint> yearlyAnalytics;

  const ArtistRevenueEntity({
    required this.totalRevenueMonth,
    required this.revenueGrowthPercentage,
    required this.settledRevenue,
    required this.payoutInProgress,
    this.currency = 'UGX',
    this.weeklyAnalytics = const [],
    this.monthlyAnalytics = const [],
    this.yearlyAnalytics = const [],
  });
}
