// view/parent_home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:final_year_project/Chatbot/chat_screen.dart';
import 'package:final_year_project/Education/education_screen.dart';
import 'package:final_year_project/Parent_pages/book_appointment.dart';
import 'package:final_year_project/Parent_pages/kid_register.dart';
import 'package:final_year_project/view_model/parent_home_view_model.dart';

class ParentHomeScreen extends StatelessWidget {
  final String userName;
  final String parentEmail;
  final String parentId;

  ParentHomeScreen({
    required this.userName,
    required this.parentEmail,
    required this.parentId,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Initialize ViewModel
    final ParentHomeViewModel viewModel = Get.put(ParentHomeViewModel());

    // Fetch data when screen is loaded
    viewModel.fetchDoctors();
    viewModel.fetchChildren(parentEmail);

    return Scaffold(
      body: Column(
        children: [
          // Header with avatar and name
          Container(
            color: Colors.green,
            height: screenHeight * 0.25, // Set height to one-fourth of the screen
            padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02,
              horizontal: screenWidth * 0.04,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.07,
                  backgroundImage: AssetImage('assets/avatar_placeholder.png'),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: Text(
                    'Hello ${userName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Add Child Registration Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddChildScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                  ),
                  child: const Text('+ Add Child'),
                ),
              ],
            ),
          ),

          // Body Content: Display child data
          Expanded(
            child: Obx(() {
              if (viewModel.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (viewModel.children.isEmpty) {
                return const Center(
                  child: Text(
                    'No children registered yet. Add a child to view their details.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              // Display list of children
              return ListView.builder(
                itemCount: viewModel.children.length,
                itemBuilder: (context, index) {
                  var child = viewModel.children[index];
                  return Container(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    margin: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                      horizontal: screenWidth * 0.05,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            child.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '${child.age} years',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Chat Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.chat, color: Colors.white),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Education',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Book Appointment',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              // Logic for Home
              break;
            case 1:
              // Logic for Profile
              break;
            case 2:
              // Navigate to Education Screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EducationScreen()),
              );
              break;
            case 3:
              // Navigate to Book Appointment Screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookAppointmentScreen(parentId: parentId),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
