import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firestore/main.dart';
import 'package:crud_firestore/add.dart';

class Edit extends StatefulWidget {
  //const Edit({Key? key}) : super(key: key);

  List list;
  int index;
  Edit({required this.index, required this.list});

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _shortdescController = TextEditingController();
  TextEditingController _descall = TextEditingController();
  TextEditingController _image = TextEditingController();
  CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('news');

  @override
  void initState() {
    _titleController =
        new TextEditingController(text: widget.list[widget.index]['title']);
    _shortdescController = new TextEditingController(
        text: widget.list[widget.index]['short_desc']);
    _descall =
        new TextEditingController(text: widget.list[widget.index]['desc']);
    _image = new TextEditingController(text: widget.list[widget.index]['img']);
  }

  Future<void> update([DocumentSnapshot? documentSnapshot]) async {
    final String? vartitle = _titleController.text;
    final String? varshortdesc = _shortdescController.text;
    final String? vardesc = _descall.text;
    final String? varimage = _image.text;

    await _newsCollection.doc(documentSnapshot!.id).update({
      //update method
      "title": vartitle,
      "short_desc": varshortdesc,
      "desc": vardesc,
      "img": varimage,
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => new MyApp()));
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: new Text("Tambah Data"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _titleController,
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: 'title'),
                ),
                TextField(
                  controller: _shortdescController,
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: 'short desc'),
                ),
                TextField(
                  controller: _descall,
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: 'desc'),
                ),
                TextField(
                  controller: _image,
                  minLines: 1,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: 'image url'),
                ),
                SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    child: const Text("Edit"),
                    color: Colors.blueAccent,
                    onPressed: () => update(widget.list[widget.index])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
