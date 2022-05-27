import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:samss/consumer/services/auth.dart';
import 'package:samss/supplier/supplier_screen/supplier_login_screen/supplier_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../supplier_model/supplier_user.dart';

class SupplierHome extends StatefulWidget {
  SupplierHome({Key? key}) : super(key: key);

  @override
  State<SupplierHome> createState() => _SupplierHomeState();
}

class _SupplierHomeState extends State<SupplierHome> {
  final AuthServices _auth = AuthServices();

  User? user = FirebaseAuth.instance.currentUser;

  SupplierUserModel loginUser = SupplierUserModel();

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('supplier')
        .doc(user!.uid)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          this.loginUser = SupplierUserModel.fromMap(value.data());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
              final prefs = await SharedPreferences.getInstance();
              final success = await prefs.remove('email');
              final success1 = await prefs.remove('account');
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => SupplierLogin()));
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Center(
          child: Container(
        child: Column(
          children: [
            Text(
              "${loginUser.firstName}  ${loginUser.lastName}",
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              "${loginUser.email}",
              style: const TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      )),
    );
  }
}
