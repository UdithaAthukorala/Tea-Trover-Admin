import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global.dart';

class Controllers {

  static Future<bool> isLogedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<DatabaseEvent> readCurrentOnlineUserInfo() async {
    currentUser = FirebaseAuth.instance.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("admins")
        .child(currentUser!.uid);

    Future<DatabaseEvent> databaseEvent = userRef.once();

    return databaseEvent;
  }

  static Future<String?> uploadImage(File imageFile, String path) async {
    try {
      final storageRef = FirebaseStorage.instanceFor(bucket: "gs://teatrove-358f5.appspot.com").ref();
      final imagesRef = storageRef.child(path);
      await imagesRef.putFile(imageFile);
      final downloadUrl = await imagesRef.getDownloadURL();
      print('Upload complete! Image URL: $downloadUrl');
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      Fluttertoast.showToast(msg: "Error uploading image: $e");
      return null;
    }
  }

}