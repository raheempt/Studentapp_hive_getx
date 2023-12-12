// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:getx_hive_studentapp/controlletdb/controller.dart';
// import 'package:getx_hive_studentapp/model/student_model.dart';
// import 'package:getx_hive_studentapp/model/textfiled.dart';
// import 'package:hive/hive.dart';
// import 'package:image_picker/image_picker.dart';

// class Updatestudentlist extends StatefulWidget {
//    final String name;
//   final String age;
//   final String contact;
//   final String email;
//   final String cla;
//   final int index;
//  final Uint8List? image;

//   const Updatestudentlist({
//      required this.index,
//     required this.name,
//     required this.age,
//     required this.contact,
//     required this.email,
//     required this.cla,
//     required this.image
//     });

//   @override
//   State<Updatestudentlist> createState() => _UpdatestudentlistState();
// }
// class _UpdatestudentlistState extends State<Updatestudentlist> {
//     final nameController = TextEditingController();
//    final  agecontroller= TextEditingController();
//   final contactController=TextEditingController();
//   final emailController=TextEditingController();
//   final clsController=TextEditingController();
//   final contactcontroller=TextEditingController();
//    final  controller= Get.put(StudentModelController());
//   late Box<StudentApp>todoBox;
    
//   late RxString selectedImagePath;
//   late RxString selectedImageSize;
//  @override
//   void initState() {
//     super.initState();
//       todoBox = Hive.box<StudentApp>('studentbox');
//        nameController.text=widget.name;
//        agecontroller.text=widget.age;
//        contactController.text=widget.contact;
//        emailController.text=widget.email;
//        clsController.text=widget.cla;
//        controller.  resetImageSelection();
//        selectedImagePath = controller.selectedImagePath;
//     selectedImageSize = controller.selectedImageSize;

//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//                children: [
//                   selectedImagePath.value.isEmpty
//                     ? IconButton(
//                          onPressed: () {
//                            showimagePickeroption(context);
//                          },
//                         icon: Icon(Icons.add_a_photo, size: 60),
//                        )
//                      : Image.file(File(selectedImagePath.value)),
//                  selectedImageSize.value.isNotEmpty
//                      ? Text(
//                          selectedImageSize.value,
//                          style: TextStyle(fontSize: 10),
//                        )
//                      : SizedBox(),
//                 SizedBox(height: 30,),
//                 TextFieldDemo(controller: nameController, name: 'name'),
//                 SizedBox(height: 10,),
//                  TextFieldDemo(controller: clsController, name: 'cls'),
//                 SizedBox(height: 10,),
//                TextFieldDemo(controller: agecontroller, name: 'age'),
//                 SizedBox(height: 10,),
//                  TextFieldDemo(controller: contactController, name: 'contact'),
//                 SizedBox(height: 10,),
//                  TextFieldDemo(controller: emailController, name: 'email'),
//                 SizedBox(height: 10,),
//                 ElevatedButton(onPressed: (){ 
//                     final name=nameController.text;
//                     final cls=clsController.text;
//                     final age=agecontroller.text;
//                     final contact=contactController.text;
//                     final email=emailController.text;
//                     final image =widget.image;
//                     StudentApp updateNotes = StudentApp(
//                       name: name,
//                        age: age, cls: cls,
//                         contact: contact,
//                          email: email,
//                          image: image!);
//                          todoBox.putAt(widget.index, updateNotes,);
//                            Navigator.pop(context);
        
//                 }, child: Text('update'))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//      void showimagePickeroption(BuildContext context){
//  showModalBottomSheet(
//   context: context,
//    builder: (builder){
//     return Padding(
//       padding: const EdgeInsets.all(18.0),
//       child: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height /4,
//         child: Row(children: [
//           Expanded(
//             child: InkWell(  
//               onTap: (){
//                controller.getImage(ImageSource.gallery);
//               },
//               child: SizedBox(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.image),
//                     Text('Gallery')
//                   ],
//                 ),
//               ),
//             ),
//           ),
//              Expanded(
//                child: InkWell(  
//                        onTap: (){
//                        controller.getImage(ImageSource.camera);
//                        },
//                        child: SizedBox(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.camera),
//                     Text('Camera')
//                   ],
//                 ),
//                        ),
//                      ),
//              )
//         ],),
//       ),
//     );
//    }
//    );
//    }
// }

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive_studentapp/controlletdb/controller.dart';
import 'package:getx_hive_studentapp/model/student_model.dart';
import 'package:getx_hive_studentapp/model/textfiled.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

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
                Obx(
                  () => controller.selectedImagePath.value.isEmpty
                      ? IconButton(
                          onPressed: () {
                            showImagePickerOption(context);
                          },
                          icon: Icon(Icons.add_a_photo, size: 60),
                        )
                      : Image.file(File(controller.selectedImagePath.value)),
                ),
                Obx(
                  () => controller.selectedImageSize.value.isNotEmpty
                      ? Text(
                          controller.selectedImageSize.value,
                          style: TextStyle(fontSize: 10),
                        )
                      : SizedBox(),
                ),
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

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.getImage(ImageSource.gallery);
                    },
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image),
                          Text('Gallery'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      controller.getImage(ImageSource.camera);
                    },
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera),
                          Text('Camera'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
