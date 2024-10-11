import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Patient.dart';

class EditPatientScreen extends StatefulWidget {
  final Patient patient;

  EditPatientScreen({required this.patient});

  @override
  _EditPatientScreenState createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  // Контролери для кожного поля
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController patronymicController;
  late TextEditingController dateOfBirthController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController addressController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController diagnosisController;

  String? selectedGender; // Для вибору статі

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.patient.firstName);
    lastNameController = TextEditingController(text: widget.patient.lastName);
    patronymicController = TextEditingController(text: widget.patient.middleName);
    dateOfBirthController = TextEditingController(text: widget.patient.birthDate.toString());
    heightController = TextEditingController(text: widget.patient.height.toString());
    weightController = TextEditingController(text: widget.patient.weight.toString());
    addressController = TextEditingController(text: widget.patient.address);
    phoneNumberController = TextEditingController(text: widget.patient.phone);
    emailController = TextEditingController(text: widget.patient.email);
    diagnosisController = TextEditingController(text: widget.patient.diagnosis);
    selectedGender = widget.patient.gender;
  }

  @override
  void dispose() {
    // Звільняємо ресурси
    firstNameController.dispose();
    lastNameController.dispose();
    patronymicController.dispose();
    dateOfBirthController.dispose();
    heightController.dispose();
    weightController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    diagnosisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редагування пацієнта'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(labelText: 'Ім\'я'),
              ),
              TextFormField(
                controller: lastNameController,
                decoration: InputDecoration(labelText: 'Прізвище'),
              ),
              TextFormField(
                controller: patronymicController,
                decoration: InputDecoration(labelText: 'По батькові'),
              ),
              TextFormField(
                controller: dateOfBirthController,
                decoration: InputDecoration(labelText: 'Дата народження'),
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                items: ['Чоловік', 'Жінка'].map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Стать'),
                onChanged: (newValue) {
                  setState(() {
                    selectedGender = newValue;
                  });
                },
              ),
              TextFormField(
                controller: heightController,
                decoration: InputDecoration(labelText: 'Зріст (см)'),
              ),
              TextFormField(
                controller: weightController,
                decoration: InputDecoration(labelText: 'Вага (кг)'),
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(labelText: 'Адреса'),
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: 'Номер телефону'),
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: diagnosisController,
                decoration: InputDecoration(labelText: 'Діагноз'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Логіка для збереження змін
                  // Можна отримати значення через контролери
                },
                child: Text('Зберегти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
