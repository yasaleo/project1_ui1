import 'dart:ui';

import 'package:flutter/material.dart';

class AddFavCard extends StatelessWidget {
final  Widget widget;
final  String? playlistname;
final  double borderRadius;
final  double height;
final  double width;
final  Widget widget2;
const  AddFavCard(
      {Key? key,
       this.playlistname,
      required this.widget,
      required this.borderRadius,
       required this.height,
       required this.width,
       required this.widget2
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          height: height,

          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(26, 0, 0, 0),
                blurRadius: 8,
                spreadRadius: 5,
              )
            ],
            borderRadius: BorderRadius.circular(17),
          ),
          width: width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: widget,
              ),
              widget2
             
            ],
          ),
        ),
      ),
    );
  }
}
