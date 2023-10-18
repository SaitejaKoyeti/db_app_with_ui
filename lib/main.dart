import 'package:db_app_with_ui/Students.dart';
import 'Databases.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Databases handler;

  Future<int> addStudents() async {
    Students firstStudent = Students(id: 1, name: "Mahesh", age: 25, marks: 98);
    Students secondStudent = Students(id: 2, name: "Yesh", age: 28, marks: 88);
    Students thirdStudent = Students(id: 3, name: "Raja", age: 24, marks: 92);
    Students fourthStudent = Students(id: 4, name: "Rani", age: 23, marks: 87);

    List<Students> students = [
      firstStudent,
      secondStudent,
      thirdStudent,
      fourthStudent
    ];

    return await handler.insertStudents(students);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = Databases();
    handler.initDB().whenComplete(() async {
      await addStudents();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: handler.retrieveStudents(),
          builder: (context, AsyncSnapshot<List<Students>>snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].age.toString()),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}