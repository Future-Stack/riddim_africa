import '../../domain/entities/artist_revenue_entity.dart';

class ArtistRevenueModel extends ArtistRevenueEntity {
  const ArtistRevenueModel({
    required super.totalRevenueMonth,
    required super.revenueGrowthPercentage,
    required super.settledRevenue,
    required super.payoutInProgress,
    super.currency,
    super.weeklyAnalytics,
    super.monthlyAnalytics,
    super.yearlyAnalytics,
  });

  factory ArtistRevenueModel.fromJson(Map<String, dynamic> json) {
    List<ChartDataPoint> parsePoints(dynamic list) {
      if (list is List) {
        return list.map((item) {
          return ChartDataPoint(
            label: item['label'] ?? '',
            value: (item['value'] as num?)?.toDouble() ?? 0.0,
            percentageChange: item['percentage_change'] ?? '+0%',
            dateSubtitle: item['date_subtitle'] ?? '',
          );
        }).toList();
      }
      return [];
    }

    return ArtistRevenueModel(
      totalRevenueMonth:
          (json['total_revenue_month'] as num?)?.toDouble() ?? 234500.0,
      revenueGrowthPercentage:
          (json['revenue_growth_percentage'] as num?)?.toDouble() ?? 18.0,
      settledRevenue:
          (json['settled_revenue'] as num?)?.toDouble() ?? 189200.0,
      payoutInProgress:
          (json['payout_in_progress'] as num?)?.toDouble() ?? 45300.0,
      currency: json['currency'] ?? 'UGX',
      weeklyAnalytics: parsePoints(json['weekly_analytics']),
      monthlyAnalytics: parsePoints(json['monthly_analytics']),
      yearlyAnalytics: parsePoints(json['yearly_analytics']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_revenue_month': totalRevenueMonth,
      'revenue_growth_percentage': revenueGrowthPercentage,
      'settled_revenue': settledRevenue,
      'payout_in_progress': payoutInProgress,
      'currency': currency,
    };
  }

  static ArtistRevenueModel mockData() {
    return const ArtistRevenueModel(
      totalRevenueMonth: 234500.0,
      revenueGrowthPercentage: 18.0,
      settledRevenue: 189200.0,
      payoutInProgress: 45300.0,
      currency: 'UGX',
      monthlyAnalytics: [
        ChartDataPoint(
          label: 'Jan',
          value: 120000,
          percentageChange: '+12% Than Last Month',
          dateSubtitle: 'Jan 2026',
        ),
        ChartDataPoint(
          label: 'Feb',
          value: 165000,
          percentageChange: '+24% Than Last Month',
          dateSubtitle: 'Feb 2026',
        ),
        ChartDataPoint(
          label: 'Mar',
          value: 140000,
          percentageChange: '-15% Than Last Month',
          dateSubtitle: 'Mar 2026',
        ),
        ChartDataPoint(
          label: 'Apr',
          value: 190000,
          percentageChange: '+35% Than Last Month',
          dateSubtitle: 'Apr 2026',
        ),
        ChartDataPoint(
          label: 'May',
          value: 210000,
          percentageChange: '+10% Than Last Month',
          dateSubtitle: 'May 2026',
        ),
        ChartDataPoint(
          label: 'Jun',
          value: 380000,
          percentageChange: '+80% Than Last Month',
          dateSubtitle: 'Jun 2026',
        ),
      ],
      yearlyAnalytics: [
        ChartDataPoint(
          label: 'Jan',
          value: 120000,
          percentageChange: '+12% Than Last Month',
          dateSubtitle: 'Jan 2026',
        ),
        ChartDataPoint(
          label: 'Feb',
          value: 165000,
          percentageChange: '+24% Than Last Month',
          dateSubtitle: 'Feb 2026',
        ),
        ChartDataPoint(
          label: 'Mar',
          value: 135000,
          percentageChange: '-18% Than Last Month',
          dateSubtitle: 'Mar 2026',
        ),
        ChartDataPoint(
          label: 'Apr',
          value: 195000,
          percentageChange: '+44% Than Last Month',
          dateSubtitle: 'Apr 2026',
        ),
        ChartDataPoint(
          label: 'May',
          value: 230000,
          percentageChange: '+18% Than Last Month',
          dateSubtitle: 'May 2026',
        ),
        ChartDataPoint(
          label: 'Jun',
          value: 395000,
          percentageChange: '+71% Than Last Month',
          dateSubtitle: 'Jun 2026',
        ),
      ],
      weeklyAnalytics: [
        ChartDataPoint(
          label: '1-5',
          value: 45000,
          percentageChange: '+5% This Week',
          dateSubtitle: 'Week 1',
        ),
        ChartDataPoint(
          label: '6-10',
          value: 95000,
          percentageChange: '+110% This Week',
          dateSubtitle: 'Week 2',
        ),
        ChartDataPoint(
          label: '11-15',
          value: 165000,
          percentageChange: '+73% This Week',
          dateSubtitle: 'Week 3',
        ),
        ChartDataPoint(
          label: '16-20',
          value: 120000,
          percentageChange: '-27% This Week',
          dateSubtitle: 'Week 4',
        ),
        ChartDataPoint(
          label: '21-25',
          value: 180000,
          percentageChange: '+50% This Week',
          dateSubtitle: 'Week 5',
        ),
        ChartDataPoint(
          label: '26-30',
          value: 210000,
          percentageChange: '+16% This Week',
          dateSubtitle: 'Week 6',
        ),
      ],
    );
  }
}
