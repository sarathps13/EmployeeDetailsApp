import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_project/main.dart';
import 'package:hive_project/model/employeeModel.dart';
import 'package:hive_project/widgets/listScreen.dart';
import 'package:image_picker/image_picker.dart';

class EditScreen extends StatefulWidget {
  EditScreen(
      {super.key,
      required this.name,
      required this.age,
      required this.gmail,
      required this.phone,
      required this.index,
      required this.urImage});
  final String name;
  final String age;
  final String gmail;
  final String phone;
  final int index;
  String urImage;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _image;

  getImage() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image!.path;
    });
  }

  @override
  void initState() {
    _nameController.text = widget.name;
    _ageController.text = widget.age;
    _gmailController.text = widget.gmail;
    _phoneController.text = widget.phone;

    _image = widget.urImage;

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _gmailController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => const ListScreen()));
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text(
          'EDIT EMBLOYEE DETAILS !',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              final valid = _formKey.currentState!.validate();
              final data = EmployeeModel(
                name: _nameController.text,
                age: _ageController.text,
                gmail: _gmailController.text,
                phone: _phoneController.text,
                urImage: _image,
              );

              Hive.box<EmployeeModel>('employeedb').putAt(widget.index, data);
              if (valid &&
                  data.name!.isNotEmpty &&
                  data.age!.isNotEmpty &&
                  data.gmail!.isNotEmpty &&
                  data.phone!.isNotEmpty) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListScreen()));
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text(' Employee Details Updated'),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            icon: const Icon(Icons.upgrade_sharp),
            label: const Text(
              'UPDATE',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 14,
                    controller: _nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter name';
                      }
                      if (value.length < 5) {
                        return 'Please enter full name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 3,
                    controller: _ageController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Age'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter Age';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _gmailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'gmail'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter Gmail';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{3}$')
                          .hasMatch(value)) {
                        return 'Please enter vaild gmail';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    controller: _phoneController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Phone'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter Phone';
                      }
                      if (value.length <= 9) {
                        return 'please enter valid number';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Image.file(File(_image!))
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImage();
        },
        child: const Icon(
          Icons.camera,
          color: Colors.black,
          size: 35,
        ),
      ),
    );
  }
}
