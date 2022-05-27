import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:samss/consumer/model/user.dart';
import 'package:samss/consumer/screen/log_screen/sign_screen.dart';
import 'package:samss/consumer/screen/main_screen/Home_screen.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController contactController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  UserModel loginUser = UserModel();

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loginUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    contactController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // first name field
    Future updateFirstName() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Your First Name"),
              content: TextFormField(
                autofocus: true,
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
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  hintText: "Enter your first name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    final docUser = FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid);
                    docUser.update({'firstName': firstNameController.text});
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Setting()));
                  },
                  child: Text("Save"),
                )
              ],
            ));

    final firstName = Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(55, 63, 81, 181),
            Color.fromARGB(55, 68, 137, 255),
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${loginUser.firstName}",
            style: TextStyle(
              fontSize: 18,
              color: Colors.blueAccent,
            ),
          ),
          GestureDetector(
            onTap: () {
              updateFirstName();
            },
            child: Icon(
              Icons.edit,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
    );

    // last name field
    Future updateLastName() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Your Last Name"),
              content: TextFormField(
                autofocus: true,
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
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  hintText: "Enter your Last name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    final docUser = FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid);
                    docUser.update({'secondName': lastNameController.text});
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Setting()));
                  },
                  child: Text("Save"),
                )
              ],
            ));

    final lasttName = Container(
      height: 50,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(55, 63, 81, 181),
              Color.fromARGB(55, 68, 137, 255),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${loginUser.lastName}",
            style: TextStyle(
              fontSize: 18,
              color: Colors.blueAccent,
            ),
          ),
          GestureDetector(
            onTap: () {
              updateLastName();
            },
            child: Icon(
              Icons.edit,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
    );

// contact filed
    Future updateContact() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Your Contact Number"),
              content: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.phone,
                controller: contactController,
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{11,}$');
                  if (value!.isEmpty) {
                    return ("Please Enter your Contact.");
                  } else if (!regex.hasMatch(value)) {
                    return ("Please Enter name of 11 character or more");
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  lastNameController.text = value!;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  hintText: "Enter your contact number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    final docUser = FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid);
                    docUser.update({'contact': contactController.text});
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Setting()));
                  },
                  child: Text("Save"),
                )
              ],
            ));

    final contact = Container(
      height: 50,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(55, 63, 81, 181),
              Color.fromARGB(55, 68, 137, 255),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${loginUser.contact}",
            style: TextStyle(
              fontSize: 18,
              color: Colors.blueAccent,
            ),
          ),
          GestureDetector(
            onTap: () {
              updateContact();
            },
            child: Icon(
              Icons.edit,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
    );

// password field
    Future updatePassword() async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Your Password"),
              content: TextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
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
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  hintText: "Enter your password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    final docUser = FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid);
                    docUser.update({'password': passwordController.text});
                    final passwordUpdate = await FirebaseAuth
                        .instance.currentUser
                        ?.updatePassword(passwordController.text);
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text("Save"),
                )
              ],
            ));

    final passwordField = Container(
      height: 50,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(55, 63, 81, 181),
              Color.fromARGB(55, 68, 137, 255),
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${loginUser.password}",
            style: TextStyle(
              fontSize: 18,
              color: Colors.blueAccent,
            ),
          ),
          GestureDetector(
            onTap: () {
              updatePassword();
            },
            child: Icon(
              Icons.edit,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
    );

//display
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            label: Text(
              "Save",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        title: Text("Setting"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
              child: const Text(
                "Profile",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 60),
              padding: EdgeInsets.only(top: 10),
              height: 40,
              child: Text(
                "First Name",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                ),
              ),
              width: MediaQuery.of(context).size.width,
            ),
            firstName,
            Container(
              margin: EdgeInsets.only(left: 60, top: 10),
              padding: EdgeInsets.only(top: 10),
              height: 40,
              child: Text(
                "Last Name",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                ),
              ),
              width: MediaQuery.of(context).size.width,
            ),
            lasttName,
            Container(
              margin: EdgeInsets.only(left: 60, top: 10),
              padding: EdgeInsets.only(top: 10),
              height: 40,
              child: Text(
                "Contact",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                ),
              ),
              width: MediaQuery.of(context).size.width,
            ),
            contact,
            Container(
              margin: EdgeInsets.only(left: 60, top: 10),
              padding: EdgeInsets.only(top: 10),
              height: 40,
              child: Text(
                "Password",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueAccent,
                ),
              ),
              width: MediaQuery.of(context).size.width,
            ),
            passwordField,
          ],
        ),
      ),
    );
  }
}
