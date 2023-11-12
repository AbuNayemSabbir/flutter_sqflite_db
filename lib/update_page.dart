import 'package:flutter/material.dart';
import 'package:flutter_sqflite_db/home_page.dart';
import 'package:flutter_sqflite_db/sqflite_db/db_helper.dart';

import 'user_model.dart';

class UpdateUserPage extends StatefulWidget {
  final User user;

  UpdateUserPage(this.user, {super.key});

  @override
  _UpdateUserPageState createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final DBHelper _dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    emailController.text = widget.user.email;
  }

  void _updateUser() async {
    final updatedUser = User(
      id: widget.user.id,
      name: nameController.text,
      email: emailController.text,
    );

    int result = await _dbHelper.updateUser(updatedUser);

    if (result > 0) {
      // User data was successfully updated
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User data updated successfully.'),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // User data failed to update
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update user data.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update User Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateUser(); // Call the method to update the user data
              },
              child: Text('Update User'),
            ),
          ],
        ),
      ),
    );
  }
}
