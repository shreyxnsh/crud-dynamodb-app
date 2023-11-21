import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dynamodbcrud/utils/snackbar.dart';
import 'package:http/http.dart' as http;

class UpdateUserScreen extends StatefulWidget {
  @override
  _UpdateUserScreenState createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  List<Map<String, dynamic>> users = []; // List to store user data
  bool isRefreshing = false;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.56.1:3000/api/users'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          users = List<Map<String, dynamic>>.from(data);
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      print('Error loading user data: $error');
    }
  }

  Future<void> updateUser(String userId, String newName, String newEmail, String newContact) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.56.1:3000/api/users/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': newName,
          'email': newEmail,
          'contact': newContact,
        }),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        fetchUsers();
        SnackbarHelper.showSnackbar(context, 'User updated successfully');
      } else {
        throw Exception('Failed to update user');
      }
    } catch (error) {
      print('Error updating user: $error');
      SnackbarHelper.showSnackbar(context, 'Error updating user. $error');
    }
  }

  Future<void> _showUpdateDialog(Map<String, dynamic> userData) async {
    TextEditingController nameController = TextEditingController(text: userData['name']);
    TextEditingController emailController = TextEditingController(text: userData['email']);
    TextEditingController contactController = TextEditingController(text: userData['contact']);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
              SizedBox(height: 10),
              TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
              SizedBox(height: 10),
              TextField(controller: contactController, decoration: InputDecoration(labelText: 'Contact')),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                final String userId = userData['id'];
                updateUser(userId, nameController.text, emailController.text, contactController.text);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleRefresh() async {
    setState(() {
      isRefreshing = true;
    });

    await fetchUsers();

    setState(() {
      isRefreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update User"),
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final userData = users[index];
            return ListTile(
              title: Text(userData['name']),
              subtitle: Text(userData['email']),
              trailing: ElevatedButton(
                onPressed: () {
                  _showUpdateDialog(userData);
                },
                child: Text('Update'),
              ),
            );
          },
        ),
      ),
    );
  }
}