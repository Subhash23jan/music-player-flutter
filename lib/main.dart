
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/constants/Global_Variables.dart';
import 'package:music_player_demo/home_page_widgets/picked_song_card.dart';
import 'package:music_player_demo/home_page_widgets/recently_listened.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        showUnselectedLabels: true,
        elevation: 18,
        selectedIconTheme:const  IconThemeData(color: Colors.black, size: 27),  
        unselectedIconTheme: IconThemeData(color: Colors.white70, size: 27),
        enableFeedback: true,
        unselectedFontSize: 13,
        selectedFontSize: 14.5,
        selectedLabelStyle: GoogleFonts.shortStack(color:Colors.black, fontWeight: FontWeight.bold),
        unselectedLabelStyle: GoogleFonts.shortStack(color: Colors.white70,fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.red,
        useLegacyColorScheme: false,
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: "SEARCH"),
         BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart), label: "FAVOURITES"),
          BottomNavigationBarItem(icon: Icon(Icons.auto_graph), label: "STATS"),
        ],
        backgroundColor: const Color.fromARGB(255, 80, 78, 78),
      ),
      backgroundColor: GlobalVariables.backgroundColor,
      appBar:AppBar(
        backgroundColor: GlobalVariables.appBarColor,
        toolbarHeight: kToolbarHeight+10,
        elevation: 18,
        shadowColor: Colors.white12,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width*0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 90,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: GlobalVariables.buttonGradient
                    ),
                    child:  Text("Home",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 13.5,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  ),
                  Container(
                    width: 90,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                       color: Colors.grey
                    ),
                    child:  Text("Music",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 13.5,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  ),
                  Container(
                    width: 90,
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.grey
                    ),
                    child:  Text("Podcasts",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 13.5,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  ),
                ],
              ),
            ),
             ClipRRect(
               borderRadius: BorderRadius.circular(25),
               child: CircleAvatar(
                radius: 21,
                child: Image.network("https://instagram.fblr24-3.fna.fbcdn.net/v/t51.2885-19/403837282_1030048844930280_3452019384313875445_n.jpg?stp=dst-jpg_s320x320&_nc_ht=instagram.fblr24-3.fna.fbcdn.net&_nc_cat=100&_nc_ohc=-zVVHKWy5z0AX-Us4Nv&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AfDFdv50gGROTtb2WBR4jXW8cN1GAEs88cpTG-Q6Sr48xA&oe=655D08BD&_nc_sid=8b3546"),
            ),
             )
          ],
        ),
        centerTitle: false,
      ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 18),
                  height:150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                            shaderCallback: (bounds) {
                              return GlobalVariables.getLineGradient()
                                  .createShader(bounds);
                            },
                            child: Text(
                              "  Picked for you",
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>pickedSong(context),),
                        )
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 18),
                    height:150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                            shaderCallback: (bounds) {
                              return GlobalVariables.getLineGradient()
                                  .createShader(bounds);
                            },
                            child: Text(
                              "  Recently listened",
                              style: GoogleFonts.aBeeZee(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 110,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>recentPlays(context),),
                        )
                      ],
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 18),
                    height:150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      ShaderMask(shaderCallback:(bounds) {
                        return GlobalVariables.getLineGradient().createShader(bounds);
                      },child: Text("  Collections",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold),)),
                        Row(
                          children: [
                            Container(
                              height: 110,
                              width: 160,
                              decoration: BoxDecoration(
                                 gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 170, 75, 40),
                                        Color.fromARGB(255, 18, 194, 221),
                                        Color.fromARGB(255, 142, 219, 145),
                                        Color.fromARGB(255, 47, 194, 181),
                                        Color.fromARGB(255, 15, 231, 231)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                            const SizedBox(width: 25,),
                            Container(
                              height: 110,
                              width: 160,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 97, 207, 222),
                                        Color.fromARGB(255, 213, 56, 208),
                                        Color.fromARGB(255, 228, 68, 161),
                                        Color.fromARGB(255, 220, 58, 58)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight),
                                  borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                          ],
                        )

                      ],
                    )),
              ],
            ),
          ),
        ),
      );
  }
}
