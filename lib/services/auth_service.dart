import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_interview_preparation/objects/FirestoreUser.dart';
import 'package:flutter_interview_preparation/objects/CustomFirebaseAuthException.dart';
import 'package:flutter_interview_preparation/services/database_service.dart';
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
  Stream<User?> get user {
    return _auth.authStateChanges();
  }

  Stream<User?> get userChanges {
    return _auth.userChanges();
  }

  String? get currentUserId {
    return _auth.currentUser?.uid;
  }

  User? get currentUser {
    return _auth.currentUser;
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

  Future<bool> isCurrentPasswordValid(String password) async {
    AuthService _auth = AuthService();
    AuthCredential credential = EmailAuthProvider.credential(
        email: _auth.currentUser?.email ?? '', password: password);
    bool result;
    try {
      final data =
          await _auth.currentUser?.reauthenticateWithCredential(credential);
      result = data?.user != null;
    } on FirebaseAuthException catch (e) {
      result = false;
    }
    return result;
  }

  // register wit email & pw
  Future<User?> signUp(email, password) async {
    try {
      UserCredential firebaseUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (firebaseUser.user != null) {
        Fluttertoast.showToast(msg: 'Sign up successfully');
      }
      return firebaseUser.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthExceptionCode(e.code);
    }
  }

  // register wit email & pw & displayName
  Future<User?> signUpWithDisplayName(email, password, displayName) async {
    try {
      if (await isDisplayNameExist(displayName)) {
        throw CustomFirebaseAuthException(
            CustomFirebaseAuthException.DUPLICATE_DISPLAY_NAME);
      }
      // NO dup displayName
      User? res = await signUp(email, password);
      if (res != null) {
        await res.updateDisplayName(displayName);
        DatabaseService().createNewUserDoc(_auth.currentUser!);
      }
      return res;
    } on CustomFirebaseAuthException catch (e) {
      _handleAuthExceptionCode(e.code);
    }
  }

  String _friendlyMessage(String code) {
    switch (code) {
      case CustomFirebaseAuthException.DUPLICATE_DISPLAY_NAME:
        return 'Your display name has exists, try another';
      case CustomFirebaseAuthException.EMAIL_ALREADY_IN_USE:
        return 'Your email has been used, try another';
      case CustomFirebaseAuthException.INVALID_EMAIL:
        return 'Your email is invalid, try another';
      case CustomFirebaseAuthException.WEAK_PASSWORD:
        return 'Your is too weak, try another';
      case CustomFirebaseAuthException.OPERATION_NOT_ALLOWED:
        return 'Sorry, your operation is denied';
      default:
        return 'Something went wrong';
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

  // void checkReadOthersData(String uid) async {
  //   QuerySnapshot result = await FirebaseFirestore.instance
  //       .collection("users")
  //       .where("uid", isEqualTo: uid).get();
  //   final List<DocumentSnapshot> docs = result.docs;
  //   debugPrint(docs.toString());
  //   if (docs.length == 0) {
  //     debugPrint('new user');
  //   }
  // }

  Future<UserCredential> signInWithGoogleEmail() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return _auth.signInWithCredential(credential).then((value) {
      DatabaseService().createNewUserDoc(value.user!);
      return value;
    });
  }

  // This function show a toast about FirebaseAuthException
  void _showAuthExceptionToast(String code) {
    debugPrint(code);
    Fluttertoast.showToast(
        msg: _friendlyMessage(code),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 12.0);
  }

  void _handleAuthExceptionCode(String code) {
    _showAuthExceptionToast(code);
    debugPrint(code);
  }

  Future<bool> updateDisplayName(String newName) async {
    String oldDisplayName = currentUser?.displayName ?? '';
    // Update Authentication
    await currentUser?.updateDisplayName(newName);

    // Update Data in Firestore
    await DatabaseService().updateUserAuthInfo(currentUser!, oldDisplayName);

    return true;
  }
}
