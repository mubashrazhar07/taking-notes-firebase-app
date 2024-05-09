import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taking_notes_firebase_app/ui/detail_screen.dart';
import '../../utils/theme/constants/app_color.dart';

class FavoriteNotesScreen extends StatefulWidget {
  FavoriteNotesScreen({
    super.key,
  });

  @override
  State<FavoriteNotesScreen> createState() => _FavoriteNotesScreenState();
}

class _FavoriteNotesScreenState extends State<FavoriteNotesScreen> {
  final ref =
      FirebaseFirestore.instance.collection('favoritesnotes').snapshots();
  final refdelete = FirebaseFirestore.instance.collection('favoritesnotes');
  final updatefavoritenots = FirebaseFirestore.instance.collection('favoritesnotes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kprimaryBlack,
        actions: const [
          Icon(Icons.save),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.more),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: ref,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    const Text(
                      'some error',
                      style: TextStyle(color: Colors.white),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: kprimaryBlack,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white),
                              ),
                              child: ListTile(
                                onTap: () {
                                  refdelete
                                      .doc(snapshot.data!.docs[index]['id']
                                          .toString())
                                      .delete();
                                },
                                title:
                                    Text(snapshot.data!.docs[index]['notes']),
                                subtitle: Text(
                                  snapshot.data!.docs[index]['date'].toString(),
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                trailing: PopupMenuButton(
                                    color: Colors.black,
                                    child: const Icon(Icons.more),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                          child: InkWell(

                                            onTap:(){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailScreen(
                                                            ddate: snapshot.data!
                                                                .docs[index]['date']
                                                                .toString(),
                                                            initialText: snapshot
                                                                .data!
                                                                .docs[index]['notes']
                                                                .toString(),
                                                            id: snapshot.data!
                                                                .docs[index]['id']
                                                                .toString(),
                                                          )));

                                            },
                                            child: ListTile(
                                              hoverColor:
                                              Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                              leading: Icon(Icons.edit),
                                              title: Text('Edit'),
                                            ),
                                          )),
                                      PopupMenuItem(
                                          child: InkWell(
                                            onTap: () {
                                              String id = DateTime.now()
                                                  .millisecondsSinceEpoch
                                                  .toString();
                                              updatefavoritenots
                                                  .doc(id)
                                                  .set({
                                                'notes': snapshot.data!
                                                    .docs[index]['notes']
                                                    .toString(),
                                                'date': snapshot.data!
                                                    .docs[index]['date']
                                                    .toString(),
                                                'id': id
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: ListTile(
                                              leading:
                                              Icon(Icons.favorite),
                                              title: Text('Favorite'),
                                            ),
                                          )),
                                      PopupMenuItem(
                                          child: InkWell(
                                            onTap: () {
                                              refdelete
                                                  .doc(snapshot.data!
                                                  .docs[index]['id']
                                                  .toString())
                                                  .delete();
                                              Navigator.pop(context);
                                            },
                                            child: ListTile(
                                              leading: Icon(Icons.delete),
                                              title: Text('Delete'),
                                            ),
                                          ))
                                    ]),
                              ),
                            ),
                          );
                        }),
                  );
                })
          ],
        ),
      ),
    );
  }
}
