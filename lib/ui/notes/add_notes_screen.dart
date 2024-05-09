
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taking_notes_firebase_app/ui/shared_components/custom_button.dart';
import 'package:taking_notes_firebase_app/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'gridview_listview_toggle.dart';
class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  final addnoteController = TextEditingController();
  final currentUser= FirebaseAuth.instance;
  final firestoreNote = FirebaseFirestore.instance.collection('asif');
  final ref= FirebaseFirestore.instance.collection('asif');
  bool loading =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(' Add Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Note',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Title',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: TextFormField(
                 minLines: 2,

                  maxLines:  20,

                  controller: addnoteController,
                  decoration: InputDecoration(
                      hintText: 'Add Notes Here...',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            style: BorderStyle.solid, color: Colors.white24),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                            style: BorderStyle.solid, color: Colors.white24),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(loading: loading,
                buttonText: 'Add Notes',
                onTap: () {
                  setState(() {
                    loading=true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  String date= DateTime.now().toString();
                  firestoreNote
                      .doc(id)
                      .set({
                        'notes': addnoteController.text.toString(),
                        'id': id,
                    'date':date,
                    'uid' :currentUser.currentUser!.uid
                      })
                      .then((value) {
                        Utils().toastMessage('Post Uploaoded');
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GridViewListViewToggle()));
                        setState(() {
                    loading=false;
                  });})
                      .onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                        setState(() {
                    loading=false;
                  });});

                })
          ],
        ),
      ),
    );
  }
}
