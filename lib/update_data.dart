import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sql_practice/main.dart';
import 'package:sql_practice/model.dart';

import 'Helper.dart';
import 'Student.dart';

class Update extends StatefulWidget {
  String cid, cname, cage;

  Update({Key key, this.cid, this.cname, this.cage}) : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  void initState() {
    super.initState();
    print(widget.cid);
    for (int i = 0; i < Global.advance.length; i++) {
      if (Global.advance[i].getId().toString() == widget.cid) {
        eid.text = Global.advance[i].getId().toString();
        ename.text = Global.advance[i].getName();
        eage.text = Global.advance[i].getAge().toString();
      }
    }
  }

  final Helper helper = Helper.instance;

  TextEditingController eid = new TextEditingController();
  TextEditingController ename = new TextEditingController();
  TextEditingController eage = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update data"),
      ),
      body: dialog(),
    );
  }

  Widget updateDesign() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            textInputAction: TextInputAction.next,
            controller: eid,
            enabled: false,
            decoration: InputDecoration(
              labelText: widget.cid,
              hintText: "id",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            textInputAction: TextInputAction.next,
            controller: ename,
            decoration: InputDecoration(
              labelText: widget.cname,
              hintText: "name",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            textInputAction: TextInputAction.done,
            controller: eage,
            decoration: InputDecoration(
              labelText: widget.cage,
              hintText: "age",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              width: 150,
              height: 45,
              child: OutlinedButton(
                  onPressed: () {
                    update(int.parse(widget.cid), ename.text,
                        int.parse(eage.text));
                    //zNavigator.push(context, MaterialPageRoute(builder: (context)=>sqlite()));
                  },
                  child: Text("Update")))
        ],
      ),
    );
  }

  void update(id, name, age) async {
    Student student = Student(id, name, age);
    final row = await helper.update(student);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("update $row row(s)")));
  }

  Widget dialog() {
    return Container(
      child: AlertDialog(
              title: Text("Edit User"),
              actions: [
                Column(
                  children: [
                    TextField(
                      textInputAction: TextInputAction.next,
                      controller: eid,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: widget.cid,
                        hintText: "id",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      textInputAction: TextInputAction.next,
                      controller: ename,
                      decoration: InputDecoration(
                        labelText: widget.cname,
                        hintText: "name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      textInputAction: TextInputAction.done,
                      controller: eage,
                      decoration: InputDecoration(
                        labelText: widget.cage,
                        hintText: "age",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(onPressed: (){}, child: Text("Edit User"))
              ],
            ),
    );
  }
}
