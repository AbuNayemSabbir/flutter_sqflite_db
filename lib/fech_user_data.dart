import 'package:flutter/material.dart';
import 'package:flutter_sqflite_db/sqflite_db/db_helper.dart';
import 'package:flutter_sqflite_db/user_model.dart';

class DisplayUserInfoPage extends StatefulWidget {
  @override
  _DisplayUserInfoPageState createState() => _DisplayUserInfoPageState();
}

class _DisplayUserInfoPageState extends State<DisplayUserInfoPage> {
  final DBHelper _db_helper = DBHelper();
  List<User> _users = [];

  void fetchUser() async {
    List<User> users = await _db_helper.getUsers();
    setState(() {
      _users = users;
    });
  }

  @override
  void initState() {
    fetchUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User Information'),
        ),
        body: ListView.builder(
          itemCount: _users.length,
          itemBuilder: (context, index) {
             var user = _users[index];
            return Card(
              child: ListTile(
                 title: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
                 subtitle: Text(user.email),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
