import 'package:flutter/material.dart';


class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.red[100],
        body:
        SingleChildScrollView(
          child:
          Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 0, top: 0),
                      child:
                      Container(
                          width: 415,
                          height: 72,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 27, top: 14),
                                    child:
                                    Container(
                                        width: 79,
                                        height: 46,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                  padding: const EdgeInsets.only(top: 0, left: 0),
                                                  child:
                                                  Container(
                                                      width: 79,
                                                      height: 46,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(24),
                                                      ),
                                                      child: Stack(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.topLeft,
                                                            child:   const Padding(
                                                              padding: const EdgeInsets.only(left: 0, top: 1),
                                                            ),

                                                          ),
                                                        ],
                                                      ))),

                                            ),
                                          ],
                                        ))),

                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child:   Padding(
                                  padding: const EdgeInsets.only(left: 286, top: 19),

                                ),

                              ),
                            ],
                          ))),

                ),
                Align(
                  alignment: Alignment.topLeft,
                  child:   const Padding(
                      padding: const EdgeInsets.only(left: 23, top: 28),
                      child:
                      Text(
                        "It’s time to meet your new",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      )),

                ),
                Align(
                  alignment: Alignment.topLeft,
                  child:   const Padding(
                      padding: const EdgeInsets.only(left: 23, top: 10),
                      child:
                      Text(
                        "Bestfriend",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 70,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'StyleScript',
                        ),
                      )),

                ),
                Align(
                  alignment: Alignment.topLeft,
                  child:   Padding(
                    padding: const EdgeInsets.only(left: 23, top: 98),
                    child: Container(
                      width: 180,
                      height: 58,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/Frame_ImageView_16-180x58.png")
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/');
                        }, child: Text(""),
                      ),
                    ),
                  ),

                ),
                Align(
                  alignment: Alignment.topLeft,
                  child:   Padding(
                    padding: const EdgeInsets.only(left: 7, top: 76),
                    child: SizedBox(
                      height: 337,
                      width: 433,
                      child: Image.asset("assets/LoginSoccatCropped_ImageView_17-433x337.png"),
                    ),
                  ),

                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 7, top: 16),
                      child:
                      Container(
                          width: width,
                          height: 59,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child:     Container(),

                              ),
                            ],
                          ))),

                ),
              ]),
        ));
  }
}