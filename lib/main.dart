import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive_studentapp/model/student_model.dart';
import 'package:getx_hive_studentapp/views/studentlist.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter<StudentApp>(StudentAppAdapter());
  await Hive.openBox<StudentApp>('studentbox');
  runApp( GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: StudentList(),
  ));
}



