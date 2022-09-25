import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project1_ui1/Database/favoritesdb.dart';
import 'package:project1_ui1/commonvariables.dart';
import 'package:project1_ui1/pages/home_page.dart';
import 'package:project1_ui1/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<SongModel> searchinglist = [];
  @override
  void initState() {
    searchinglist = Variableclass.fullsongmodellist;
    super.initState();
  }

  void runfilter(String keyword) {
    List<SongModel> result = [];
    if (keyword.isEmpty) {
      setState(() {
      result = Variableclass.fullsongmodellist;
        
      });
    } else {
      setState(() {
      result = searchinglist
          .where((element) => element.displayNameWOExt
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();   
      });
     
    }
    setState(() {
      searchinglist = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: const Color.fromARGB(255, 127, 127, 127),
                hintText: 'Type to search...',
                suffixIcon: const Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                ),
                prefixIcon: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
              ),
              onChanged: (value) {
                runfilter(value);
             
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: searchinglist.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchinglist.length,
                      itemBuilder: (context, index) {
                        return Customlisttile(
                          artistname: searchinglist[index].artist!,
                          widget: LikeButton(
                            animationDuration:
                                const Duration(milliseconds: 1450),
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
                            likeBuilder: (islikedd) {
                              return FavoritesDB.isfavorite(
                                      searchinglist[index])
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Color.fromARGB(255, 129, 9, 0),
                                      size: 32,
                                    )
                                  : const Icon(
                                      Icons.favorite_border_outlined,
                                      color: Color.fromARGB(225, 0, 0, 0),
                                      size: 32,
                                    );
                            },
                            onTap: (islikedd) async {
                              if (FavoritesDB.isfavorite(
                                  Variableclass.songlist[index])) {
                                FavoritesDB.removefromfav(
                                    Variableclass.songlist[index].id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13))),
                                        duration: Duration(milliseconds: 450),
                                        backgroundColor:
                                            Color.fromARGB(255, 99, 7, 0),
                                        content: Text(
                                          'Removed from Favorites',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  179, 255, 255, 255),
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700),
                                        )));
                              } else {
                                FavoritesDB.addtofav(
                                    Variableclass.songlist[index]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(13),
                                                topRight: Radius.circular(13))),
                                        duration: Duration(milliseconds: 450),
                                        backgroundColor:
                                            Color.fromARGB(255, 131, 131, 131),
                                        content: Text(
                                          'Added to Favorites',
                                          style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 86, 0, 0),
                                              fontSize: 19,
                                              fontWeight: FontWeight.w700),
                                        )));
                              }
                              FavoritesDB.favorites.notifyListeners();
                              Variableclass.instance.isclickedd
                                  .notifyListeners();

                              return !islikedd;
                            },
                          ),
                          id: searchinglist[index].id,
                          ontap: () {
                            Variableclass.audioPlayer.setAudioSource(
                                Variableclass.playsongs(
                                  searchinglist,
                                ),
                                initialIndex: index);
                            Variableclass.audioPlayer.play();
                            Variableclass.instance.isclickedd.value = true;
                            Variableclass.minivisible = true;

                            Variableclass.instance.isclickedd.notifyListeners();

                            Navigator.of(context).push(
                              PageTransition(
                                curve: Curves.easeOutCirc,
                                child: HomeScreen(
                                  songlist: searchinglist,
                                ),
                                type: PageTransitionType.size,
                                alignment: Alignment.bottomCenter,
                                duration: const Duration(milliseconds: 1050),
                                reverseDuration:
                                    const Duration(milliseconds: 534),
                              ),
                            );
                          },
                          songname: searchinglist[index].displayNameWOExt,
                        );
                      },
                    )
                  : LottieBuilder.asset('assets/WaYDLCo9Ux.json'))
        ],
      )),
    );
  }

  addingfav() {}
}
