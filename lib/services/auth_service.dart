import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  Future<UserCredential?> signInWithEmailAndPassword(email, password) async {
    try {
      UserCredential firebaseUser =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No user found for that email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 12.0);
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
            msg: "Wrong password provided for that user.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 12.0);
        // print('Wrong password provided for that user.');
      }
    }
  }

  Future<bool> isDisplayNameExist(String displayName) async {
    // Should be in databaseService
    var res;
    await FirebaseFirestore.instance
        .collection('usernames')
        .doc(displayName)
        .get()
        .then((value) => res = value.exists);
    return res;
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

  // register wit email & pw
  Future<User?> signUpWithDisplayName(email, password, displayName) async {
    try {
      if (await isDisplayNameExist(displayName)) {
        // TODO: Throw custom Exception: Duplicate display name
        return null;
      }
      return signUp(email, password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      print(e.code);
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
