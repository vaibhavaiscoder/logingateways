import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final userAuthentication = FirebaseAuth.instance;
final emailAuthentication = FirebaseAuth.instance;
final phoneAuthentication = FirebaseAuth.instance;
final googleAuthentication = FirebaseAuth.instance;

FirebaseFirestore userFirestore = FirebaseFirestore.instance;
FirebaseFirestore emailFirestore = FirebaseFirestore.instance;
FirebaseFirestore phoneFirestore = FirebaseFirestore.instance;
FirebaseFirestore googleFirestore = FirebaseFirestore.instance;

User? currentUser = userAuthentication.currentUser;
User? currentEmailAuth = emailAuthentication.currentUser;
User? currentPhoneAuth = phoneAuthentication.currentUser;
User? currentGoogleAuth = googleAuthentication.currentUser;

//collections
const userCollection = "users";
const phoneCollection = "phone";
const emailCollection = "email";
const googleCollection = "google";