import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Для кастомних шрифтів

import '../models/Patient.dart';
import '../models/Procedure.dart';
import 'SearchScreen.dart';
import 'PatientDetailsScreen.dart'; // Екран деталей пацієнта
import 'ProcedureDetailsScreen.dart'; // Екран деталей процедури
import 'AddChoiceScreen.dart'; // Екран вибору додавання

class MainScreen extends StatelessWidget {
  // Список пацієнтів для прикладу
  final List<Patient> patients = [
    Patient(
      cardNumber: '123',
      lastName: 'Doe',
      firstName: 'John',
      middleName: 'Michael',
      birthDate: '01-01-1990',
      height: 180,
      weight: 75,
      gender: 'Чоловік',
      address: '123 Main St',
      phone: '+123456789',
      email: 'john.doe@example.com',
      diagnosis: 'Гіпертонія',
    ),
    // Додай інших пацієнтів за потреби
  ];

  // Список процедур для прикладу
  final List<Procedure> procedures = [
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
    ),
    // Додай інші процедури за потреби
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patient Management',
          style: GoogleFonts.lato(
            fontSize: 24,
            color: Colors.white, // Змінити колір тексту на білий
          ),
        ),
        backgroundColor: Color(0xFF2F2FAF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Покращена кнопка пошуку
                _buildStyledButton(
                  context,
                  label: 'Пошук',
                  icon: Icons.search,
                  color: Colors.blueAccent,
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                ),
                // Покращена кнопка додавання
                _buildStyledButton(
                  context,
                  label: 'Додати',
                  icon: Icons.add,
                  color: Colors.blueAccent,
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddChoiceScreen()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  // Список пацієнтів
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Пацієнти',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: patients.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text('${patients[index].firstName} ${patients[index].lastName}'),
                                  subtitle: Text('Номер картки: ${patients[index].cardNumber}'),
                                  onTap: () {
                                    // Відкриваємо екран деталей пацієнта
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PatientDetailsScreen(patient: patients[index]),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Список процедур
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'Процедури',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: procedures.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Icon(Icons.medical_services),
                                  title: Text(procedures[index].procedureName),
                                  subtitle: Text('Пацієнт: ${procedures[index].patientName}, Лікар: ${procedures[index].doctorName}'), // Додано ім'я лікаря
                                  onTap: () {
                                    // Відкриваємо екран деталей процедури
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProcedureDetailsScreen(procedure: procedures[index]),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Створення покращених кнопок з градієнтами та стилями
  Widget _buildStyledButton(BuildContext context,
      {required String label,
        required IconData icon,
        required Color color,
        required Gradient gradient,
        required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: Colors.white),
              SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.lato(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
