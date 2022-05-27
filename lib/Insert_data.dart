import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sql_practice/main.dart';

import 'Helper.dart';
import 'Student.dart';

class insert_data extends StatefulWidget {

   String iname,iage;
   insert_data({Key key,this.iname,this.iage}) : super(key: key);

  @override
  State<insert_data> createState() => _insert_dataState();
}

class _insert_dataState extends State<insert_data> {

  final Helper helper = Helper.instance;
  TextEditingController name = new TextEditingController();
  TextEditingController age = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("insert data"),
      ),
      body: insert(),
    );
  }
  Widget insert(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            textInputAction: TextInputAction.next,
            controller: name,
            decoration: InputDecoration(
              labelText: "Name",
              hintText: "Name",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: age,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: "Age",
              hintText: "Age",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 150,
              height: 45,
              child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      if(name.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter your name")));
                      }else if(age.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please enter your age")));
                      }else{}
                    });
                    _insert(name.text, int.parse(age.text));
                   Navigator.pop(context,MaterialPageRoute(builder: (context)=>sqlite(uname: name.text,uage: age.text,)));
                  },
                  child: Text("Insert")))
        ],
      ),
    );
  }

  void _insert(name, age) async {
    Map<String, dynamic> map = {Helper.colName: name, Helper.colAge: age};
    Student student = Student.fromMap(map);
    final int id = await helper.insert(student);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Row inserted $id")));
  }
}
