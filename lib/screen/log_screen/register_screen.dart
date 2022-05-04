import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:samss/model/user.dart';
import 'package:samss/screen/log_screen/sign_screen.dart';
import 'package:samss/screen/log_screen/verifying_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registeration extends StatefulWidget {
  Registeration({Key? key}) : super(key: key);

  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  late final String uid;

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final TextEditingController conformPasswordController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _screenHieght = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;

    final firstNameField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.name,
      controller: firstNameController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please Enter your First Name");
        } else if (!regex.hasMatch(value)) {
          return ("Please Enter name of 3 character or more");
        } else {
          return null;
        }
      },
      onSaved: (value) {
        firstNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintText: "First Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

    final lastNameField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.name,
      controller: lastNameController,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Please Enter your Last Name");
        } else if (!regex.hasMatch(value)) {
          return ("Please Enter name of 3 character or more");
        } else {
          return null;
        }
      },
      onSaved: (value) {
        lastNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintText: "Last Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

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
        prefixIcon: Icon(Icons.mail),
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
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
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

    final conformPasswordField = TextFormField(
      autofocus: false,
      controller: conformPasswordController,
      validator: (value) {
        if (conformPasswordController.text != passwordController.text) {
          return "Password do not match";
        }
        return null;
      },
      obscureText: true,
      onSaved: (value) {
        conformPasswordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.vpn_key),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintText: "Conform Password",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

    final registerButton = Material(
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
            registerWithEmailAndPassword(
                emailController.text, passwordController.text);
          }
        },
        child: const Text(
          "Create",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );

//register with gmail
    final gButton = Material(
      child: SizedBox.fromSize(
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.mail,
                  color: Colors.grey,
                ), // <-- Icon
                Text("Google"), // <-- Text
              ],
            ),
          ),
        ),
      ),
    );

    //register with facebook
    final fButton = Material(
      child: SizedBox.fromSize(
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  Icons.facebook,
                  color: Colors.grey,
                ), // <-- Icon
                Text("Facebook"), // <-- Text
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        color: Colors.blue.shade500,
        width: _screenWidth,
        height: _screenHieght,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Image.asset(
                      "assets/image/logo3.png",
                      height: 250,
                      width: 250,
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: double.infinity,
                    height: _screenHieght - 275,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            "Create Account",
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.blue.shade400,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 300,
                          height: 60,
                          child: firstNameField,
                        ),
                        Container(
                          width: 300,
                          height: 60,
                          child: lastNameField,
                        ),
                        Container(
                          width: 300,
                          height: 60,
                          child: emailField,
                        ),
                        Container(
                          width: 300,
                          height: 60,
                          child: passwordField,
                        ),
                        Container(
                          width: 300,
                          height: 60,
                          child: conformPasswordField,
                        ),
                        Container(
                          width: 250,
                          height: 40,
                          child: registerButton,
                        ),
                        const SizedBox(
                          height: 7,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            gButton,
                            const SizedBox(width: 40),
                            fButton,
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 62, 73, 78),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        )
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

  void registerWithEmailAndPassword(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailToFirebase()});
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future postDetailToFirebase() async {
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameController.text;
    userModel.lastName = lastNameController.text;
    userModel.password = passwordController.text;
    userModel.status = 0;

    try {
      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('users');
      await userCollection
          .doc(user.uid)
          .set(userModel.toMap())
          .then((value) async {
        final prefs = await SharedPreferences.getInstance();
        Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(builder: (context) => VerifyScreen()),
            (route) => false);
        await prefs.setString('email', user.uid);
      });
      Fluttertoast.showToast(msg: "Account created sucessfully");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}
