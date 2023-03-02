import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:mithas/components.dart';

final viewModel =
    ChangeNotifierProvider.autoDispose<ViewModel>((ref) => ViewModel());
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(viewModel).authStateChange;
});

class ViewModel extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  Stream<User?> get authStateChange => _auth.authStateChanges();
  Logger logger = Logger();

  String? customerName = "";
  String? customerContactNo = "";
  String? customerAddress = "";
  String? customerEmail = "";
  String? uidGenFirebase = null;

  bool isObscure = true;
  toogleObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  Future<void> getCustomerDetailsByUserId(String userId) async {
    await FirebaseFirestore.instance
        .collection('user')
        .where("userid", isEqualTo: userId)
        .get()
        .then((QuerySnapshot snapshot) {
      customerName = snapshot.docs[0]["name"];
      customerContactNo = snapshot.docs[0]["contactno"];
      customerAddress = snapshot.docs[0]["address"];
      customerEmail = snapshot.docs[0]["email"];
      uidGenFirebase = snapshot.docs[0].id;
    });
    notifyListeners();
  }

  //Register User
  Future<void> createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      logger.d("Register Successful");
      insertUserData(context, email, value.user!.uid);
    }).onError((error, stackTrace) {
      logger.d(error);
      DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
    });
  }

  //Inserting data into User Table For New User
  Future<void> insertUserData(
      BuildContext context, String email, String userId) async {
    final userDetails = FirebaseFirestore.instance.collection('user').doc();
    final json = {
      'userid': userId.toString(),
      'name': "",
      'email': email.toString(),
      'contactno': "",
      'address': ""
    };
    await userDetails.set(json);
    await getCustomerDetailsByUserId(userDetails.id);
    notifyListeners();
  }

  //Log Out User
  Future<void> logout() async {
    await _auth.signOut();
  }

  //Login user
  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      logger.d("Login Successfully");
    }).onError((error, stackTrace) {
      logger.d(error);
      DialogBox(context, error.toString().replaceAll(RegExp('\\[.*?\\]'), ''));
    });

    //userEmail = email;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userId = user!.uid;
    await getCustomerDetailsByUserId(userId);
    notifyListeners();
  }

  Future<void> updateUserProfile(String email, String name, String address,
      String contact, String uidGenFireBase) async {
    final refUser =
        FirebaseFirestore.instance.collection('user').doc(uidGenFirebase);
    refUser.update({
      'name': name,
      'address': address,
      'contactno': contact,
    });
    customerName = name;
    customerContactNo = contact;
    notifyListeners();
  }
}
