import 'package:dynamodbcrud/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert';

class CreateUserScreen extends StatelessWidget {
  CreateUserScreen({Key? key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  Future<void> createUser(BuildContext context) async {
  final url = Uri.parse('http://192.168.56.1:3000/api/users');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': nameController.text,
        'email': emailController.text,
        'contact': contactController.text,
      }),
    );

    if (response.statusCode == 201) {
      print('User created successfully');
      SnackbarHelper.showSnackbar(context, 'User created successfully');
    } else {
      print('Failed to create user. Status code: ${response.statusCode}');
      SnackbarHelper.showSnackbar(context, 'Failed to create user. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error creating user: $error');
    SnackbarHelper.showSnackbar(context, 'Error creating user. $error');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create User"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                Form(
                  child: Column(
                    children: [
                      _buildBorderedTextField(
                        controller: nameController,
                        label: "Name",
                        prefixIcon: Icons.account_circle,
                      ),
                      const SizedBox(height: 20),
                      _buildBorderedTextField(
                        controller: emailController,
                        label: "Email",
                        prefixIcon: Icons.email,
                      ),
                      const SizedBox(height: 20),
                      _buildBorderedTextField(
                        controller: contactController,
                        label: "Contact",
                        prefixIcon: Icons.phone,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    createUser(context); // Call the createUser function
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBorderedTextField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        controller: controller,
        expands: false,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(prefixIcon),
          border: InputBorder.none, // To remove the default border
        ),
      ),
    );
  }
}
