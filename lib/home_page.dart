import 'package:flutter/material.dart';
import 'package:flutter_sqflite_db/create_user_data.dart';

import 'fech_user_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayUserInfoPage()));

            }, child: Text("Fetch Data")),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserInputForm()));
            }, child: Text("Create Data")),
          ],
        ),
      ),
    );
  }
}
