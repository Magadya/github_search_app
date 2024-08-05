import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:github_search_app/core/resources/styles/colors.dart';

class _BarChart extends StatelessWidget {
  const _BarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: _barTouchData,
        titlesData: _titlesData,
        borderData: _borderData,
        barGroups: _barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 20,
      ),
    );
  }

  BarTouchData get _barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 2,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: defaultAppColor,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget _getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: defaultLightBlack,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    final text = _getTitleForValue(value);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  String _getTitleForValue(double value) {
    switch (value.toInt()) {
      case 0:
        return '1';
      case 3:
        return '15';
      default:
        return value == 6 ? '30' : '';
    }
  }

  FlTitlesData get _titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: _getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get _borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          defaultLightTealColor.withOpacity(0.6),
          defaultLightTealColor,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get _barGroups => [
        _buildBarGroup(0, 8),
        _buildBarGroup(1, 10),
        _buildBarGroup(2, 14),
        _buildBarGroup(3, 15),
        _buildBarGroup(4, 13),
        _buildBarGroup(5, 10),
        _buildBarGroup(6, 16),
      ];

  BarChartGroupData _buildBarGroup(int x, double y) => BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            toY: y,
            gradient: _barsGradient,
          ),
        ],
        showingTooltipIndicators: [0],
      );
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => _BarChartSample3State();
}

class _BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return _BarChart();
  }
}
