import 'package:flutter/material.dart';
import 'package:samss/consumer/screen/main_screen/Home_screen.dart';

class ConsumerReport extends StatefulWidget {
  ConsumerReport({Key? key}) : super(key: key);

  @override
  State<ConsumerReport> createState() => _ConsumerReportState();
}

class _ConsumerReportState extends State<ConsumerReport> {
  final TextEditingController commentController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
//save button
    final saveReportButton = Material(
      elevation: 20,
      color: Color.fromARGB(122, 68, 137, 255),
      borderRadius: const BorderRadius.all(
        Radius.circular(30),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(color: Colors.blueAccent),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        minWidth: MediaQuery.of(context).size.width - 50,
        onPressed: () {},
        child: const Text(
          "Send Report",
          style: TextStyle(
            fontSize: 22,
            color: Color.fromARGB(220, 239, 242, 248),
          ),
        ),
      ),
    );

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
        title: Text("Support"),
        centerTitle: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(183, 63, 81, 181),
                      Color.fromARGB(131, 68, 137, 255),
                    ],
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: TextFormField(
                  maxLines: 10,
                  minLines: 10,
                  expands: false,
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  controller: commentController,
                  onSaved: (value) {
                    commentController.text = value!;
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    hintText: "Enter your query.",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              saveReportButton,
            ],
          )),
    );
  }
}
