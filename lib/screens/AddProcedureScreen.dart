import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Для форматування дати
import '../models/Procedure.dart';
import 'package:google_fonts/google_fonts.dart';

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

  DateTime? _selectedDate; // Змінна для дати процедури

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Додати Процедуру',
          style: GoogleFonts.lato(
          fontSize: 24,
          color: Colors.white,
        ),),
          backgroundColor: Color(0xFF2F2FAF),
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
            Text('Дата Процедури:', style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'Виберіть дату'
                        : DateFormat('yyyy-MM-dd').format(_selectedDate!), // Форматування дати
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _selectDate,
                ),
              ],
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

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
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

    // Перевірка, чи вибрана дата
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Будь ласка, виберіть дату процедури.')));
      return;
    }

    // Створення нового об'єкта процедури
    Procedure newProcedure = Procedure(
      procedureName: procedureName,
      patientName: patientName,
      doctorName: doctorName,
      procedureDate: _selectedDate!, // Передаємо вибрану дату
      time: '12:00 PM', // Час можна додати пізніше або налаштувати окремо
      heartRate: heartRates.cast<int>(), // Перетворюємо nullable List на List<int>
      spo2: spo2.cast<double>(),
      respirationRate: respirationRates.cast<int>(),
      oxygenConcentration: oxygenConcentrations.cast<double>(),
      carbonDioxideConcentration: co2Concentrations.cast<double>(),
    );

    // Збережіть нову процедуру (додайте код для збереження в базі даних або в пам'яті)
    // ...

    // Повернення назад або очищення полів
    Navigator.pop(context);
  }
}
