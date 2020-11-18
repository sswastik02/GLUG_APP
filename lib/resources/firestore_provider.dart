import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glug_app/models/notice_model.dart';
import 'package:glug_app/resources/api_provider.dart';

class FirestoreProvider {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getCurrentUserID() async {
    FirebaseUser user = await _auth.currentUser();
    return user.uid;
  }

  Future<String> getCurrentUserEmail() async {
    final uid = await getCurrentUserID();
    DocumentSnapshot snap =
        await _firestore.collection("/users").document(uid).get();
    if (snap.exists)
      return snap["email"];
    else
      return "";
  }

  Future<String> getAuthProvider() async {
    FirebaseUser user = await _auth.currentUser();
    for (UserInfo userInfo in user.providerData) {
      if (userInfo.providerId == "google.com")
        return 'Google';
      else if (userInfo.providerId == "facebook.com") return 'Facebook';
    }
    return 'Other';
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

  void addStarredNotice(noticeData) async {
    final uid = await getCurrentUserID();
    DocumentReference ref = _firestore.collection("/users").document(uid);
    _firestore.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(ref);
      await transaction.update(freshSnap.reference, {
        "starred_notices": FieldValue.arrayUnion([noticeData])
      });
    });
  }

  void removeStarredNotice(noticeData) async {
    final uid = await getCurrentUserID();
    DocumentReference ref = _firestore.collection("/users").document(uid);
    _firestore.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(ref);

      await transaction.update(freshSnap.reference, {
        "starred_notices": FieldValue.arrayRemove([noticeData])
      });
    });
  }

  Future<bool> isStarredNotice(title) async {
    print(title);
    final uid = await getCurrentUserID();
    DocumentSnapshot snap =
        await _firestore.collection("/users").document(uid).get();

    List<dynamic> starredNotices = snap.data["starred_notices"];
    if (starredNotices != null) {
      starredNotices.forEach((notice) {
        //print("${notice.toString()} title: $title");
        var t = notice["title"].toString();
        print("$title and $t");
        if (t.trim() == title.toString().trim()) {
          return true;
        }
      });
    }
    return false;
  }

  Future<List<String>> fetchStaredNoticeTitle() async {
    final uid = await getCurrentUserID();
    DocumentSnapshot snap =
        await _firestore.collection("/users").document(uid).get();
    List<String> noticeTitles = new List();
    List<dynamic> starredNotices = snap.data["starred_notices"];
    if (starredNotices != null) {
      starredNotices.forEach((notice) {
        //print("${notice.toString()} title: $title");
        var t = notice["title"].toString();
        noticeTitles.add(t);
      });
      return noticeTitles;
    }
    return null;
  }

  Future<List<Academic>> fetchStaredNotice() async {
    final uid = await getCurrentUserID();
    DocumentSnapshot snap =
        await _firestore.collection("/users").document(uid).get();
    List<Academic> notices = new List();
    List<dynamic> starredNotices = snap.data["starred_notices"];
    if (starredNotices != null) {
      starredNotices.forEach((notice) {
        Academic academic = Academic(
            title: notice["title"].toString(),
            date: notice["date"],
            file: notice["file"]);
        notices.add(academic);
      });
      return notices;
    }
    return null;
  }

  Future<bool> isInterested(eventName) async {
    final uid = await getCurrentUserID();
    DocumentSnapshot snap =
        await _firestore.collection("/users").document(uid).get();
    List<dynamic> interestedEvents = snap.data["interested"];
    if (interestedEvents != null && interestedEvents.contains(eventName))
      return true;
    else
      return false;
  }

  void addInterested(eventName) async {
    final uid = await getCurrentUserID();
    DocumentReference ref = _firestore.collection("/users").document(uid);
    _firestore.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(ref);

      await transaction.update(freshSnap.reference, {
        "interested": FieldValue.arrayUnion([eventName])
      });
    });
  }

  void removeInterested(eventName) async {
    final uid = await getCurrentUserID();
    DocumentReference ref = _firestore.collection("/users").document(uid);
    _firestore.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(ref);

      await transaction.update(freshSnap.reference, {
        "interested": FieldValue.arrayRemove([eventName])
      });
    });
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

  Future<bool> isAdmin() async {
    final uid = await getCurrentUserID();
    DocumentSnapshot snap =
        await _firestore.collection("/users").document(uid).get();

    if (snap.exists && snap["isAdmin"] != null) return snap["isAdmin"];

    return false;
  }

  void composeMessage(String textMessage) async {
    final uid = await getCurrentUserID();
    DocumentSnapshot user =
        await _firestore.collection("/users").document(uid).get();

    ApiProvider api = ApiProvider();

    String filteredText = await api.filterText(textMessage);

    if (filteredText == null) return;

    // FirebaseUser usera = await _auth.currentUser();

    _firestore.collection("/chatroom").add({
      "message": filteredText,
      "time": Timestamp.now(),
      "sender": user["name"],
      "photoUrl": user["photoUrl"],
      "email": user["email"]
    });
  }

  void deleteMessage(String docID) async {
    await _firestore.collection("/chatroom").document(docID).delete();
  }
}
