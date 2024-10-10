import 'package:flutter/material.dart';

import '../models/Patient.dart';
import 'EditPatientScreen.dart';

class PatientDetailsScreen extends StatelessWidget {
  final Patient patient;

  PatientDetailsScreen({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildDetailRow('Card Number', patient.cardNumber),
              _buildDetailRow('Last Name', patient.lastName),
              _buildDetailRow('First Name', patient.firstName),
              _buildDetailRow('Middle Name', patient.middleName),
              _buildDetailRow('Birth Date', patient.birthDate),
              _buildDetailRow('Height', '${patient.height} cm'),
              _buildDetailRow('Weight', '${patient.weight} kg'),
              _buildDetailRow('Gender', patient.gender),
              _buildDetailRow('Address', patient.address),
              _buildDetailRow('Phone', patient.phone),
              _buildDetailRow('Email', patient.email),
              _buildDetailRow('Diagnosis', patient.diagnosis),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Відкриваємо екран редагування
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPatientScreen(patient: patient),
                        ),
                      );
                    },
                    child: Text('Edit'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Підтвердження видалення пацієнта
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirm Delete'),
                          content: Text('Are you sure you want to delete this patient?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Логіка видалення пацієнта
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: Text('Delete'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
