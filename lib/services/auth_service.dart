import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  // create CustomUser obj from User in Firebase lib
  // CustomUser? _userFromFirebase(User? user) {
  //   return user != null ? CustomUser(uid: user.uid) : null;
  // }

  // CustomUser? _userFromGoogleSign(GoogleSignInAccount? googleUser) {
  //   return googleUser != null ? CustomUser(uid: googleUser.id) : null;
  // }

  // Custom stream from firebase authStateStream
  Stream<User?>? get user {
    return _auth.authStateChanges();
  }

  String? get currentUserId {
    return _auth.currentUser?.uid;
  }

  // sign in anonymous
  Future<User?> signInAnonymous() async {
    UserCredential firebaseUser = await _auth.signInAnonymously();

    return firebaseUser.user;
  }

  // sign in with email & pw
  Future<User?> signInWithEmailAndPassword(email, password) async {
    try {
      UserCredential firebaseUser =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return firebaseUser.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // register wit email & pw
  Future<User?> signUp(email, password) async {
    try {
      UserCredential firebaseUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return firebaseUser.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // sign out
  Future<void> signOut() async {
    try {
      return _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<UserCredential> signInWithGoogleEmail() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await _auth.signInWithCredential(credential);
  }
}
