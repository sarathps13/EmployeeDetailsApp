import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ShowDetails extends StatelessWidget {
  const ShowDetails(
      {super.key,
      required this.name,
      required this.age,
      required this.gmail,
      required this.phone,
      required this.urimage});
  final String name;
  final String age;
  final String gmail;
  final String phone;
  final String urimage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAILS OF EMPLOYEE',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Container(
              decoration: const BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(3, 9)),
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name  :  $name",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Age  :     $age",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Email:  $gmail",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Mobile : $phone",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.file(
                    File(urimage),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
