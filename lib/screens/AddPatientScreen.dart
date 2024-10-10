import 'package:flutter/material.dart';

class AddPatientScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Додати Пацієнта',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF2F2FAF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Номер картки'),
              _buildTextField('Прізвище'),
              _buildTextField('Ім\'я'),
              _buildTextField('По-батькові'),
              _buildTextField('Дата народження'),
              _buildTextField('Зріст (см)'),
              _buildTextField('Вага (кг)'),
              _buildTextField('Стать'),
              _buildTextField('Адреса'),
              _buildTextField('Телефон'),
              _buildTextField('Email'),
              _buildTextField('Діагноз'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Логіка для збереження даних
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Пацієнт збережений')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2F2FAF), // Колір кнопки
                  foregroundColor: Colors.white, // Колір тексту кнопки
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text('Зберегти'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Будь ласка, введіть $label';
          }
          return null;
        },
      ),
    );
  }
}
