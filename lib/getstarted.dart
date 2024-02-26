import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:fuelfinder/home.dart";

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                child: Image.asset(
                  "assets/images/getstart.jpg",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) => Home())),
            child: Container(
              height: 60,
              width: 100,
              margin: EdgeInsets.all(40),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.yellow),
              child: Center(
                  child: Text(
                "Get Started",
                style: TextStyle(fontWeight: FontWeight.w600),
              )),
            ),
          )
        ],
      ),
    );
  }
}
