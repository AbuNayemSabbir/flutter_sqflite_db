import 'package:flutter/material.dart';
import 'package:flutter_sqflite_db/sqflite_db/db_helper.dart';
import 'package:flutter_sqflite_db/update_page.dart';
import 'package:flutter_sqflite_db/user_model.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({super.key});

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final DBHelper _dbHelper = DBHelper();
  List<User> _users = [];


  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() async {
    List<User> users = await _dbHelper.getUsers();
    setState(() {
      _users = users;
    });
  }

  void _deleteUser(int userId) async {
    await _dbHelper.deleteUser(userId);
    _fetchUsers();
  }

  void _updateUser(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateUserPage(user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fetch Page')),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          User user = _users[index];
          return ListTile(
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteUser(user.id!);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _updateUser(user);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
