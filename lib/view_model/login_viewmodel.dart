import 'package:finalyearproject/view_model/services/firebase_auth_service.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../views/parent_home_screen.dart';
import '../views/child_home_page.dart';
import '../views/psychiatrist_home_page.dart';

class LoginViewModel extends GetxController {
  final AuthService _authService = AuthService();

  var email = ''.obs;
  var password = ''.obs;
  var selectedRole = ''.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;

  void login() async {
    if (selectedRole.value.isEmpty) {
      errorMessage.value = 'Please select a role.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final user = await _authService.loginUser(email.value.trim(), password.value.trim());
      if (user == null) {
        errorMessage.value = 'Login failed. Please check your credentials.';
        return;
      }

      final userDoc = await _authService.getUserData(user.uid);
      if (!userDoc.exists) {
        errorMessage.value = 'User not found in the database.';
        return;
      }

      final userData = userDoc.data() as Map<String, dynamic>?;
      if (userData == null || !userData.containsKey('role')) {
        errorMessage.value = 'Incomplete user data. Please contact support.';
        return;
      }

      String role = userData['role'];
      String username = userData['username'] ?? userData['name'] ?? '';

      if (role.toLowerCase() != selectedRole.value.toLowerCase()) {
        errorMessage.value = 'Role mismatch. Please select the correct role.';
        return;
      }

      switch (role.toLowerCase()) {
        case 'parent':
          Get.off(() => ParentHomeScreen(userName: username));
          break;
        case 'child':
          Get.off(() => ChildHomePage(userName: username));
          break;
        case 'psychiatrist':
          Get.off(() => PsychiatristHomePage(userName: username));
          break;
        default:
          errorMessage.value = 'Unknown role. Please contact support.';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }
}
