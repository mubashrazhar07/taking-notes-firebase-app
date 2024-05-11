import 'package:flutter/material.dart';
import 'package:taking_notes_firebase_app/utils/theme/constants/app_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taking_notes_firebase_app/utils/utils.dart';

class DetailScreen extends StatefulWidget {
  final String ddate;
  final String initialText;
  final String id;

  const DetailScreen(
      {super.key,
      required this.ddate,
      required this.initialText,
      required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late TextEditingController editController;
  final streamVariable =
      FirebaseFirestore.instance.collection('asif').snapshots();
  final updateVariable = FirebaseFirestore.instance.collection('asif');
  final deleteVariablemainlist = FirebaseFirestore.instance.collection('asif');
  final favoriteupdateVariable = FirebaseFirestore.instance.collection('favoritesnotes');
  final deleteVariablefavoritelist = FirebaseFirestore.instance.collection('favoritesnotes');

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
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,
                color: Theme.of(context).colorScheme.onSecondary),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  updateVariable.doc(widget.id).update({
                    'notes': editController.text,
                  }).then((value) {
                    favoriteupdateVariable.doc(widget.id).update({
                      'notes': editController.text,
                    });
                    Utils().toastMessage('Updated');
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                },
                child: Text('Save', style: TextStyle( color: Theme.of(context).colorScheme.onSecondary,),)),
            TextButton(
                onPressed: () {
                deleteVariablemainlist.doc(widget.id).delete().then((value) {
                  deleteVariablefavoritelist.doc(widget.id).delete();
                });
                    Navigator.pop(context);
                    Utils().toastMessage('Deleted');
                },
                child: Text('Delete', style: TextStyle( color: Theme.of(context).colorScheme.onSecondary,),)),


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
                    maxLines: 20,
                    controller: editController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xff1f1f1f),
                      hintText: 'Enter your note...',
                      enabledBorder: OutlineInputBorder(
                        borderSide:  BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary,
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
                        borderSide:  BorderSide(
                          color: Theme.of(context).colorScheme.onSecondary,
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
