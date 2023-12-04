import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/Global_Variables.dart';
class PlaySong extends StatefulWidget {
  const PlaySong({super.key});

  @override
  State<PlaySong> createState() => _PlaySongState();
}

class _PlaySongState extends State<PlaySong> {
  final List<String> lyrics = [
    "Bhali bhali ra bhali",
    "Sahore Baahubali",
    "Bhali bhali ra bhali",
    "Saahore Baahubali",
    "Jaya haarathi neeke",
    "Pattaali… Pattaali",
    "Bhuvanaalanni jai kottali",
    "Gaganaale chathram pattaali…",
    "",
    "Heyssaa rudrassa",
    "Hesarabhadra samudrassa",
    "Heyssaa rudrassa",
    "Hesarabhadra samudrassa (2 times)",
    "",
    "Aaa janani dheekshaa achalam",
    "Eee koduke kavacham",
    "Ippuda ammaki",
    "Ammavai nandukaa",
    "Pulakarin chindigaa",
    "Ee kshanam",
    "",
    "Adavulu guttal",
    "Mittal gaminchu",
    "Pidikita pidugul",
    "Patti minchu",
    "Arikula vargaal",
    "Durgaal jayinchu",
    "Avaniki swargaale dinchu",
    "",
    "Antha mahaa baludainaa",
    "Amma vodi pasivaade",
    "Shivudayinaa bhavudayina",
    "Ammaku saati kaadantaade",
    "",
    "Heyssaa rudrassa",
    "Hesarabhadra samudrassa",
    "Heyssaa rudrassa",
    "Hesarabhadra samudrassa",
    "(2 times)",
    "",
    "Heyssaa rudrassa",
    "(heyssaa rudrassa)",
    "Hesarabhadra samudrassa",
    "(hesarabhadra samudrassa)",
    "",
    "Heyssaa rudrassa",
    "Hesarabhadra samudrassa",
    "(5 times)",
    "",
    "Bhali bhali raa bhali",
    "Sahore Bahubali",
    "Jaya haarathi neeke",
    "Pattaali…",
    "",
    "Bhali bhali raa bhali",
    "Sahore Bahubali",
    "Jaya haarathi neeke",
    "Pattaali pattaali",
    "Bhuvanaalanni jai kottali",
    "Gaganaale chathram pattaali…",
  ];

  bool isLyricsOpened=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.backgroundColor,
      appBar:AppBar(
        backgroundColor: GlobalVariables.appBarColor,
        toolbarHeight: kToolbarHeight-10,
        elevation: 38,
        shadowColor: Colors.black12,
        leading: IconButton(onPressed: ()=>Navigator.pop(context), icon:const Icon(Icons.arrow_back,color: Colors.white70)),
        centerTitle: true,
        title:Text("Now Playing",style: GoogleFonts.manrope(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CircleAvatar(
              radius: 16,
              child: Image.network("https://qph.cf2.quoracdn.net/main-qimg-7a677dd3e89f2ac85ac5fd0d9993d77b-lq",fit: BoxFit.fill,)
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
                height: MediaQuery.sizeOf(context).height*0.36,
                margin: const EdgeInsets.only(top: 20,left: 20,right: 20),
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
                  margin:const EdgeInsets.only(top: 20,bottom: 15),
                  alignment: Alignment.center,
                  child: ListTile(
                      subtitle:Text("M M Keerevani",style: GoogleFonts.manrope(color: Colors.white24,fontWeight: FontWeight.w600,fontSize: 16),),
                    title:Text("Saahore Bahubali",style: GoogleFonts.openSans(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
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
              const SizedBox(height: 10,),
              Align(
                alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text("Lyrics",style: GoogleFonts.manrope(color: Colors.white24,fontWeight: FontWeight.w600,fontSize: 18)),
                      IconButton(onPressed: (){
                        setState(() {
                          isLyricsOpened=!isLyricsOpened;
                        });
                      }, icon:Icon(isLyricsOpened?CupertinoIcons.chevron_compact_down:CupertinoIcons.chevron_compact_up,color: Colors.white,size: 40,)),
                    ],
                  )),
              isLyricsOpened?AnimatedContainer(
                  duration: const Duration(seconds: 4), // Adjust the duration as needed
                  curve: Curves.easeInExpo,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 25,),
                padding: const EdgeInsets.only(top: 15),
                decoration:     const BoxDecoration(
                  color: GlobalVariables.appBarColor,
                    border:null,
                  borderRadius:BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)
                  )
                ),
                constraints: const BoxConstraints(
                  minHeight: 400,
                  maxHeight: 500
                ),
                child:ListView.builder(
                  itemCount: lyrics.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) => Center(child:index%2==0?ShaderMask(
                      shaderCallback: (bounds) {
                        return GlobalVariables.getLineGradient()
                            .createShader(bounds);
                      },
                      child: Text(
                        lyrics[index],
                        style: GoogleFonts.manrope(
                            color: Colors.white,
                            fontSize: 17.5,fontWeight: FontWeight.w500),
                      )):Text(lyrics[index],style: GoogleFonts.aBeeZee(color: Colors.white70,fontWeight: FontWeight.w600,fontSize: 16))),)
              ):const SizedBox()

            ]
      )
      ),
    )
    );
  }
}
