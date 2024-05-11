import 'package:flutter/material.dart';
import 'package:taking_notes_firebase_app/ui/detail_screen.dart';
import 'package:taking_notes_firebase_app/ui/notes/favorites_screen.dart';
import '../../utils/theme/constants/app_color.dart';
import 'add_notes_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GridViewListViewToggle extends StatefulWidget {
  String ? id;
 GridViewListViewToggle({
    super.key,  this.id
  });

  @override
  State<GridViewListViewToggle> createState() => _GridViewListViewToggleState();
}

class _GridViewListViewToggleState extends State<GridViewListViewToggle> {
  final currentUser = FirebaseAuth.instance;
  bool appbarFavIconColor = false;
  bool gridView = true;
  final firestoreNote =
      FirebaseFirestore.instance.collection('asif').snapshots();
  final ref = FirebaseFirestore.instance.collection('asif');
//Favorite screen data
  final favoriteFirebaseNote =
      FirebaseFirestore.instance.collection('favoritesnotes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: gridView
            ? Text('GridView',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary))
            : Text('List View',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary)),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,
              color: Theme.of(context).colorScheme.onSecondary),
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavoriteNotesScreen()));
              },
              child: Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.onSecondary,
              )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
                onTap: () {
                  setState(() {
                    gridView = !gridView;
                  });
                },
                child: SizedBox(
                    child: gridView
                        ? Icon(
                            Icons.toggle_on_sharp,
                            color: Theme.of(context).colorScheme.onSecondary,
                          )
                        : const Icon(
                            Icons.toggle_off,
                            color: Colors.white,
                          ))),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('asif')
                    .where('uid', isEqualTo: currentUser.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) return const Text('some error');
                  return Expanded(
                      child: gridView
                          ? MasonryGridView.count(
                              itemCount: snapshot.data!.docs.length,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  ddate: snapshot
                                                      .data!.docs[index]['date']
                                                      .toString(),
                                                  initialText: snapshot.data!
                                                      .docs[index]['notes']
                                                      .toString(),
                                                  id: widget.id.toString()
                                                )));
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: kprimaryBlack,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(22.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              snapshot.data!.docs[index]['date']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              snapshot
                                                  .data!.docs[index]['notes']
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      )),
                                );
                              })
                          : ListView.builder(
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
                                                      id: widget.id.toString()
                                                    )));
                                        /* ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                                        'notes': 'I Am Good',

                                      }).then((value){
                                        Utils().toastMessage('upadted');
                                      }).onError((error, stackTrace) {
                                        Utils().toastMessage(error.toString());
                                      });*/
                                        /* ref
                                        .doc(snapshot.data!.docs[index]['id']
                                            .toString())
                                        .delete();*/
                                      },
                                      title: Text(snapshot
                                              .data!.docs[index]['notes']
                                              .substring(0, 7) +
                                          '...'),
                                      subtitle: Text(
                                        snapshot.data!.docs[index]['date']
                                            .toString(),
                                        style:
                                            const TextStyle(color: Colors.grey),
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
                                                                      id: widget.id.toString()
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

                                                    favoriteFirebaseNote
                                                        .doc(widget.id)
                                                        .set({
                                                      'notes': snapshot.data!
                                                          .docs[index]['notes']
                                                          .toString(),
                                                      'date': snapshot.data!
                                                          .docs[index]['date']
                                                          .toString(),
                                                      'id': widget.id
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
                                                    ref
                                                        .doc(widget.id)
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
                              }));
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNotesScreen()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
