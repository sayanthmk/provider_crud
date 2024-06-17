import 'package:crud_provider/changenotifier.dart';
import 'package:crud_provider/model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({super.key});

  @override
  AddStudentWidgetState createState() => AddStudentWidgetState();
}

class AddStudentWidgetState extends State<AddStudentWidget> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _countryController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Student',
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              ///////////////////
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue,
                      child: _selectedImage != null
                          ? Image.file(
                              File(_selectedImage!),
                              fit: BoxFit.fill,
                            )
                          : const Text('empty'),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Hello"),
                            actions: [
                              InkWell(
                                onTap: () {
                                  _pickImageFromGallery();
                                  Navigator.pop(context);
                                },
                                child: const Text("No"),
                              ),
                              InkWell(
                                onTap: () {
                                  _pickImageFromCamera();
                                  Navigator.pop(context);
                                },
                                child: const Text("Yes"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.green,
                          child: Icon(Icons.add)),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Age',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Age is empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Country',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Country is empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Phone',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone is empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addStudent();
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shadowColor: Colors.blueAccent,
                  elevation: 5, // Elevation
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20.0), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 16), // Padding
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      _selectedImage = pickedImage.path;
    });
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage == null) return;
    setState(() {
      _selectedImage = pickedImage.path;
    });
  }

  void _addStudent() {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final country = _countryController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty ||
        age.isEmpty ||
        country.isEmpty ||
        phone.isEmpty ||
        _selectedImage == null) {
      return;
    }

    final student = StudentModel(
      name: name,
      age: age,
      country: country,
      phone: phone,
      selectimage: _selectedImage!,
    );

    Provider.of<StudentProvider>(context, listen: false).addStudent(student);
  }
}
