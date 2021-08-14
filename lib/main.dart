import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'addYourNote.dart';
import 'package:notes_new/editYourNote.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {"/":(context)=>HomePage()},
      debugShowCheckedModeBanner: false,
    );
    
  }
}
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ref =FirebaseFirestore.instance.collection("Notes");
   TextEditingController title =TextEditingController();
  TextEditingController content =TextEditingController();
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyNotes'),),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
      onPressed:(){
        Navigator.push(context, MaterialPageRoute(builder: (_)=>AddNote()));
      }
      ,),
      body: StreamBuilder<QuerySnapshot>(
        stream: ref.snapshots(),
        builder: (context,snapshot) {
          if(snapshot.hasData){
             final data = snapshot.requireData;
          return GridView.builder(gridDelegate:(SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)),
          itemCount: data.size,
           itemBuilder: (_,index){
             return GestureDetector(
               onTap:(){Navigator.push(context, MaterialPageRoute(builder: (_)=>EditYourNote(docToEdit: snapshot.data!.docs[index],))); 
               },
               child: Container(
                 margin: EdgeInsets.all(10),
                 height: 150,
                 color: Colors.grey[200],
                 child: Column(
                   children: [
                     Text(
                    ' ${DateTime.now()}'
                     ),
                     Text(snapshot.data!.docs[index]['title']),
                     Text(snapshot.data!.docs[index]['content'])
                     
                   ],
                 ),
               ),
             );
           });
          }
          else {
            return Center(child: Text("Loading"));
          }
          
        }
      ),

      
      
    );
  }
}
