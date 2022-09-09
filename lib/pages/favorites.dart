import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project1_ui1/Database/favoritesdb.dart';
import 'package:project1_ui1/commonvariables.dart';
import 'package:project1_ui1/listcard.dart';

class Favoritescreen extends StatefulWidget {
  const Favoritescreen({Key? key}) : super(key: key);

  @override
  State<Favoritescreen> createState() => _FavoritescreenState();

  void initState() {}
}

class _FavoritescreenState extends State<Favoritescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            stretch: true,
            elevation: 0,
            backgroundColor: Colors.grey,
            expandedHeight: 280,
            collapsedHeight: 60,
            pinned: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Padding(
                padding: const EdgeInsets.only(top: 18, right: 0),
                child: Transform.rotate(
                  angle: 4.70,
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 30,
                    shadows: [
                      Shadow(
                        color: Colors.black87,
                        blurRadius: 9,
                      )
                    ],
                  ),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              collapseMode: CollapseMode.pin,
              background: ShaderMask(
                blendMode: BlendMode.dstOut,
                shaderCallback: (rect) => const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black])
                    .createShader(rect),
                child: Image.asset(
                  'assets/imageee2.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text('Favorites',
                  style: GoogleFonts.capriola(
                      textStyle: const TextStyle(
                          fontSize: 35,
                          color: Color.fromARGB(255, 85, 85, 85),
                          fontWeight: FontWeight.w500))),
              titlePadding: const EdgeInsets.only(left: 115),
              expandedTitleScale: 1.6,
            ),
          ),
          SliverToBoxAdapter(
            child: ValueListenableBuilder(
                valueListenable: FavoritesDB.favorites,
                builder: (context, List<SongModel> value, Widget? _) {
                  return value.isEmpty
                      ? Center(child: Text('nope  '))
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          primary: true,
                          shrinkWrap: true,
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            final value1 = value[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(26, 0, 0, 0),
                                          blurRadius: 8,
                                          spreadRadius: 1,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      horizontalTitleGap: 8,
                                      onTap: () {},
                                      leading: CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            const Color.fromARGB(13, 0, 0, 0),
                                        foregroundColor: Colors.black54,
                                        child: QueryArtworkWidget(
                                          artworkFit: BoxFit.fill,
                                          id: value1.id,
                                          type: ArtworkType.AUDIO,
                                          nullArtworkWidget: const Icon(
                                              Icons.music_note_outlined),
                                        ),
                                      ),
                                      title: Text(
                                        value1.displayNameWOExt,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      subtitle: Text(
                                        value1.artist.toString() == "<unknown>"
                                            ? 'Unknown Artist'
                                            : value1.artist.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      trailing: SizedBox(
                                        height: 55,
                                        width: 35,
                                        child: IconButton(
                                          onPressed: () {
                                            FavoritesDB.removefromfav(
                                                value1.id);
                                            FavoritesDB.favorites
                                                .notifyListeners();
                                            Variableclass.instance.isclickedd
                                                .notifyListeners();
                                          },
                                          icon: Icon(
                                            Icons.favorite_rounded,
                                            color: const Color.fromARGB(
                                                255, 129, 9, 0),
                                                size: 32,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                }),
          )
        ],
      ),
    );
  }
}
