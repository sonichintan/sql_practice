import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Helper.dart';

class Delete extends StatefulWidget {

  Delete({Key key}) : super(key: key);

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {

  final Helper helper = Helper.instance;
  TextEditingController did = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("delete data"),
      ),
      body: deletedesign(),
    );
  }

  Widget deletedesign(){
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            children: [
              TextField(
                textInputAction: TextInputAction.done,
                controller: did,
                decoration: InputDecoration(
                  labelText: "ID",
                  hintText: "id",
                  border: OutlineInputBorder(),
                ),
              ),SizedBox(height: 30,),
              Container(
                  width: 150,
                  height: 45,
                  child: RaisedButton(
                      onPressed: () {
                        delete(int.parse(did.text));
                      },
                      child: Text("Delete")))]));
  }

  void delete(id) async {
    final deleteRow = await helper.delete(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("delete $deleteRow row(s): row $id")));
  }

}
