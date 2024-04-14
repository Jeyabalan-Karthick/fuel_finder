import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:fuelfinder/home.dart";
import "package:fuelfinder/main.dart";
import "package:fuelfinder/notifymessage.dart";
import 'package:shared_preferences/shared_preferences.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height * 2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional(0, 1),
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, -1.5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/getstart.jpg",
                        fit: BoxFit.cover,
                        height: 499,
                      ),
                    ),
                  ),
                  Text(
                    "Find Fuel Station Nearby 📍",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Your Name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),
              ),
              Padding(
                padding:
                    EdgeInsetsDirectional.only(bottom: 20, start: 20, end: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null && value!.length < 3 && value.isEmpty) {
                      NotifyUserMessage()
                          .errMessage(context, "Enter Valid Name");
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  controller: _name,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    suffix: GestureDetector(
                      onTap: () async {
                        if (_name.text.isNotEmpty) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          prefs.setString("name", _name.text);
                          print(prefs.getString("name"));

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const GetStart2()));
                        } else {
                          NotifyUserMessage()
                              .errMessage(context, "Enter Valid Name");
                        }
                      },
                      child: Icon(
                        Icons.arrow_circle_right_rounded,
                        size: 40,
                      ),
                    ),
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    hintText: 'Name',
                    hintStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetStart2 extends StatelessWidget {
  const GetStart2({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _number = TextEditingController();
    return Scaffold(
      body: Container(
        height: MediaQuery.sizeOf(context).height * 2,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional(0, 1),
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, -1.5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/getstart2.jpg",
                        fit: BoxFit.cover,
                        height: 499,
                      ),
                    ),
                  ),
                  Text(
                    "Accurate Location Tracking",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Your Number",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    )),
              ),
              Padding(
                padding:
                    EdgeInsetsDirectional.only(bottom: 20, start: 20, end: 20),
                child: TextFormField(
                  controller: _number,
                  autofocus: true,
                  obscureText: false,
                  decoration: InputDecoration(
                    suffix: GestureDetector(
                      onTap: () {
                        if (_number.text.isNotEmpty &&
                            _number.text.length == 10) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          prefs.setString("number", _number.text);
                          print(prefs.getString("number"));
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Home()),
                              (Route route) => false);
                        } else {
                          NotifyUserMessage()
                              .errMessage(context, "Enter Valid Number");
                        }
                      },
                      child: Icon(
                        Icons.arrow_circle_right_rounded,
                        size: 40,
                      ),
                    ),
                    labelStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    hintText: 'Number',
                    hintStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
