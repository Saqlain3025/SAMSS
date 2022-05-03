import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:samss/screen/main_screen/hoome.dart';
import 'package:samss/screen/main_screen/slidebar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  double _tankerQuantity = 0;
  double _price = 0;

  Widget build(BuildContext context) {
    final _screenHieght = MediaQuery.of(context).size.height;
    final _screenWidth = MediaQuery.of(context).size.width;

    final TextEditingController emailController = new TextEditingController();

//location fieldd
    final locationField = TextFormField(
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter your Location");
        } else if (!RegExp("^[a-zA-Z0-9+_.-]").hasMatch(value)) {
          return ("Please Enter valid Location");
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
          Icons.location_on_outlined,
          color: Colors.blue,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        hintText: "Location",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );

    final orderButton = Material(
      elevation: 10,
      color: Colors.blue,
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
        onPressed: () async {
          // if (_formKey.currentState!.validate()) {
          //   signInWithEmailAndPassword(
          //       emailController.text, passwordController.text);
          // }
        },
        child: const Text(
          "Order",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
      ),
    );

    return Scaffold(
      drawer: SlideBar(),
      body: Container(
        width: _screenWidth,
        height: _screenHieght,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo,
              Colors.blueAccent,
            ],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(child: Status()),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                transform: Matrix4.translationValues(0, 0, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text(
                          "Water Tanker",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.blue.shade400,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          "Number Of Tanker Order.",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blue.shade400,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        //margin: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                                child: Icon(
                                  Icons.arrow_left,
                                  size: 40,
                                  color: Colors.blue.shade400,
                                ),
                                onTap: () {
                                  setState(() {
                                    if (_tankerQuantity <= 0) {
                                      return;
                                    }
                                    _tankerQuantity = _tankerQuantity - 1;
                                    _price = 1200 * _tankerQuantity;
                                  });
                                }),
                            Text(
                              "$_tankerQuantity",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.blue.shade400,
                              ),
                            ),
                            GestureDetector(
                                child: Icon(
                                  Icons.arrow_right,
                                  size: 40,
                                  color: Colors.blue.shade400,
                                ),
                                onTap: () {
                                  setState(() {
                                    _tankerQuantity = _tankerQuantity + 1;
                                    _price = 1200 * _tankerQuantity;
                                  });
                                }),
                          ],
                        ),
                      ),
                      Container(
                        width: 300,
                        child: Text(
                          'Total Price: $_price',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        child: locationField,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 250,
                        height: 40,
                        child: orderButton,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
