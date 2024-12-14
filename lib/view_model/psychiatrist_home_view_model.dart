// view_model/psychiatrist_home_view_model.dart
import 'package:flutter/material.dart';
import 'package:final_year_project/models/psychiatrist_model.dart';  // Update with the actual path

class PsychiatristHomeViewModel extends ChangeNotifier {
  final PsychiatristModel psychiatristModel;

  PsychiatristHomeViewModel({required this.psychiatristModel});

  String get userName => psychiatristModel.userName;
  String get doctorId => psychiatristModel.doctorId;

  // Navigation logic can be handled here, but we'll pass it to the view for simplicity
}
