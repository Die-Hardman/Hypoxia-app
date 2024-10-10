import 'package:flutter/material.dart';
import '../models/Patient.dart';
import '../models/Procedure.dart';
import 'ProcedureDetailsScreen.dart'; // Importing the procedure details screen

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Sample lists of patients and procedures
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
    // Add other patients as needed
  ];

  final List<Procedure> procedures = [
    Procedure(
      procedureName: 'Тест на дихання',
      patientName: 'John Doe',
      time: '12:00 PM',
      heartRate: [70, 75, 72], // Assuming heartRate is a List<int?>
      spo2: [98.0, 97.5, 98.2], // Assuming spo2 is a List<double?>
      respirationRate: [16, 15, 14], // Assuming respirationRate is a List<int?>
      oxygenConcentration: [95.0, 94.0, 96.0], // Assuming oxygenConcentration is a List<double?>
      carbonDioxideConcentration: [5.0, 4.5, 5.2], doctorName: '', // Assuming carbonDioxideConcentration is a List<double?>
    ),
    // Add other procedures as needed
  ];

  List<Patient> filteredPatients = [];
  List<Procedure> filteredProcedures = [];

  @override
  void initState() {
    super.initState();
    filteredPatients = patients; // Initially all patients
    filteredProcedures = procedures; // Initially all procedures
  }

  void _search(String query) {
    final lowerQuery = query.toLowerCase();

    setState(() {
      filteredPatients = patients.where((patient) {
        return patient.firstName.toLowerCase().contains(lowerQuery) ||
            patient.lastName.toLowerCase().contains(lowerQuery);
      }).toList();

      filteredProcedures = procedures.where((procedure) {
        return procedure.procedureName.toLowerCase().contains(lowerQuery) ||
            procedure.patientName.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Пошук'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search field
            TextField(
              controller: _searchController,
              onChanged: _search,
              decoration: InputDecoration(
                labelText: 'Пошук пацієнта або процедури',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // List of procedures and patients
            Expanded(
              child: ListView(
                children: [
                  // Displaying patients
                  ...filteredPatients.map((patient) {
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text('${patient.firstName} ${patient.lastName}'),
                      subtitle: Text('Номер картки: ${patient.cardNumber}'),
                      onTap: () {
                        // Open patient details screen (not implemented in this example)
                      },
                    );
                  }).toList(),
                  // Displaying procedures
                  ...filteredProcedures.map((procedure) {
                    return ListTile(
                      leading: Icon(Icons.medical_services),
                      title: Text(procedure.procedureName),
                      subtitle: Text('Пацієнт: ${procedure.patientName}'),
                      onTap: () {
                        // Open procedure details screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProcedureDetailsScreen(procedure: procedure),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
