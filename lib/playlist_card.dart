import 'dart:ui';

import 'package:flutter/material.dart';


class PlaylistCard extends StatelessWidget {
  String playlistname;
   PlaylistCard({Key? key, required this.playlistname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4,
          sigmaY: 4
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(26, 0, 0, 0),
                blurRadius: 8,
                spreadRadius: 5,
              )
            ],
            borderRadius: BorderRadius.circular(17),
            // color: Colors.grey[400],
          ),
          // height: 135,
          width: 155,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 2 / 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(17),
                    topRight: Radius.circular(17),
                  ),
                  child: Image.asset(
                    'assets/artistic-album-cover-design-template-d12ef0296af80b58363dc0deef077ecc_screen.jpg',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.only(top: 20,right: 30,left: 20),
                child: Text('$playlistname',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18
                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
