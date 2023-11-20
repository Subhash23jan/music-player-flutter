import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/Global_Variables.dart';
class PlaySong extends StatefulWidget {
  const PlaySong({super.key});

  @override
  State<PlaySong> createState() => _PlaySongState();
}

class _PlaySongState extends State<PlaySong> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      appBar:AppBar(
        backgroundColor: GlobalVariables.appBarColor,
        toolbarHeight: kToolbarHeight-15,
        elevation: 38,
        shadowColor: Colors.black,
        centerTitle: true,
        title:Text("Now Playing",style: GoogleFonts.manrope(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CircleAvatar(
              radius: 16,
              child: Image.network("https://instagram.fblr24-3.fna.fbcdn.net/v/t51.2885-19/403837282_1030048844930280_3452019384313875445_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fblr24-3.fna.fbcdn.net&_nc_cat=100&_nc_ohc=-zVVHKWy5z0AX-Us4Nv&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfDFdv50gGROTtb2WBR4jXW8cN1GAEs88cpTG-Q6Sr48xA&oe=655D08BD&_nc_sid=8b3546"),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height*0.4,
                margin: const EdgeInsets.only(top: 22,left: 22,right: 22),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(onPressed: (){},
                    icon: ClipRRect(
                         borderRadius: BorderRadius.circular(20),
                      child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        GlobalVariables.imageUrl,  // Replace with your image URL or use AssetImage for local images
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration:  const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.white30],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  style:  ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(100),
                    shadowColor: MaterialStateProperty.all<Color>(Colors.white38),
                    // Set the button color
                  ),
                ),
              ),
              Container(
                  margin:const EdgeInsets.only(top: 20,bottom: 20),
                  alignment: Alignment.center,
                  child: ListTile(
                      subtitle:Text("Cindly Lauper",style: GoogleFonts.manrope(color: Colors.white24,fontWeight: FontWeight.w600,fontSize: 16),),
                    title:Text("Girls Just Want to Have Fun",style: GoogleFonts.openSans(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    trailing:const Icon(Icons.favorite_outlined,color: Colors.white,size: 26,)
                  ),
        ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed:(){}, icon:const Icon(CupertinoIcons.shuffle,color: CupertinoColors.systemIndigo,size: 30,)),
                  IconButton(onPressed:(){}, icon:const Icon(CupertinoIcons.backward_end,color: CupertinoColors.white,size: 30,)),
                  IconButton(onPressed:(){}, icon: const Icon(CupertinoIcons.play_circle,color: CupertinoColors.systemCyan,size: 75,
                    shadows: [
                    Shadow(
                      color: Colors.white,
                      blurRadius: 6,

                    ),
                    Shadow(
                      color: Colors.white,
                      blurRadius: 6,

                    ),
                    Shadow(
                      color: Colors.white,
                      blurRadius: 6,

                    ),
                  ],),
                    style:  ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(25), // Set the elevation as needed
                      shadowColor: MaterialStateProperty.all<Color>(Colors.cyan.shade200),
                       // Set the button color
                    ),
                  ),
                  IconButton(onPressed:(){}, icon:const Icon(CupertinoIcons.forward_end,color: CupertinoColors.white,size: 30,)),
                  IconButton(onPressed:(){}, icon:const Icon(CupertinoIcons.repeat,color: CupertinoColors.systemIndigo,size: 30,)),
                ],
              ),

            ]
      )
      ),
    )
    );
  }
}
