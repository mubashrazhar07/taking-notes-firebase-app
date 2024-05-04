import 'package:flutter/material.dart';
import 'package:taking_notes_firebase_app/utils/theme/constants/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taking_notes_firebase_app/utils/utils.dart';

class DetailScreen extends StatefulWidget {
  final String ddate;
  final String initialText;
  final String id;

  DetailScreen({super.key, required this.ddate, required this.initialText, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late TextEditingController editController;
  final streamVariable =
      FirebaseFirestore.instance.collection('asif').snapshots();
  final updateVariable =
  FirebaseFirestore.instance.collection('asif');

  @override
  void initState() {
    super.initState();
    editController = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kprimaryBlack,
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                updateVariable.doc(widget.id).update({
                  'notes': editController.text,

                }).then((value){
                  Utils().toastMessage('upadted');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Icon(Icons.more),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: streamVariable,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) return const Text('some error');
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.ddate,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines:  20,
                    controller: editController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xff1f1f1f),
                      hintText: 'Enter your note...',
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xffC7C7C7),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.lightBlue,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
