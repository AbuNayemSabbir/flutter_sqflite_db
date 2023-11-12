import 'package:flutter/material.dart';
import 'package:flutter_sqflite_db/home_page.dart';
import 'package:flutter_sqflite_db/sqflite_db/db_helper.dart';
import 'package:flutter_sqflite_db/user_model.dart';

class UserInputForm extends StatefulWidget {
  @override
  _UserInputFormState createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final DBHelper _db_helper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Input Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                saveUser();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveUser() async {
    final user = User(name: nameController.text, email: emailController.text);
    int userId = await _db_helper.insertUser(user);
    if (userId != -1) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Data Save SucessFully")));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));

    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Data Save Failed")));
    }
  }
}
