import 'package:flutter/material.dart';
import 'package:taking_notes_firebase_app/ui/detail_screen.dart';
import 'package:taking_notes_firebase_app/ui/notes/favorites_screen.dart';
import '../../utils/theme/constants/app_color.dart';
import 'add_notes_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GridViewListViewToggle extends StatefulWidget {
  const GridViewListViewToggle({
    super.key,
  });

  @override
  State<GridViewListViewToggle> createState() => _GridViewListViewToggleState();
}

class _GridViewListViewToggleState extends State<GridViewListViewToggle> {
  bool gridView = true;
  final firestoreNote = FirebaseFirestore.instance.collection('asif').snapshots();
  final ref = FirebaseFirestore.instance.collection('asif');
//Favorite screen data
  final favoriteFirebaseNote=  FirebaseFirestore.instance.collection('favoritesnotes');


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: gridView ? const Text('GridView') : const Text('List View'),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteNotesScreen()));
              },
              child: const Icon(Icons.favorite)),
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
                        ? const Icon(
                            Icons.toggle_on_sharp,
                            color: Colors.green,
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
                stream: firestoreNote,
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

                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: kprimaryBlack,
                                        borderRadius: BorderRadius.circular(0),
                                        border: Border.all(color: Colors.white),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(ddate:snapshot.data!
    .docs[index]['date']
    .toString(), initialText: snapshot.data!
    .docs[index]['notes']
    .toString(), id: snapshot.data!
    .docs[index]['id']
    .toString(),)));
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

                                      leading: InkWell(
                                          onTap:(){
                                            String id = DateTime.now().millisecondsSinceEpoch.toString();
                                       favoriteFirebaseNote.doc(id).set({
                                         'notes':snapshot.data!
                                             .docs[index]['notes']
                                           .toString(),
                                             'date': snapshot.data!
                                           .docs[index]['date']
                                           .toString(),
                                         'id': id
                                       });
                                          },
                                          child: const Icon(Icons.favorite)),
                                      title: Text(snapshot
                                              .data!.docs[index]['notes']
                                              .substring(0, 2) +
                                          '...'),
                                      subtitle: Text(
                                        snapshot.data!.docs[index]['date']
                                            .toString(),
                                        style: const TextStyle(color: Colors.grey),
                                      ),
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
