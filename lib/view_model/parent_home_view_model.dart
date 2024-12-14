// view_model/parent_home_view_model.dart
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/models/doctor.dart';
import 'package:final_year_project/models/child.dart';
import 'package:final_year_project/services/firestore_service.dart';

class ParentHomeViewModel extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  var doctors = <Doctor>[].obs;
  var children = <Child>[].obs;
  var isLoading = true.obs;

  // Fetch available doctors from Firestore
  Future<void> fetchDoctors() async {
    try {
      isLoading(true);
      List<Map<String, dynamic>> doctorList = await _firestoreService.getAllDoctors();
      doctors.value = doctorList.map((doc) => Doctor.fromMap(doc)).toList();
    } catch (e) {
      print("Error fetching doctors: $e");
    } finally {
      isLoading(false);
    }
  }

  // Fetch children from Firestore based on parent email
  Future<void> fetchChildren(String parentEmail) async {
    try {
      isLoading(true);
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('parentEmail', isEqualTo: parentEmail)
          .where('role', isEqualTo: 'child')
          .get();

      children.value = snapshot.docs
          .map((doc) => Child.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching children: $e");
    } finally {
      isLoading(false);
    }
  }
}
