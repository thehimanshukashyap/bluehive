import 'dart:io';
import 'dart:math';
// import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:skype_clone/enum/user_state.dart';

class Utils {
  static String getUsername(String email) {
    return "live:${email.split('@')[0]}";
  }

  static String getInitials(String name) {
    List<String> nameSplit = name.split(" ");
    String firstNameInitial = nameSplit[0][0];
    String lastNameInitial = nameSplit[1][0];
    return firstNameInitial + lastNameInitial;
  }

  // this is new

  static Future<File> pickImage({@required ImageSource source}) async {
    ImagePicker imagePicker = new ImagePicker();
    PickedFile selectedImage = await imagePicker.getImage(source: source);
    return compressImage(selectedImage);
  }

  static Future<File> compressImage(PickedFile imageToCompress) async {
    // final tempDir = await getTemporaryDirectory();
    // final path = tempDir.path;
    int rand = Random().nextInt(10000);

    // Im.Image image = Im.decodeImage(imageToCompress.readAsBytesSync());
    // Im.copyResize(image, width: 500, height: 500);
    print(
        "================================================================================= this is on line 44 of utitlities.dart");
    print('img_$rand.jpg');
    return new File('img_$rand.jpg');
    // print('$path/img_$rand.jpg');
    // return new File('$path/img_$rand.jpg');
    // ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));
  }

  static int stateToNum(UserState userState) {
    switch (userState) {
      case UserState.Offline:
        return 0;

      case UserState.Online:
        return 1;

      default:
        return 2;
    }
  }

  static UserState numToState(int number) {
    switch (number) {
      case 0:
        return UserState.Offline;

      case 1:
        return UserState.Online;

      default:
        return UserState.Waiting;
    }
  }

  static String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    var formatter = DateFormat('dd/MM/yy');
    return formatter.format(dateTime);
  }
}

// class Im {}
