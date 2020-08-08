import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreProvider {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUserID() async {
    FirebaseUser user = await _auth.currentUser();
    return user.uid;
  }

  Stream<DocumentSnapshot> fetchUserData() async* {
    final uid = await getCurrentUserID();
    Stream<DocumentSnapshot> snap =
        _firestore.collection("/users").document(uid).snapshots();
    yield* snap;
  }

  Stream<QuerySnapshot> fetchChatroomData() async* {
    Stream<QuerySnapshot> snap = _firestore
        .collection("/chatroom")
        .orderBy('time', descending: true)
        .snapshots();
    yield* snap;
  }

  void removeEventData(data, event) async {
    _firestore.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(data.reference);

      await transaction.update(freshSnap.reference, {
        "eventDetail": FieldValue.arrayRemove([event])
      });
    });
  }

  void addEventData(data, event) async {
    _firestore.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(data.reference);

      await transaction.update(freshSnap.reference, {
        "eventDetail": FieldValue.arrayUnion([event])
      });
    });
  }

  void composeMessage(String textMessage) async {
    final uid = await getCurrentUserID();
    DocumentReference userRef = _firestore.collection("/users").document(uid);

    _firestore.collection("/chatroom").add({
      "message": textMessage,
      "time": Timestamp.now(),
      "user": userRef,
    });
  }
}
