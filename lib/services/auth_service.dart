import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final Firestore _firestore = Firestore.instance;

Future<String> signInWithGoogle() async {
  try {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    String name;
    String email;
    String photoUrl;

    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoUrl != null);

    name = user.displayName;
    email = user.email;
    photoUrl = user.photoUrl;

    DocumentSnapshot doc =
        await _firestore.collection("/users").document(user.uid).get();

    if (!doc.exists) {
      _firestore.collection("/users").document(user.uid).setData({
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
      });
    }

    return 'Success';
  } catch (error) {
    return 'Failure';
  }
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();

  print("User Sign Out");
}
