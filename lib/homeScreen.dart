import 'package:floor/floor.dart';
import 'package:floor_example/db/database.dart';
import 'package:floor_example/model/Student.dart';
import 'package:flutter/material.dart';
import 'package:floor_example/db/dao/StudentDao.dart';



class HomeScreen extends StatefulWidget {
  final StudentDao studentDao;
  HomeScreen(this.studentDao);

  @override
  _HomeScreenState createState() => _HomeScreenState(studentDao);
}

class _HomeScreenState extends State<HomeScreen> {

   String _name;

   String _school;

   Student student;

   final formKey = GlobalKey<FormState>();

   StudentDatabase  studentDatabase;
   StudentDao studentDao;

  _HomeScreenState(this.studentDao);



   builder()async{
     studentDatabase =  await $FloorStudentDatabase.databaseBuilder('student.db').build();

     setState(() {

       studentDao = studentDatabase.studentDao;

     });

   }
   @override
  void initState() {
    super.initState();
    builder();
   }
   List<Student> listStudent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Floor Example'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hoverColor: Colors.blueAccent,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))
                      ),
                      labelText: 'Enter your name',
                      fillColor: Colors.blueAccent,
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'Name',
                    ),
                    onSaved: (input) => _name=input,
                  ),
                  SizedBox(height: 20,),

                  TextFormField(
                    decoration: InputDecoration(
                      hoverColor: Colors.blueAccent,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0))
                      ),
                      labelText: 'Enter your school',
                      fillColor: Colors.blueAccent,
                      contentPadding: EdgeInsets.all(8.0),
                      hintText: 'School',
                    ),
                    onSaved: (input) => _school =input,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onDoubleTap: (){
              listStudent.removeLast();
            },
            child: RaisedButton(
              color: Colors.blueAccent,
              child: Text('Save',style: TextStyle(color: Colors.white),),
              onPressed: ()  {
                formKey.currentState.save();
                String name =  _name;
                String school = _school;
                print(listStudent);

                var patient = Student(name: name, school: school);
                studentDao.insertStudent(patient);
                 formKey.currentState.reset();

              },
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            child: StreamBuilder<List<Student>>(
                stream: studentDao.findAllStudentsAsStream(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return Container();

                final tasks = snapshot.data;
                print(snapshot.data);

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(tasks[index].name),
                      subtitle: Text(tasks[index].school),
                      onLongPress: (){
                        int id = tasks[index].id;
                        var patient = Student(id: id);
                        print(tasks[index].name);
                        studentDao.deleteStudent(patient);
                      },
                    );
                  },
                );
              },
          ),
          ),
        ],
      ),
    );
  }
}
