class Procedure {
  final String procedureName;
  final String patientName;
  final DateTime procedureDate; // Дата процедури
  final String time;
  final List<int> heartRate; // Список значень пульсу
  final List<double> spo2; // Список значень SpO2
  final List<int> respirationRate; // Список значень дихальної частоти
  final List<double> oxygenConcentration; // Список значень концентрації кисню
  final List<double> carbonDioxideConcentration; // Список значень концентрації CO2
  final String doctorName; // Ім'я лікаря

  Procedure({
    required this.procedureName,
    required this.patientName,
    required this.procedureDate, // Додаємо до конструктора
    required this.time,
    required this.heartRate,
    required this.spo2,
    required this.respirationRate,
    required this.oxygenConcentration,
    required this.carbonDioxideConcentration,
    required this.doctorName,
  });
}
