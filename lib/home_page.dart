import 'package:crud_firestore/add.dart';
import 'package:crud_firestore/edit.dart';
import 'package:crud_firestore/view.dart';
import 'package:crud_firestore/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:crud_firestore/home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String tag = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _shortdescController = TextEditingController();

  final CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('news');

  Future<void> _deleteProduct(String productId) async {
    await _newsCollection.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have succesfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopink'),
        actions: <Widget>[
          MaterialButton(
            textColor: Colors.white,
            onPressed: () {
              Login.statuslogin = 0;
              Navigator.of(context).pushReplacementNamed(Login.tag);
            },
            child: Text("Logout"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _newsCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return new Container(
                  padding: const EdgeInsets.all(10.0),
                  //child gesturedetector
                  child: new GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new View(
                                list: streamSnapshot.data!.docs,
                                index: index))),
                    //
                    child: Card(
                      margin: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text(documentSnapshot['title']),
                        subtitle: Text(documentSnapshot['short_desc']),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => Navigator.of(context).push(
                                  new MaterialPageRoute(
                                    builder: (BuildContext context) => new Edit(
                                        list: streamSnapshot.data!.docs,
                                        index: index),
                                  ),
                                ),
                              ),
                              //_createOrUpdate(documentSnapshot)),
                              IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () =>
                                      _deleteProduct(documentSnapshot.id)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new Add())),
        child: Icon(Icons.add),
      ),
    );
  }
}
