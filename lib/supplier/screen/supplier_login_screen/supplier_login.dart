import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samss/supplier/screen/supplier_home_screen/supplier_home.dart';
import 'package:samss/supplier/screen/supplier_login_screen/supplier_register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../consumer/screen/log_screen/sign_screen.dart';

class SupplierLogin extends StatefulWidget {
  const SupplierLogin({Key? key}) : super(key: key);

  @override
  State<SupplierLogin> createState() => _LoginState();
}

class _LoginState extends State<SupplierLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    final _screenHieght = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;

//email field
    final emailField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter your Email");
        } else if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return ("Please Enter valid email");
        } else {
          return null;
        }
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
          color: Colors.blue,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

//password field
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please Enter your password");
        } else if (!regex.hasMatch(value)) {
          return ("Please Enter password of 6 character");
        } else {
          return null;
        }
      },
      obscureText: true,
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.vpn_key,
          color: Colors.blue,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintText: "Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

// SupplierLogin Button
    final loginButton = Material(
      elevation: 10,
      // color: Colors.blue,
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.blue),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 4,
        ),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            signInWithEmailAndPassword(
                emailController.text, passwordController.text);
          }
        },
        child: const Text(
          "SupplierLogin",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );

    //registeration Button
    final registeration = Material(
      elevation: 10,
      // color: Colors.blue,
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.blue),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SupplierRegisteration()));
        },
        child: const Text(
          "Create Account",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );

//login with gamil
    // final gButton = Material(
    //   child: SizedBox.fromSize(
    //     child: Material(
    //       color: Colors.white,
    //       child: InkWell(
    //         onTap: () {},
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: const <Widget>[
    //             Icon(
    //               Icons.mail,
    //               color: Colors.grey,
    //             ), // <-- Icon
    //             Text("Google"), // <-- Text
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    // //login with facebook
    // final fButton = Material(
    //   child: SizedBox.fromSize(
    //     child: Material(
    //       color: Colors.white,
    //       child: InkWell(
    //         onTap: () {},
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: const <Widget>[
    //             Icon(
    //               Icons.facebook,
    //               color: Colors.grey,
    //             ), // <-- Icon
    //             Text("Facebook"), // <-- Text
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );

//forget password
    final resetPassword = Material(
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => ResetScreen()));
        },
        child: const Text(
          "Forget Password",
          style: TextStyle(
              color: Color.fromARGB(255, 62, 73, 78),
              fontWeight: FontWeight.w700),
        ),
      ),
    );

    // Toggle button
    final toggle = Container(
      margin: const EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(2),
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueGrey,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (() {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.home,
                  color: Colors.grey,
                ), // <-- Icon
                Text(
                  "Consumer",
                ), // <-- Text
              ],
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            "|",
            style: TextStyle(
              color: Colors.blueGrey,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(
                Icons.directions_bus,
                color: Colors.blue,
              ), // <-- Icon
              Text("Supplier",
                  style: TextStyle(
                    color: Colors.blue,
                  )), // <-- Text
            ],
          ),
        ],
      ),
    );

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
                        toggle,
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          child: emailField,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          child: passwordField,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          child: resetPassword,
                          alignment: FractionalOffset(0.1, 0),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 150,
                          height: 40,
                          child: loginButton,
                        ),
                        const SizedBox(
                          height: 20,
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
                        // const Text("SignIn with",
                        //     style: TextStyle(
                        //         fontSize: 18,
                        //         color: Colors.blueGrey,
                        //         fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     gButton,
                        //     const SizedBox(width: 20),
                        //     const Text(
                        //       "OR",
                        //       style: TextStyle(
                        //         color: Colors.blueGrey,
                        //       ),
                        //     ),
                        //     const SizedBox(width: 20),
                        //     fButton,
                        //   ],
                        // ),
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
                          child: registeration,
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

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SupplierHome()));
      await prefs.setString('email', userCredential.user!.uid);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);
    }
  }
}
