
import 'dart:typed_data';

import 'package:hive/hive.dart';
part 'student_model.g.dart';
@HiveType(typeId: 1)
class StudentApp{
  @HiveField(0)
  String name;
   @HiveField(1)
 String cls;
 @HiveField(2)
 String age;
 @HiveField(3)
String contact;
@HiveField(4)
String email;
@HiveField(5)
Uint8List image;
StudentApp({
  required this.name,required this.age,required this.cls,required this.contact,required this.email,
  required this.image,
});
 
}

