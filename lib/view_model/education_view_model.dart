// view_model/education_view_model.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:your_project/models/education_item.dart'; // Update with the actual path

class EducationViewModel extends ChangeNotifier {
  // List of education items
  final List<EducationItem> educationItems = [
    EducationItem(title: 'Flutter Documentation', url: 'https://flutter.dev/docs'),
    EducationItem(title: 'Dart Programming Language', url: 'https://dart.dev'),
    EducationItem(title: 'Stack Overflow', url: 'https://stackoverflow.com'),
    EducationItem(title: 'Medium Blogs', url: 'https://medium.com'),
    EducationItem(title: 'GitHub', url: 'https://github.com'),
  ];

  // Function to handle URL opening
  void openUrl(BuildContext context, String url) async {
    print('Attempting to open URL: $url');
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      print('URL opened successfully');
    } else {
      print('Could not open URL: $url');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open URL')),
      );
    }
  }
}
