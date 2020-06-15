import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireBaseManager{

  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String loggedInUsername;

  void createUserProfile(String username) async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        loggedInUsername = username;
        _firestore.collection('users').add({
        'uid':loggedInUser.uid,
          'username':username,
          'events':[]});
      }
    } catch (e) {
      print(e);
    }
  }

  //void eventsStream() async {
    //_firestore.collection('user').snapshots()
  //}

  Future<String> getUsername(FirebaseUser currentUser) async {
    print(currentUser.email);
    print(currentUser.uid);
    final user = await _firestore.collection('users').where('uid', isEqualTo: currentUser.uid).getDocuments();
    return user.documents[0].data['username'];
  }
}