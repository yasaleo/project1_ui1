import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'front_screen.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(7, 7),
          )
        ],
        borderRadius: BorderRadius.circular(17),
        color: Colors.grey[400],
      ),
      height: 200,
      width: 200,
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
          const Padding(
            padding: EdgeInsets.only(top: 20,right: 60,left: 20),
            child: Text('Playlist 1 2 3 4 5 6 7',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 25
            ),
            ),
          )
        ],
      ),
    );
  }
}
