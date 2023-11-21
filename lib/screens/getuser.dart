import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class GetUserScreen extends StatefulWidget {
  @override
  _GetUserScreenState createState() => _GetUserScreenState();
}

class _GetUserScreenState extends State<GetUserScreen> {
  List<User> userList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.56.1:3000/api/users'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          userList = data.map((item) => User.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error loading data: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userList.isEmpty
              ? Center(child: Text('No users available'))
              : ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text(userList[index].name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email: ${userList[index].email}'),
                            Text('Contact: ${userList[index].contact}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String contact;

  User({required this.id, required this.name, required this.email, required this.contact});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      contact: json['contact'],
    );
  }
}
