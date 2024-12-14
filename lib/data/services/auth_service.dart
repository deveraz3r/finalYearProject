import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user
  Future<UserModel?> registerUser(String name, String email, String password) async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;

      // Store user info in Firestore
      if (uid != null) {
        UserModel userModel = UserModel(uid: uid, name: name, email: email);
        await _firestore.collection('users').doc(uid).set(userModel.toMap());
        return userModel;
      }

      return null;
    } catch (e) {
      print("Error registering user: $e");
      return null;
    }
  }

  // Login user
  Future<UserModel?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;

      if (uid != null) {
        // Fetch user info from Firestore
        DocumentSnapshot snapshot = await _firestore.collection('users').doc(uid).get();
        if (snapshot.exists) {
          return UserModel.fromMap(snapshot.data() as Map<String, dynamic>, uid);
        }
      }
      return null;
    } catch (e) {
      print("Error logging in: $e");
      return null;
    }
  }

  // Log out user
  Future<void> logoutUser() async {
    await _auth.signOut();
  }

  // Get the current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
