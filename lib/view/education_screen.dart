// view/education_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // for ChangeNotifierProvider
import 'package:your_project/view_model/education_view_model.dart'; // Update with the actual path

class EducationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EducationViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Education Resources'),
          backgroundColor: Colors.green,
        ),
        body: Consumer<EducationViewModel>(
          builder: (context, viewModel, child) {
            return ListView.builder(
              itemCount: viewModel.educationItems.length,
              itemBuilder: (context, index) {
                final item = viewModel.educationItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: const Icon(Icons.link, color: Colors.green),
                    title: Text(
                      item.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
                    onTap: () {
                      viewModel.openUrl(context, item.url);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
