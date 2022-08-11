import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:like_button/like_button.dart';

class ListCard extends StatelessWidget {
  const ListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(35, 11, 11, 11),
                blurRadius: 13,
                spreadRadius: 1,
                offset: Offset(0, 0),
              ),
            ],
            borderRadius: BorderRadius.circular(17),
          ),
          child: Slidable(
            useTextDirection: true,
            endActionPane: ActionPane(
                extentRatio: 1 / 2.5,
                motion: const StretchMotion(),
                children: [
                  SlidableAction(
                    onPressed: ((context) {}),
                    icon: Icons.delete_forever_outlined,
                    backgroundColor: const Color.fromARGB(145, 159, 135, 135),
                    foregroundColor: const Color.fromARGB(255, 115, 8, 0),
                  ),
                  SlidableAction(
                    onPressed: ((context) {}),
                    icon: Icons.playlist_add,
                    backgroundColor: const Color.fromARGB(145, 158, 158, 158),
                    foregroundColor: const Color.fromARGB(255, 7, 7, 7),
                  ),
                ]),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1.5 / 1,
                  child: Image.asset(
                    'assets/kobu-agency-3hWg9QKl5k8-unsplash.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: const Text(
                'Song 12 233578909',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
              ),
              subtitle: const Text(
                'Artist 1',
                style: TextStyle(fontSize: 20),
              ),
              trailing: SizedBox(
                height: 40,
                width: 40,
                child: LikeButton(
                  animationDuration: const Duration(milliseconds: 1450),
                  bubblesSize: 70,
                  circleSize: 50,
                  circleColor: const CircleColor(
                    start: Color.fromARGB(52, 10, 10, 10),
                    end: Color.fromARGB(255, 255, 0, 0),
                  ),
                  bubblesColor: const BubblesColor(
                    dotPrimaryColor: Color.fromARGB(255, 255, 22, 1),
                    dotSecondaryColor: Color.fromARGB(255, 125, 0, 0),
                    dotThirdColor: Color.fromARGB(255, 255, 95, 92),
                    dotLastColor: Color.fromARGB(255, 80, 5, 0),
                  ),
                  likeBuilder: (isLiked) {
                    return Icon(
                      Icons.favorite,
                      color: isLiked
                          ? const Color.fromARGB(255, 129, 9, 0)
                          : Colors.black,
                      size: 33,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
