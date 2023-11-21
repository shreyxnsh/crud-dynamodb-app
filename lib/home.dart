import 'package:dynamodbcrud/screens/createuser.dart';
import 'package:dynamodbcrud/screens/deleteuser.dart';
import 'package:dynamodbcrud/screens/getuser.dart';
import 'package:dynamodbcrud/screens/updateuser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DynamoDB CRUD Operations"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => CreateUserScreen()); // Pass a callback function
                },
                child: const Text("Create User"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // Add navigation logic for "Get Users"
                  Get.to(() => GetUserScreen());
                },
                child: const Text("Get Users"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // Add navigation logic for "Update User"
                  Get.to(() => UpdateUserScreen());
                },
                child: const Text("Update User"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  // Add navigation logic for "Delete User"
                  Get.to(() => DeleteUserScreen());
                },
                child: const Text("Delete User"),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
