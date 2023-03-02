import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mithas/view_model.dart';

class UserProfilePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModelProvider = ref.watch(viewModel);
    TextEditingController _addressController = TextEditingController();
    _addressController.text = viewModelProvider.customerAddress.toString();
    TextEditingController _contactController = TextEditingController();
    _contactController.text = viewModelProvider.customerContactNo.toString();
    TextEditingController _nameController = TextEditingController();
    _nameController.text = viewModelProvider.customerName.toString();
    TextEditingController _emailController = TextEditingController();
    _emailController.text = viewModelProvider.customerEmail.toString();
    final uidGenFireBase = viewModelProvider.uidGenFirebase.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFc0aaa3),
        title: Text(
          'My Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.0),
            Text(
              'NAME',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7d4d40),
              ),
            ),
            SizedBox(height: 5.0),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Enter Your Name',
              ),
              style: TextStyle(
                fontSize: 20.0,
                color: Color(0xFF7d4d40),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'EMAIL',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7d4d40),
              ),
            ),
            SizedBox(height: 5.0),
            TextFormField(
              enabled: false,
              controller: _emailController,
              style: TextStyle(
                fontSize: 20.0,
                color: Color(0xFF7d4d40),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'ADDRESS:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7d4d40),
              ),
            ),
            SizedBox(height: 5.0),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: 'Enter your address',
              ),
              style: TextStyle(
                fontSize: 20.0,
                color: Color(0xFF7d4d40),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'CONTACT NO:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7d4d40),
              ),
            ),
            SizedBox(height: 5.0),
            TextFormField(
              controller: _contactController,
              decoration: InputDecoration(
                hintText: 'Enter your contact number',
              ),
              style: TextStyle(
                fontSize: 20.0,
                color: Color(0xFF7d4d40),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                await viewModelProvider.updateUserProfile(
                    _emailController.text,
                    _nameController.text,
                    _addressController.text,
                    _contactController.text,
                    uidGenFireBase);
              },
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
