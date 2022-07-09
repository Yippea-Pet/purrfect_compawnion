import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Weather extends StatelessWidget {
  const Weather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('weather',
        style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.red[200],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(

            //BACKGROUND!!!!!!!!!!!!

            //image: AssetImage("assets/rainbg.jpg"),
            image: AssetImage("assets/sunnybg.jpg"),
          fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Text("Singapore",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 40,
                        color: Colors.white),
                  ),
                ),
                  Text("Chinese Garden, Singapore",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                Text(" 31°",
                  style: GoogleFonts.heebo(
                    textStyle: TextStyle(
                        fontSize: 90,
                        fontWeight: FontWeight.w200,
                        color: Colors.white),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                  Text("clear",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.black54),
                    ),
                  ),
                  SizedBox(width: 40,),
                  Text("clear sky",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.black54),
                    ),
                  ),
                ]
                ),
                  // Text("Rainy",
                  //   style: GoogleFonts.lato(
                  //     textStyle: TextStyle(
                  //         fontSize: 20,
                  //         fontWeight: FontWeight.w300,
                  //         color: Colors.white),
                  //   ),
                  // ),
                  SizedBox(height: 10,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("H: 34°",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                        ),
                        SizedBox(width: 50,),
                        Text("L: 29°",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                        ),
                      ]
                  ),

               ],
              ),
              Expanded(
                  flex: 5,

                  //SOCCAT ANIMATION !!!!!!!!!!!

                  //child: Image.asset('assets/rainanimation.GIF')
                  child: Image.asset('assets/sunanimation2.GIF')
              ),
              Expanded(
                flex: 1,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("sunrise time: 05 00",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black54),
                        ),
                      ),
                    ]
                )
              )

              // Expanded(
              //     flex: 1,
              //     child: Container())
            ]
          )
        ),
      ),
    );
  }
}
