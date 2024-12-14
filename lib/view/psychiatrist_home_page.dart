// view/psychiatrist_home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // for ChangeNotifierProvider and Consumer
import 'package:final_year_project/view_model/psychiatrist_home_view_model.dart'; // Update with the actual path
import 'package:final_year_project/models/psychiatrist_model.dart'; // Update with the actual path
import 'package:final_year_project/psychiatrist_pages/View_Appointment.dart'; // Update with the actual path

class PsychiatristHomePage extends StatelessWidget {
  final String userName;
  final String doctorId;

  const PsychiatristHomePage({required this.userName, required this.doctorId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PsychiatristHomeViewModel(
        psychiatristModel: PsychiatristModel(userName: userName, doctorId: doctorId),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          title: Text('Psychiatrist Home Page'),
          centerTitle: true,
        ),
        body: Consumer<PsychiatristHomeViewModel>(
          builder: (context, viewModel, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, Dr. ${viewModel.userName}!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purpleAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'This is the Psychiatrist Home Page.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to Doctor Appointment Screen with doctorId
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorAppointmentScreen(
                            doctorId: viewModel.doctorId,
                          ),
                        ),
                      );
                    },
                    child: const Text("Accept Request"),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
