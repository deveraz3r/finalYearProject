// view/child_home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // for ChangeNotifierProvider and Consumer
import 'package:your_project/view_model/child_home_view_model.dart'; // Update with the actual path
import 'package:your_project/models/child_model.dart'; // Update with the actual path

class ChildHomePage extends StatelessWidget {
  final String userName;

  const ChildHomePage({required this.userName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChildHomeViewModel(
        childModel: ChildModel(userName: userName),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text('Child Home Page'),
          centerTitle: true,
        ),
        body: Consumer<ChildHomeViewModel>(
          builder: (context, viewModel, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, ${viewModel.userName}!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'This is the Child Home Page.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
