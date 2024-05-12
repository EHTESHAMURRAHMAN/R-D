import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shabbhai/balancePage.dart';
import 'package:shabbhai/scan.dart';

class shanBhai1 extends StatefulWidget {
  final String text;
  const shanBhai1({super.key, required this.text});

  @override
  State<shanBhai1> createState() => _shanBhai1State();
}

class _shanBhai1State extends State<shanBhai1> {
  TextEditingController scanedvalue = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurple,
          toolbarHeight: 100,
          flexibleSpace: Center(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 40, color: Colors.white),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.text,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Shaheen Bagh',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                        onTap: () {
                          callOnScan1();
                        },
                        child: const Icon(CupertinoIcons.qrcode,
                            size: 30, color: Colors.white)),
                    const SizedBox(width: 10),
                    const Icon(Icons.notification_add,
                        size: 30, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(20)),
              ),
              Text(scanedvalue.text)
            ],
          ),
        ));
  }

  callOnScan1() async {
    Get.to(const ScanQR())?.then((value) {
      setState(() {
        scanedvalue.text = value;
      });
      print('Scaned value ${value}');
    });
  }
}
