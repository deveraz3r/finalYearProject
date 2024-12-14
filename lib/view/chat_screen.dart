// lib/view/chat_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_year_project/view_model/chat_view_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
        backgroundColor: Colors.green,
      ),
      body: Consumer<ChatViewModel>(
        builder: (context, viewModel, child) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.green[50],
                  child: ListView.builder(
                    itemCount: viewModel.messages.length,
                    itemBuilder: (context, index) {
                      final message = viewModel.messages[index];
                      final isUser = message.containsKey('user');
                      return Align(
                        alignment:
                            isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser ? Colors.green[100] : Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft: isUser
                                  ? const Radius.circular(12)
                                  : const Radius.circular(0),
                              bottomRight: isUser
                                  ? const Radius.circular(0)
                                  : const Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                              )
                            ],
                          ),
                          child: Text(
                            isUser ? message['user']! : message['bot']!,
                            style: TextStyle(
                              fontSize: 16,
                              color: isUser ? Colors.black87 : Colors.black54,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (viewModel.isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: viewModel.controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Type your message...',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.green),
                      onPressed: () => viewModel.sendMessage(viewModel.controller.text),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      backgroundColor: Colors.green[50],
    );
  }
}
