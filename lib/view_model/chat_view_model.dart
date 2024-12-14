// lib/view_model/chat_view_model.dart

import 'package:flutter/material.dart';
import 'package:final_year_project/models/chat_model.dart';

class ChatViewModel extends ChangeNotifier {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> messages = [];
  bool isLoading = false;

  void sendMessage(String message) async {
    if (message.isEmpty) return;

    // Add user's message
    messages.add({'user': message});
    isLoading = true;
    notifyListeners();

    controller.clear();
    
    // Fetch response from API
    final response = await ChatApi.sendMessage(message);
    
    // Add bot's response
    messages.add({'bot': response});
    isLoading = false;
    notifyListeners();
  }
}
