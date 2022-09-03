import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Favoritescreen extends StatelessWidget {
  const Favoritescreen({Key? key}) : super(key: key);

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
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              primary: true,
              shrinkWrap: true,
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: ListTile(
                    title: Text('song$index'),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
