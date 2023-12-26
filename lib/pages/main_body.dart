import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_demo/MainPages/favourites_page.dart';
import 'package:music_player_demo/MainPages/home_page.dart';
import 'package:music_player_demo/MainPages/search_page.dart';
import 'package:music_player_demo/MainPages/statistics_page.dart';
class MainBodyPage extends StatefulWidget {
  const MainBodyPage({super.key,this.index=0});
  final int index;


  @override
  State<MainBodyPage> createState() => _MainBodyPageState();
}

class _MainBodyPageState extends State<MainBodyPage> {
  int index=0;
  late PageController _pagecontroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index=widget.index;
  }
  @override
  Widget build(BuildContext context) {
    _pagecontroller=PageController(initialPage:index,keepPage: true);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index=value;
            _pagecontroller.jumpToPage(value);
          });
        },
        showUnselectedLabels: true,
        elevation: 18,
        unselectedFontSize: 13,
        selectedFontSize: 14.5,
        unselectedIconTheme: const IconThemeData(color: Colors.white70),
        selectedLabelStyle: GoogleFonts.shortStack(color:Colors.cyan.shade900, fontWeight: FontWeight.bold),
        unselectedLabelStyle: GoogleFonts.shortStack(color: Colors.white70,fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.red,
        useLegacyColorScheme: false,
        items:  [
          getBottomItem(const Icon(CupertinoIcons.home),"HOME" ),
          getBottomItem(const Icon(CupertinoIcons.search),"SEARCH" ),
          getBottomItem(const Icon(CupertinoIcons.heart),"FAVOURITES" ),
          getBottomItem(const Icon(Icons.stacked_line_chart),"STATS" ),
        ],
        backgroundColor:Colors.grey.shade900,
      ),
      body: PageView(
        controller: _pagecontroller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          SearchPage(),
          FavouritesPage(),
          StatisticsPage()
        ],
      ),
    );
  }
  BottomNavigationBarItem getBottomItem(Icon icon,String text){
    return BottomNavigationBarItem(icon:
    ShaderMask(shaderCallback:(bounds) {
      return const LinearGradient(colors: [
        Colors.cyan,
        Colors.cyanAccent,
        Colors.cyan,
        Colors.cyanAccent,
      ], begin: Alignment.topLeft, end: Alignment.bottomRight).createShader(bounds);
    },child:icon) , label:text);
  }
}
