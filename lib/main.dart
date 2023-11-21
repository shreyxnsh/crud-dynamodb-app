import 'package:dynamodbcrud/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Assuming your home screen file is named home_screen.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DynamoDB CRUD Operations',
      home: HomeScreen(),
      // Define named routes if needed
    );
  }
}
