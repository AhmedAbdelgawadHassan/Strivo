import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:strivo/features/fitnessProfileSetup/data/models/fitness_profile_model.dart';

class FitnessProfileRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  DocumentReference<Map<String, dynamic>> get _doc {  // return the doc name from User id 
    final uid = _auth.currentUser!.uid;  // get id for current user
    return _firestore.collection('users').doc(uid);   // get doc in Users Collection from user id 
    // 1- firebaseAuth -> currentUser -> Uid -> user Document in Users Collection
  }

  // Save data
  Future<void> saveProfile(FitnessProfileModel profile) async {
    await _doc.set(profile.toMap(), SetOptions(merge: true));  // set method to save the object
  }

  // Read Data
  Future<FitnessProfileModel?> getProfile() async {
    final snapshot = await _doc.get();
    if (!snapshot.exists || snapshot.data() == null) return null; // if data not come yet , return null
    return FitnessProfileModel.fromMap(snapshot.data()!);  // to convert data comes from Firestore (map) to object (fitness profile model)
  }
}