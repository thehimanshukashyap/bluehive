import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:skype_clone/models/user.dart';
import 'package:skype_clone/provider/image_upload_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skype_clone/resources/chat_methods.dart';

class StorageMethods {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Reference _storageReference;

  //user class
  UserInformation user = UserInformation();

  // Future<String> uploadImageToStorage(File imageFile) async {
  //   print("$imageFile thsi is imagefile \n\n\n\n\n\n\n\n\n\n");
  //   print(
  //       "\n\n\n\n\n Inside uploadImageToStorage online 19 of storage_methods.dart");
  //   // mention try catch later on

  //   try {
  //     _storageReference = FirebaseStorage.instance
  //         .ref()
  //         .child('${DateTime.now().millisecondsSinceEpoch}');
  //     UploadTask storageUploadTask = _storageReference.putFile(imageFile);
  //     var url = await (await storageUploadTask).ref.getDownloadURL();

  //     print(
  //         "---------------------------------------------------------------------------------------Thsi is photo URL: ");
  //     print(url);
  //     return url;
  //   } catch (e) {
  //     print(
  //         "\n\n\n There is some error in uploadImageToStorage function and this is being yelled from line 32 of storage_methods.dart\n\n\n");
  //     print(e);
  //     return null;
  //   }
  // }

  // Future uploadFile(File imageFile) async {
  Future uploadImageToStorage(File imageFile) async {
    try {
      Reference storageReference = FirebaseStorage.instance
          .ref()
          // .child('chats/${Path.basename(imageFile.path)}}');
          .child('sentData/${imageFile.path}}');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask;
      print('File Uploaded');
      var url = storageReference.getDownloadURL();
      return url;
    } catch (e) {
      print("\n\n\n\n\n");
      print("There was some error in uploading image\n\n\n\n\n\n\n\n\n");
      print(e);
      print("\n\n\n\n");
      return null;
    }
  }

  void uploadImage({
    @required File image,
    @required String receiverId,
    @required String senderId,
    @required ImageUploadProvider imageUploadProvider,
  }) async {
    final ChatMethods chatMethods = ChatMethods();

    print(
        "\n\n\n\n\n Inside uploadImage method of storage_methods.dart----------------------------------------------------------\n\n\n\n");

    // Set some loading value to db and show it to user
    imageUploadProvider.setToLoading();

    // Get url from the image bucket
    String url = await uploadImageToStorage(image);

    // Hide loading
    imageUploadProvider.setToIdle();

    chatMethods.setImageMsg(url, receiverId, senderId);
  }
}
