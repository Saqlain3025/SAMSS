import 'package:flutter/material.dart';

class SupplierRegisteration extends StatefulWidget {
  const SupplierRegisteration({Key? key}) : super(key: key);

  @override
  State<SupplierRegisteration> createState() => _SupplierRegisterationState();
}

class _SupplierRegisterationState extends State<SupplierRegisteration> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _screenHieght = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo,
              Colors.blueAccent,
            ],
          ),
        ),
        width: _screenWidth,
        height: _screenHieght,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    padding: EdgeInsets.all(10),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                    "Supplier",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                  AnimatedContainer(
                    margin: const EdgeInsets.only(top: 40),
                    duration: const Duration(milliseconds: 500),
                    width: double.infinity,
                    height: 480,
                    transform: Matrix4.translationValues(0, 0, 0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        // toggle,
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          // child: emailField,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          // child: passwordField,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          // child: resetPassword,
                          alignment: FractionalOffset(0.1, 0),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          height: 40,
                          // child: loginButton,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Expanded(
                              child: Divider(
                                indent: 20.0,
                                endIndent: 10.0,
                                thickness: 1,
                              ),
                            ),
                            Text(
                              "OR",
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                            Expanded(
                              child: Divider(
                                indent: 10.0,
                                endIndent: 20.0,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(height: 10),
                        const Text("SignIn with",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // gButton,
                            const SizedBox(width: 20),
                            const Text(
                              "OR",
                              style: TextStyle(
                                color: Colors.blueGrey,
                              ),
                            ),
                            const SizedBox(width: 20),
                            // fButton,
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 250,
                          height: 40,
                          // child: registeration,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
