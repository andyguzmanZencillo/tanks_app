import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_repository/tank_repository.dart';
import 'package:tanks_app/core/app/themes/app_colors.dart';
import 'package:tanks_app/features/home/dashboard/cubit/dashboard_cubit.dart';
import 'package:tanks_app/features/tank_variation/list/cubit/tank_variation_cubit.dart';

class Graft extends StatelessWidget {
  const Graft({super.key});

  @override
  Widget build(BuildContext context) {
    final dashBoard = context.read<DashboardCubit>();
    LineChartData getGraft(
      List<SalesData> chartData1,
      List<SalesData> chartData2,
    ) {
      final spots1 = chartData1
          .map(
            (e) => FlSpot(
              e.year.toDouble(),
              e.sales,
            ),
          )
          .toList();

      final spots2 = chartData2
          .map(
            (e) => FlSpot(
              e.year.toDouble(),
              e.sales,
            ),
          )
          .toList();

      final data = LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: const Color.fromARGB(255, 206, 206, 206),

            showOnTopOfTheChartBoxArea: true,
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((spot) {
                return LineTooltipItem(
                  'Año: ${spot.x.toInt()} ',
                  const TextStyle(color: Colors.black, fontSize: 12),
                );
              }).toList();
            },
            fitInsideHorizontally: true, // Ajusta horizontalmente
            fitInsideVertically: true, // Ajusta verticalmente
          ),
        ),
        gridData: FlGridData(
          verticalInterval: 1,
          horizontalInterval: 10,
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.grey.shade200,
              strokeWidth: 1,
            );
          },
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Color.fromARGB(255, 241, 241, 241),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    value.toInt().toString(), // Mostrar el año en el eje X
                    style: TextStyle(
                      color: Colors.black.withOpacity(.4),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      color: Colors.black.withOpacity(.4),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            color: BlueStoneColors.blueStone400,
            spots: spots1,
            isCurved: true,
            isStrokeCapRound: true,
          ),
          LineChartBarData(
            color: BlueStoneColors.blueStone700,
            spots: spots2,
            isCurved: true,
            isStrokeCapRound: true,
          ),
        ],
      );
      return data;
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: SizedBox(
        height: 170,
        child: BlocSelector<TankVariationCubit, TankVariationState,
            List<TankVariationEntity>>(
          selector: (state) {
            return state.consoles;
          },
          builder: (context, state) {
            if (state.isEmpty) return const SizedBox.shrink();
            final listAgua = state
                .map(
                  (e) => SalesData(e.fechaZ?.day ?? 0, e.aguaFinal),
                )
                .toList();

            final inventarioFinalList = state
                .map(
                  (e) => SalesData(e.fechaZ?.day ?? 0, e.inventarioFinalFisico),
                )
                .toList();

            return LineChart(getGraft(listAgua, inventarioFinalList));
          },
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final int year;
  final double sales;
}
