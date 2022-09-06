import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                              child: ListCard(
                                songModell: Variableclass.songlist[index],
                                  artist: value1.artist.toString() == "<unknown>"
                                      ? 'Unknown Artist'
                                      : value1.artist.toString(),
                                  
                                  
                                  title: value1.displayNameWOExt,
                                  ontap: () {},
                                  id: value1.id,
                                  addingfav: () {
                                    if (FavoritesDB.isfavorite(
                                        Variableclass.songlist[index])) {
                                      FavoritesDB.removefromfav(
                                          Variableclass.songlist[index].id);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              backgroundColor:
                                                  Color.fromARGB(255, 99, 7, 0),
                                              content: Text(
                                                'Removed from Favorites',
                                                style: TextStyle(
                                                    color: Colors.white38,
                                                    fontSize: 14),
                                              )));
                                    } else {
                                      FavoritesDB.addtofav(
                                          Variableclass.songlist[index]);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              backgroundColor:
                                                  Color.fromARGB(255, 46, 46, 46),
                                              content: Text(
                                                'Added to Favorites',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 171, 0, 0),
                                                    fontSize: 14),
                                              )));
                                    }
                                    FavoritesDB.favorites.notifyListeners();
                                  },
                                  islikedd: FavoritesDB.isfavorite(
                                      Variableclass.songlist[index])),
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
