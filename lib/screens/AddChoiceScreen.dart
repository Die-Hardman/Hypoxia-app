import 'package:flutter/material.dart';

import 'AddPatientScreen.dart';
import 'AddProcedureScreen.dart';

class AddChoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Додати нове',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF2F2FAF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Wrap(
            spacing: 20, // Простір між кнопками по горизонталі
            runSpacing: 20, // Простір між кнопками по вертикалі
            children: [
              _buildChoiceButton(context, 'Додати пацієнта', Icons.person_add, Colors.blue, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPatientScreen()),
                );
              }),
              _buildChoiceButton(context, 'Додати процедуру', Icons.add_chart, Colors.green, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProcedureScreen()),
                );
              }),
              // Можна додати ще кнопки, якщо треба
            ],
          ),
        ),
      ),
    );
  }

  // Метод для створення кнопок
  Widget _buildChoiceButton(
      BuildContext context, String label, IconData icon, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: 150, // Задаємо ширину кожної кнопки
      height: 150, // Задаємо висоту кожної кнопки
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: color, // Колір тексту та іконки
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Задаємо заокруглення кутів
          ),
          elevation: 5, // Додаємо тінь для кнопки
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Центруємо вміст по вертикалі
          children: [
            Icon(icon, size: 50), // Іконка кнопки
            SizedBox(height: 10), // Відступ між іконкою та текстом
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16), // Текст кнопки
            ),
          ],
        ),
      ),
    );
  }
}

// Це ваші екрани AddPatientScreen і AddProcedureScreen, щоб уникнути помилок

