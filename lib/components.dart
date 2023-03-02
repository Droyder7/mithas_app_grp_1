import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OpenSans extends StatelessWidget {
  final text;
  final size;
  final color;
  final fontWeight;
  const OpenSans(
      {Key? key,
      required this.text,
      required this.size,
      this.color,
      this.fontWeight})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: size,
        color: color ?? Colors.white,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }
}

DialogBox(BuildContext context, String erroMessage) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      contentPadding: EdgeInsets.all(32.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(width: 2.0, color: Colors.black),
      ),
      title: OpenSans(
        text: erroMessage,
        size: 20.0,
        color: Colors.black,
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: const Color(0xff7D4D40),
          child: OpenSans(
            text: "OKAY",
            size: 20.0,
          ),
        ),
      ],
    ),
  );
}
