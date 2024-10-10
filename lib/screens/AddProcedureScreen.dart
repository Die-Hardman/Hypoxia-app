import 'package:flutter/material.dart';
import '../models/Procedure.dart';

class AddProcedureScreen extends StatefulWidget {
  @override
  _AddProcedureScreenState createState() => _AddProcedureScreenState();
}

class _AddProcedureScreenState extends State<AddProcedureScreen> {
  final _patientNameController = TextEditingController();
  final _procedureNameController = TextEditingController();
  final _doctorNameController = TextEditingController();
  final List<TextEditingController> _heartRateControllers = List.generate(12, (_) => TextEditingController());
  final List<TextEditingController> _spo2Controllers = List.generate(12, (_) => TextEditingController());
  final List<TextEditingController> _respirationRateControllers = List.generate(12, (_) => TextEditingController());
  final List<TextEditingController> _oxygenConcentrationControllers = List.generate(12, (_) => TextEditingController());
  final List<TextEditingController> _co2Controllers = List.generate(12, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Додати Процедуру'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ім\'я Пацієнта:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: _patientNameController,
              decoration: InputDecoration(hintText: 'Введіть ім\'я пацієнта'),
            ),
            SizedBox(height: 16),
            Text('Назва Процедури:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: _procedureNameController,
              decoration: InputDecoration(hintText: 'Введіть назву процедури'),
            ),
            SizedBox(height: 16),
            Text('Ім\'я Лікаря:', style: TextStyle(fontSize: 16)),
            TextField(
              controller: _doctorNameController,
              decoration: InputDecoration(hintText: 'Введіть ім\'я лікаря'),
            ),
            SizedBox(height: 16),
            Text('Дані по процедурі (кожні 10 хв):', style: TextStyle(fontSize: 16)),
            Expanded(
              child: ListView.builder(
                itemCount: 12, // Кількість часових відрізків
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(child: Text('${(index + 1) * 10} хв', style: TextStyle(fontSize: 14))),
                          Expanded(child: TextField(controller: _heartRateControllers[index], decoration: InputDecoration(hintText: 'ЧСС'))),
                          Expanded(child: TextField(controller: _spo2Controllers[index], decoration: InputDecoration(hintText: 'SpO2'))),
                          Expanded(child: TextField(controller: _respirationRateControllers[index], decoration: InputDecoration(hintText: 'ЧД'))),
                          Expanded(child: TextField(controller: _oxygenConcentrationControllers[index], decoration: InputDecoration(hintText: 'Конц O2'))),
                          Expanded(child: TextField(controller: _co2Controllers[index], decoration: InputDecoration(hintText: 'Конц CO2'))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _saveProcedure,
              child: Text('Зберегти Процедуру'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveProcedure() {
    // Отримання даних з контролерів
    String patientName = _patientNameController.text;
    String procedureName = _procedureNameController.text;
    String doctorName = _doctorNameController.text;

    List<int?> heartRates = _heartRateControllers.map((controller) => int.tryParse(controller.text)).toList();
    List<double?> spo2 = _spo2Controllers.map((controller) => double.tryParse(controller.text)).toList();
    List<int?> respirationRates = _respirationRateControllers.map((controller) => int.tryParse(controller.text)).toList();
    List<double?> oxygenConcentrations = _oxygenConcentrationControllers.map((controller) => double.tryParse(controller.text)).toList();
    List<double?> co2Concentrations = _co2Controllers.map((controller) => double.tryParse(controller.text)).toList();

    // Створення нового об'єкта процедури
    Procedure(
      procedureName: 'Тест на дихання',
      patientName: 'John Doe',
      doctorName: 'Др. Сміт', // Додано ім'я лікаря
      time: '12:00 PM',
      heartRate: [70], // Передаємо список значень пульсу
      spo2: [98.0], // Передаємо список значень SpO2
      respirationRate: [16], // Передаємо список значень дихальної частоти
      oxygenConcentration: [95.0], // Передаємо список значень кисню
      carbonDioxideConcentration: [5.0], // Передаємо список значень CO2
    );

    // Збережіть нову процедуру (додайте код для збереження в базі даних або в пам'яті)
    // ...

    // Повернення назад або очищення полів
    Navigator.pop(context);
  }
}
