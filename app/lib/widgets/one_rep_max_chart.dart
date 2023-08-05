import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workspaces/classes/activity_type.dart';
import 'package:workspaces/classes/workout.dart';
import 'package:workspaces/classes/workouts.dart';

class OneRepMaxChart extends StatefulWidget {
  final ActivityType activityType;

  const OneRepMaxChart({super.key, required this.activityType});

  @override
  State<OneRepMaxChart> createState() => _OneRepMaxChartState();
}

class _OneRepMaxChartState extends State<OneRepMaxChart> {
  List<Color> gradientColors = [
    Colors.cyan,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    final timestampedActivities =
        context.watch<Workouts>().getAllActivityLogsWithTimestamp(
              widget.activityType,
            );

    if (timestampedActivities.length < 2) return Container();
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(data(timestampedActivities)),
          ),
        ),
      ],
    );
  }

  LineChartData data(List<TimestampedActivity> timestampedActivities) {
    final double minX = timestampedActivities
        .map((timestampedActivity) =>
            (timestampedActivity.timestamp.millisecondsSinceEpoch / 1000)
                .roundToDouble())
        .reduce(min);
    final double maxX = timestampedActivities
        .map((timestampedActivity) =>
            (timestampedActivity.timestamp.millisecondsSinceEpoch / 1000)
                .roundToDouble())
        .reduce(max);
    final double minY = timestampedActivities
        .map((timestampedActivity) => timestampedActivity
            .activity.sets[0].measurements[ActivityMeasurementType.reps]!)
        .reduce(min)
        .toDouble();
    final double maxY = timestampedActivities
        .map((timestampedActivity) => timestampedActivity
            .activity.sets[0].measurements[ActivityMeasurementType.reps]!)
        .reduce(max)
        .toDouble();

    final xInterval = (maxX - minX) / 5;

    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      minX: minX,
      maxX: maxX,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: timestampedActivities
              .map(
                (timestampedActivity) => FlSpot(
                  (timestampedActivity.timestamp.millisecondsSinceEpoch / 1000)
                      .roundToDouble(),
                  timestampedActivity.activity.sets[0]
                      .measurements[ActivityMeasurementType.reps]!
                      .toDouble(),
                ),
              )
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: xInterval,
            getTitlesWidget: (double value, TitleMeta meta) {
              const style = TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              );
              final dateTime =
                  DateTime.fromMillisecondsSinceEpoch((value * 1000).toInt());
              final formatter = DateFormat.MMMd();
              return SideTitleWidget(
                axisSide: meta.axisSide,
                child: Text(
                  formatter.format(dateTime),
                  style: style,
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                );
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    value.toInt().toString(),
                    style: style,
                  ),
                );
              }),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
    );
  }
}
