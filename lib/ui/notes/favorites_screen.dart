import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
