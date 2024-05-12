import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shabbhai/HomePage.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
          backgroundColor: Colors.deepPurple,
        ),
        body: SafeArea(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(height: 50),
                    const Icon(
                      Icons.lock,
                      size: 150,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(height: 50),
                    TextFormField(
                        controller: emailcontroller,
                        decoration: const InputDecoration(hintText: 'Email')),
                    const SizedBox(height: 20),
                    TextFormField(
                        controller: passcontroller,
                        decoration:
                            const InputDecoration(hintText: 'Password')),
                    const SizedBox(height: 100),
                    InkWell(
                        onTap: () {
                          submitdata(context);
                        },
                        child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 1.5,
                            decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(25)),
                            child: const Center(
                                child: Text('Submit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)))))
                  ]),
                ))));
  }

  Future<void> submitdata(context) async {
    final response = await http.post(Uri.parse('https://reqres.in/api/login'),
        body: {"email": "eve.holt@reqres.in", "password": "cityslicka"});

    if (response.statusCode == 200) {
      Get.to(const shanBhai1(text: 'hello I am Shan'));
    } else {
      showmessageonerror("failed");
    }
  }

  void showmessage(String message) {
    final snakebar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.teal,
    );
    ScaffoldMessenger.of(context).showSnackBar(snakebar);
  }

  void showmessageonerror(String message) {
    final snakebar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snakebar);
  }
}
