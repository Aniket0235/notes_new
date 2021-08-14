import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditYourNote extends StatefulWidget {
 
    DocumentSnapshot docToEdit;
    EditYourNote({required this.docToEdit});
  @override
  _EditYourNoteState createState() => _EditYourNoteState();
}

class _EditYourNoteState extends State<EditYourNote> {
  @override
 TextEditingController title =TextEditingController();
  TextEditingController content =TextEditingController();

  CollectionReference ref =FirebaseFirestore.instance.collection('Notes');
@override
void initState(){
  title=TextEditingController(text: widget.docToEdit['title']);
  content=TextEditingController(text: widget.docToEdit['content']);
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions:[
          FlatButton(onPressed: (){
            widget.docToEdit.reference.update({
              'title':title.text,
              'content':content.text
            }).whenComplete(() => Navigator.pop(context));
           
          }, child: Text('Save')),
           FlatButton(onPressed: (){
            widget.docToEdit.reference.delete()
             .whenComplete(() => Navigator.pop(context));
           
          }, child: Text('delete'))


        ] 
         
      ),
      body: Container(
        
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                decoration: InputDecoration(hintText: 'Title',),
                style:TextStyle(fontSize:35,fontWeight: FontWeight.bold),
              ),
            ),
            
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: 'Content'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  }
