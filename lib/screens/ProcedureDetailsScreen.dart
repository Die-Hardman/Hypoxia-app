import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/Procedure.dart';
import 'package:intl/intl.dart'; // Для форматування дати
import 'package:google_fonts/google_fonts.dart';

class ProcedureDetailsScreen extends StatelessWidget {
  final Procedure procedure;

  const ProcedureDetailsScreen({Key? key, required this.procedure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<int> timeIntervals = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170];

    // Приклад даних
    final List<int?> heartRates = [70, 72, 75, 73, 74, 76, 78, 79, 80, 82, 85, 84, 86, 88, 87, 89, 90];
    final List<double?> spo2 = [98.0, 97.5, 97.0, 96.8, 96.5, 96.2, 96.0, 95.8, 95.6, 95.4, 95.3, 95.1, 95.0, 94.8, 94.5, 94.3, 94.0];
    final List<int?> respirationRates = [16, 17, 18, 17, 16, 17, 18, 19, 20, 19, 18, 19, 20, 21, 20, 19, 18];
    final List<double?> oxygenConcentrations = [95.0, 94.8, 94.5, 94.3, 94.0, 93.8, 93.6, 93.4, 93.2, 93.0, 92.8, 92.5, 92.3, 92.0, 91.8, 91.5, 91.3];
    final List<double?> co2Concentrations = [5.0, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8, 5.9, 6.0, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6];

    // Форматування дати
    String formattedDate = DateFormat('dd.MM.yyyy').format(procedure.procedureDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Деталі Процедури',
          style: GoogleFonts.lato(
          fontSize: 24,
          color: Colors.white,
        ),),
        backgroundColor: Color(0xFF2F2FAF),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Пацієнт: ${procedure.patientName}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Лікар: ${procedure.doctorName}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Дата процедури: $formattedDate', // Дата процедури
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              // Таблиця з деталями процедури
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Час (хв)')),
                    DataColumn(label: Text('ЧСС')),
                    DataColumn(label: Text('SpO2')),
                    DataColumn(label: Text('ЧД')),
                    DataColumn(label: Text('Конц O2')),
                    DataColumn(label: Text('Конц CO2')),
                  ],
                  rows: List<DataRow>.generate(timeIntervals.length, (index) {
                    return DataRow(
                      cells: [
                        DataCell(Text(timeIntervals[index].toString())),
                        DataCell(Text(heartRates[index]?.toString() ?? 'N/A')),
                        DataCell(Text(spo2[index]?.toString() ?? 'N/A')),
                        DataCell(Text(respirationRates[index]?.toString() ?? 'N/A')),
                        DataCell(Text(oxygenConcentrations[index]?.toString() ?? 'N/A')),
                        DataCell(Text(co2Concentrations[index]?.toString() ?? 'N/A')),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(height: 32),
              // Графік для ЧСС
              buildChart('Графік ЧСС', heartRates, timeIntervals, Colors.red, 100),
              SizedBox(height: 32),
              // Графік для SpO2
              buildChart('Графік SpO2', spo2, timeIntervals, Colors.blue, 100),
              SizedBox(height: 32),
              // Графік для ЧД
              buildChart('Графік ЧД', respirationRates, timeIntervals, Colors.green, 50),
              SizedBox(height: 32),
              // Графік для концентрації O2
              buildChart('Графік Концентрації O2', oxygenConcentrations, timeIntervals, Colors.orange, 100),
              SizedBox(height: 32),
              // Графік для концентрації CO2
              buildChart('Графік Концентрації CO2', co2Concentrations, timeIntervals, Colors.purple, 10),
            ],
          ),
        ),
      ),
    );
  }

  // Метод для побудови графіка
  Widget buildChart(String title, List<dynamic>? dataPoints, List<int> timeIntervals, Color color, double maxY) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: true),
              borderData: FlBorderData(show: true),
              minX: timeIntervals.first.toDouble(),
              maxX: timeIntervals.last.toDouble(),
              minY: 0,
              maxY: maxY,
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(dataPoints!.length, (index) {
                    return FlSpot(
                      timeIntervals[index].toDouble(),
                      dataPoints[index]?.toDouble() ?? 0,
                    );
                  }),
                  isCurved: true,
                  color: color,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
