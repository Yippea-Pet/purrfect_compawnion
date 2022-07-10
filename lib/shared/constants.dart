import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// const textBoxColor = Color(Colors.teal[50]);
const textInputDecoration = InputDecoration(
    fillColor: Color(0xFFE0F2F1),
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),

    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.pink, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    )

);

Color checkBoxMaterialState(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.blue;
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black),
  );
}

TextStyle get taskTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: taskTileFontColor
    ),
  );
}

TextStyle get taskTimeStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 13,
        color: taskTileFontColor
    ),
  );
}

TextStyle get taskNoteStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 15,
        color: taskTileFontColor
    ),
  );
}

const taskColor3 = Color(0xFFF197CC);
const taskColor2 = Color(0xFFFFACBC);
const taskColor1 = Color(0xFFFEC4B0);
const taskTileFontColor = Color(0xFF4E342E); // Colors.brown[800