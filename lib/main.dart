import 'package:flutter/material.dart';
import 'package:sql_practice/Insert_data.dart';
import 'package:sql_practice/delete_data.dart';
import 'package:sql_practice/update_data.dart';

import 'Helper.dart';
import 'Student.dart';
import 'model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: sqlite());
  }
}

class sqlite extends StatefulWidget {
  String uname, uage, uid;

  sqlite(
      {Key key,
      this.uname,
      this.uage,
      this.uid,
     })
      : super(key: key);

  @override
  State<sqlite> createState() => _sqliteState();
}

class _sqliteState extends State<sqlite> {

  TextEditingController iid = new TextEditingController();
  TextEditingController iname = new TextEditingController();
  TextEditingController iage = new TextEditingController();

  TextEditingController eid = new TextEditingController();
  TextEditingController ename = new TextEditingController();
  TextEditingController eage = new TextEditingController();

  static List<Global> advance = [];
  final Helper helper = Helper.instance;

  List<Student> studentList = [];
  List<Student> nameList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sqlite"),
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: studentList.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == studentList.length) {
              return ElevatedButton(
                child: Text('Refresh'),
                onPressed: () {
                  setState(() {
                    _getAll();
                  });
                },
              );
            }
            return display(
                studentList[index].id.toString(),
                studentList[index].name.toString(),
                studentList[index].age.toString());
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => insert_data()));
        },
      ),
    );
  }

  Widget display(String id, String name, String age) {
    return Stack(children: [
      Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Id: $id",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Name: $name",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Age: $age",
                  style: TextStyle(fontSize: 25),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 100,
        right: 5,
        child: IconButton(
            icon: Icon(Icons.update),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Update(cid: id,cname: name,cage: age)));
              });
            }),
      ),
      Positioned(
        bottom: 5,
        right: 5,
        child: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                delete(int.parse(id));
              });
            }),
      ),
    ]);
  }

  void _getAll() async {
    final all = await helper.getAlldata();
    studentList.clear();
    for (int i = 0; i < all.length; i++) {
      studentList.add(Student.fromMap(all[i]));
    }
  }

  void delete(id) async {
    final deleteRow = await helper.delete(id);
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("delete $deleteRow row(s): row $id")));
  }

}
