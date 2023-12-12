import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_hive_studentapp/model/student_model.dart';
import 'package:getx_hive_studentapp/views/Addstudentlist.dart';
import 'package:getx_hive_studentapp/views/updatestudentlist.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
    late Box<StudentApp>todoBox;  

   @override
  void initState() {
    super.initState();
    todoBox = Hive.box<StudentApp>('studentbox');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){
              Get.bottomSheet(Container(
              child: Wrap(
                children: [
                    ListTile(
                        leading: Icon(Icons.wb_sunny_outlined),
                         title: Text('light'),
                         onTap: ()=>{Get.changeTheme(ThemeData.light())},
                       ),
             ListTile(
                         leading: Icon(Icons.wb_sunny),  
                         title: Text('dark'),
                         onTap: ()=>{Get.changeTheme(ThemeData.dark())},
                       ),
                ],
              ),
              ));
      }, icon:Icon(Icons.dark_mode_outlined) ),
        backgroundColor: Color.fromARGB(255, 15, 207, 133),
        title: Text('studentapp'),
        
      ),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: ValueListenableBuilder(
          valueListenable: todoBox.listenable(),
           builder: (context,Box<StudentApp>todoBox,child){
            if(todoBox.isEmpty){
              return Center(child: Text('no data'),);
            }
            return StreamBuilder<Object>(
              stream: null,
               builder: (context,Snapshot){
                return ListView.builder(
                  itemCount: todoBox.length,
                  itemBuilder: (ctx,intex){
                    StudentApp newBox = todoBox.getAt(intex)as StudentApp;
                    return Card(child: SizedBox(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: MemoryImage(newBox.image),
                        ),
                            title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('name:${newBox.name}'),
                  Text('cls:${newBox.cls}'),
                ],  ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Updatestudentlist( index:intex, name:newBox.name,  age:newBox.age,cla: newBox.cls, contact:newBox.contact,email:newBox.email,image: newBox.image,)));
                },
                        trailing: IconButton(onPressed: ()async{
                          todoBox.deleteAt(intex).then((value) => 
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('...deleted'))));
                        },
                        icon: const Icon(Icons.delete_rounded, color: Colors.red),)
                        )));
                  });
               });
           }),
      ) ,
          floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(Addstudentlist());
        },
        backgroundColor: const Color.fromARGB(255, 247, 245, 245),
        child: Icon(
          Icons.add,
          color: Colors.red,
          size: 40,
        ),
      ),
    );
  }
}