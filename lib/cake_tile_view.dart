import 'package:flutter/material.dart';

class CakeTile extends StatelessWidget {
  final String? name;
  final String? image;
  final String? price;
  final String? flavor;

  CakeTile(
      {required this.name,
      required this.image,
      required this.price,
      required this.flavor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      height: 200.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffc4292a), Color(0xff7d4d40)],
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16.0,
            left: 16.0,
            child: Text(
              name!,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
                color: Color(0xfffefefe),
              ),
            ),
          ),
          Positioned(
            top: 48.0,
            left: 16.0,
            child: Text(
              flavor!,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16.0,
                color: Color(0xfffefefe),
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: Text(
              '₹ $price',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xfffefefe),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 16.0,
          //   right: 16.0,
          //   child: RaisedButton(
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => OrderConfirmDrawer(),
          //         ),
          //       );
          //     },
          //     padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(16.0),
          //     ),
          //     color: Color(0xff93a5cf),
          //     child: Text(
          //       'Buy Now',
          //       style: TextStyle(
          //         fontFamily: 'Montserrat',
          //         fontSize: 16.0,
          //         fontWeight: FontWeight.bold,
          //         color: Color(0xffe4efe9),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            top: 5.0,
            right: 5.0,
            left: 150.0,
            bottom: 5.0,
            child: Image.network(
              image!,
              width: 100.0,
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
