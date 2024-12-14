// view_model/child_home_view_model.dart
import 'package:flutter/material.dart';
import 'package:your_project/models/child_model.dart'; // Update with the actual path

class ChildHomeViewModel extends ChangeNotifier {
  final ChildModel childModel;

  ChildHomeViewModel({required this.childModel});

  String get userName => childModel.userName;
}
