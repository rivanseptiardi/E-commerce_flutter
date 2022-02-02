import 'package:flutter/material.dart';

class View extends StatefulWidget {
  //const View({ Key? key }) : super(key: key);

  List list;
  int index;
  View({required this.index, required this.list});

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: new Text("Detail Harga"),
      ),
      body: new SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                new Text(
                  "${widget.list[widget.index]['title']}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                new Image.network("${widget.list[widget.index]['img']}"),
                new Padding(padding: const EdgeInsets.only(top: 20.0)),
                new Text(
                  "${widget.list[widget.index]['desc']}",
                  style: new TextStyle(fontSize: 15.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
