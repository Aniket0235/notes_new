import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



// ignore: must_be_immutable
class AddNote extends StatelessWidget {
  TextEditingController title =TextEditingController();
  TextEditingController content =TextEditingController();

  CollectionReference ref =FirebaseFirestore.instance.collection('Notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions:[
          FlatButton(onPressed: (){
             ref.add({
              'title':title.text,
              'content':content.text
            }).whenComplete(() => Navigator.pop(context));
           
          }, child: Text('Save'))

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

