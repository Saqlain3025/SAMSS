import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:samss/model/user.dart';
import 'package:samss/screen/log_screen/sign_screen.dart';
import 'package:samss/services/auth.dart';

class SlideBar extends StatefulWidget {
  SlideBar({Key? key}) : super(key: key);

  @override
  State<SlideBar> createState() => _SlideBarState();
}

class _SlideBarState extends State<SlideBar> {
  final AuthServices _auth = AuthServices();
  User? user = FirebaseAuth.instance.currentUser;

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
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;

// signOut button
    final signOutButton = Material(
      elevation: 20,
      color: Colors.transparent,
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.white),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        minWidth: _screenWidth - 50,
        onPressed: () async {
          await _auth.signOut();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Login()));
        },
        child: const Text(
          "SignOut",
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
    );

    return Container(
      width: _screenWidth - 50,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.indigo,
            Colors.blueAccent,
          ],
        ),
      ),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "${loginUser.firstName}  ${loginUser.lastName}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            accountEmail: Text("${loginUser.email}"),
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo,
                    Colors.blueAccent,
                  ],
                ),
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                  ),
                )),
          ),
          const ListTile(
            leading: Icon(
              Icons.settings,
              size: 40,
              color: Colors.white,
            ),
            title: Text(
              "Settings",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(
              Icons.history,
              size: 40,
              color: Colors.white,
            ),
            title: Text(
              "Order History",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(
              Icons.support_agent,
              size: 40,
              color: Colors.white,
            ),
            title: Text(
              "Support",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            onTap: null,
          ),
          const SizedBox(
            height: 100,
          ),
          const Divider(
            color: Colors.white,
            indent: 20.0,
            endIndent: 10.0,
            thickness: 1,
          ),
          signOutButton,
        ],
      ),
    );
  }
}
