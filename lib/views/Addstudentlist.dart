import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getx_hive_studentapp/controlletdb/controller.dart';
import 'package:getx_hive_studentapp/model/student_model.dart';
import 'package:getx_hive_studentapp/model/textfiled.dart';
import 'package:getx_hive_studentapp/views/studentlist.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class Addstudentlist extends StatefulWidget {
  const Addstudentlist({super.key});

  @override
  State<Addstudentlist> createState() => _AddstudentlistState();
}

class _AddstudentlistState extends State<Addstudentlist> {
  
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final clsController = TextEditingController();
  late StudentModelController controller;
  late Box<StudentApp>todoBox;   
  late RxString selectedImagePath;
  late RxString selectedImageSize;


 @override
  void initState() {
        todoBox = Hive.box<StudentApp>('studentbox');
    controller = Get.put(StudentModelController());
       controller.  resetImageSelection();
       selectedImagePath = controller.selectedImagePath;
    selectedImageSize = controller.selectedImageSize;
    super.initState();
  }

   @override
  void dispose() {
    controller.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 180, 192),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 selectedImagePath.value.isEmpty
                    ? IconButton(
                        onPressed: () {
                          showimagePickeroption(context);
                        },
                        icon: Icon(Icons.add_a_photo, size: 60),
                      )
                    : Image.file(File(selectedImagePath.value)),
                selectedImageSize.value.isNotEmpty
                    ? Text(
                        selectedImageSize.value,
                        style: TextStyle(fontSize: 10),
                      )
                    : SizedBox(),
                 SizedBox(height: 30,),
                TextFieldDemo(controller: nameController, name: 'name'),
                SizedBox(height: 10,),
                 TextFieldDemo(controller: clsController, name: 'cls'),
                SizedBox(height: 10,),
               TextFieldDemo(controller: ageController, name: 'age'),
                SizedBox(height: 10,),
                 TextFieldDemo(controller: contactController, name: 'contact'),
                SizedBox(height: 10,),
                 TextFieldDemo(controller: emailController, name: 'email'),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: ()async{
                    final name=nameController.text;
                    final cls=clsController.text;
                    final age=ageController.text;
                    final contact=contactController.text;
                    final email=emailController.text;
                    String filepath=controller.selectedImagePath.value;
                    Uint8List imagebytes=await File(filepath).readAsBytes();
                    controller.addStudent(name,cls,age,contact,email,imagebytes);
                                Get.to(StudentList());
        
                }, child: Text('save'))
              ],
            ),
          ),
        ),
      ),
    ); 
  }
   void showimagePickeroption(BuildContext context){
 showModalBottomSheet(
  context: context,
   builder: (builder){
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height /4,
        child: Row(children: [
          Expanded(
            child: InkWell(  
              onTap: (){
               controller.getImage(ImageSource.gallery);
              },
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image),
                    Text('Gallery')
                  ],
                ),
              ),
            ),
          ),
             Expanded(
               child: InkWell(  
                       onTap: (){
                       controller.getImage(ImageSource.camera);
                       },
                       child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera),
                    Text('Camera')
                  ],
                ),
                       ),
                     ),
             )
        ],),
      ),
    );
   }
   );
   }
}