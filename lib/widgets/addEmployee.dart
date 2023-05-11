import 'dart:io';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_project/model/employeeModel.dart';

import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final _formKey = GlobalKey<FormState>();
  String? _image;
  String? name;
  String? age;
  String? gmail;
  String? phone;

  Future<void> getImage() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image!.path;
    });
  }

  submitData() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid && _image!.isNotEmpty) {
      Hive.box<EmployeeModel>('employeedb').add(EmployeeModel(
          name: name, age: age, gmail: gmail, phone: phone, urImage: _image));

      Navigator.pop(context);
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('New Employee Details Added'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'ADD EMPLOYEE DETAILS',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
          ),
          actions: [
            ElevatedButton.icon(
                onPressed: () {
                  submitData();
                },
                icon: const Icon(Icons.save_sharp),
                label: const Text(
                  'SAVE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ]),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Name'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter name';
                    }
                    if (value.length < 5) {
                      return 'Please enter full name';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Age'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter age';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      age = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Gmail'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter gmail';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{3}$')
                        .hasMatch(value)) {
                      return 'Please enter vaild gmail';
                    }

                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      gmail = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Phone'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter phone';
                    }
                    if (value.length <= 9) {
                      return 'please enter valid number';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      phone = val;
                    });
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                _image == null
                    ? Container(
                        height: 380,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage('assets/avatar.png'),
                          fit: BoxFit.cover,
                        )),
                        child: const Center(
                          child: Text(
                            'Please Upload an Image ! ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      )
                    : Image.file(File(_image!))
              ],
            ),
          ),
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
