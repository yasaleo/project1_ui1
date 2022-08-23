import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AddPlaylist extends StatelessWidget {
  const AddPlaylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return  Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        physics:  BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            actions: [
              TextButton.icon(onPressed: () {
                
              },
               icon: Icon(Icons.done_outline_rounded,color: Colors.black,), 
               label: Text('Create',style: TextStyle(color: Colors.black),))
            ],
            stretch: true,
            elevation: 2,
            backgroundColor: Colors.grey,
            expandedHeight: 280,
            collapsedHeight: 60,
            pinned: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Padding(
                padding: EdgeInsets.only(top: 13),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 34,
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
              title: Padding(
                padding: const EdgeInsets.only(left: 38),
                child: TextFormField(
                  style:  GoogleFonts.capriola(
                        textStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    fontWeight: FontWeight.w500
                    )),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: 'Playlist Name',
                    labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  ),
                )
                
                
                
                
                
                // Text('Favorites',
                //     style: GoogleFonts.capriola(
                //         textStyle: const TextStyle(
                //       fontSize: 35,
                //       color: Color.fromARGB(255, 85, 85, 85),
                //     fontWeight: FontWeight.w500
                //     ))),
              ),
              titlePadding: const EdgeInsets.only(left: 16),
              expandedTitleScale: 1.8,
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