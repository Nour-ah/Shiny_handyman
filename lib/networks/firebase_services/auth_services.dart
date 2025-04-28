// networks/firebase_services/auth_services.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:handyman_provider_flutter/utils/constant.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../models/user_data.dart';
import '../../networks/rest_apis.dart';

class AuthService {
  Future<UserCredential> getFirebaseUser() async {
    UserCredential? userCredential;
    try {
      /// login with Firebase
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: appStore.userEmail, password: appStore.userPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        /// register user in Firebase
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: appStore.userEmail, password: appStore.userPassword);
      }
    }
    if (userCredential != null && userCredential.user == null) {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: appStore.userEmail, password: appStore.userPassword);
    }

    if (userCredential != null) {
      return userCredential;
    } else {
      throw errorSomethingWentWrong;
    }
  }

  Future<void> verifyFirebaseUser() async {
    try {
      print('🚀 [START] verifyFirebaseUser');
      print('📧 Email: ${appStore.userEmail}');
      print('🔐 Password: ${appStore.userPassword}');
      UserCredential userCredential = await getFirebaseUser();
      print('✅ Firebase user retrieved: ${userCredential.user?.uid}');
      UserData userData = UserData();
      userData.id = appStore.userId;
      userData.email = appStore.userEmail;
      userData.firstName = appStore.userFirstName;
      userData.lastName = appStore.userLastName;
      userData.profileImage = appStore.userProfileImage;
      userData.updatedAt = Timestamp.now().toDate().toString();

      /// Check email exists in Firebase
      /// If not exists, register user in Firebase,
      /// If exists, login with Firebase
      /// Redirect to Dashboard

      /// add user data in Firestore
      userData.uid = userCredential.user!.uid;
      print('📦 UserData ready: ${userData.toJson()}');
      bool isUserExistWithUid =
          await userService.isUserExistWithUid(userCredential.user!.uid);

      if (!isUserExistWithUid) {
        userData.createdAt = Timestamp.now().toDate().toString();
        await userService.addDocumentWithCustomId(
            userCredential.user!.uid, userData.toFirebaseJson());
        print('🆕 User added to Firestore with UID: ${userData.uid}');
      } else {
        /// Update user details in Firebase
        await userService.updateDocument(
            userData.toFirebaseJson(), userCredential.user!.uid);
        print('♻️ User updated in Firestore with UID: ${userData.uid}');
      }

      /// Update UID in Laravel DB
      updateProfile({'uid': userCredential.user!.uid});

      await appStore.setUId(userCredential.user!.uid);
    } catch (e) {
      log('verifyFirebaseUser $e');
    }
  }
}
