
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:getx_hive_studentapp/model/student_model.dart';
import 'package:hive/hive.dart';

class StudentModelController extends GetxController {
  static final Box<StudentApp> todoBox = Hive.box<StudentApp>('studentBox');

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  void resetImageSelection() {
    selectedImagePath.value = '';
    selectedImageSize.value = '';
  }

  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          (File(selectedImagePath.value).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              " Mb";
    } else {
      Get.snackbar('Error', 'No image',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.red);
    }
  }

  addStudent(String name, String cls, String age, String contact, String email,
      Uint8List image) {
    StudentApp student = StudentApp(
        name: name,
        cls: cls,
        age: age,
        contact: contact,
        email: email,
        image: image);
    todoBox.add(student);
  }

  deleteStudent(int index) async {
    await todoBox.deleteAt(index);
  }

  updateStudent(int index, String name, String cls, String age, String contact,
      String email, Uint8List image) {
    StudentApp student = StudentApp(
        name: name,
        cls: cls,
        age: age,
        contact: contact,
        email: email,
        image: image);
    todoBox.putAt(index, student);
  }
}
