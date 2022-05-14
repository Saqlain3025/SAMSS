import 'package:flutter/material.dart';
import 'package:samss/consumer/services/auth.dart';
import 'package:samss/supplier/supplier_screen/supplier_login_screen/supplier_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupplierHome extends StatefulWidget {
  SupplierHome({Key? key}) : super(key: key);

  @override
  State<SupplierHome> createState() => _SupplierHomeState();
}

class _SupplierHomeState extends State<SupplierHome> {
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
              final prefs = await SharedPreferences.getInstance();
              final success = await prefs.remove('email');
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
    );
  }
}
