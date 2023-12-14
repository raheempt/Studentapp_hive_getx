
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive_studentapp/controlletdb/controller.dart';
import 'package:getx_hive_studentapp/model/student_model.dart';
import 'package:getx_hive_studentapp/model/textfiled.dart';
import 'package:hive/hive.dart';

class UpdateStudentList extends StatefulWidget {
  final String name;
  final String age;
  final String contact;
  final String email;
  final String cla;
  final int index;
  final Uint8List? image;

  const UpdateStudentList({
    required this.index,
    required this.name,
    required this.age,
    required this.contact,
    required this.email,
    required this.cla,
    required this.image,
  });

  @override
  State<UpdateStudentList> createState() => _UpdateStudentListState();
}

class _UpdateStudentListState extends State<UpdateStudentList> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final clsController = TextEditingController();
  final controller = Get.put(StudentModelController());
  late Box<StudentApp> todoBox;

  @override
  void initState() {
    super.initState();
    todoBox = Hive.box<StudentApp>('studentbox');
    nameController.text = widget.name;
    ageController.text = widget.age;
    contactController.text = widget.contact;
    emailController.text = widget.email;
    clsController.text = widget.cla;
    controller.resetImageSelection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [          
                SizedBox(height: 30),
                TextFieldDemo(controller: nameController, name: 'name'),
                SizedBox(height: 10),
                TextFieldDemo(controller: clsController, name: 'cls'),
                SizedBox(height: 10),
                TextFieldDemo(controller: ageController, name: 'age'),
                SizedBox(height: 10),
                TextFieldDemo(controller: contactController, name: 'contact'),
                SizedBox(height: 10),
                TextFieldDemo(controller: emailController, name: 'email'),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final cls = clsController.text;
                    final age = ageController.text;
                    final contact = contactController.text;
                    final email = emailController.text;
                    final image = widget.image;
                    StudentApp updateStudent = StudentApp(
                      name: name,
                      age: age,
                      cls: cls,
                      contact: contact,
                      email: email,
                      image: image!,
                    );
                    todoBox.putAt(widget.index, updateStudent);
                    Navigator.pop(context);
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
