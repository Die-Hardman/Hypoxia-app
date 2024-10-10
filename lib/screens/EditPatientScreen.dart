import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Patient.dart';

class EditPatientScreen extends StatelessWidget {
  final Patient patient; // Оголошуємо поле для пацієнта

  // Конструктор із обов'язковим параметром patient
  EditPatientScreen({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редагування пацієнта'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Приклад відображення інформації про пацієнта
            TextFormField(
              initialValue: patient.firstName,
              decoration: InputDecoration(labelText: 'Ім\'я'),
            ),
            TextFormField(
              initialValue: patient.lastName,
              decoration: InputDecoration(labelText: 'Прізвище'),
            ),
            // Додай інші поля для редагування пацієнта...
            ElevatedButton(
              onPressed: () {
                // Логіка для збереження змін
              },
              child: Text('Зберегти'),
            ),
          ],
        ),
      ),
    );
  }
}
