import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/Global_Variables.dart';

Widget favouriteSong(int index){
  return Container(
    margin: const EdgeInsets.only(bottom: 15),
    child: ListTile(
        titleAlignment: ListTileTitleAlignment.center,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1)
        ),
        leading: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                  color: Colors.white,
                  width: 1.9
              )
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(GlobalVariables.imageUrl,width: 40,height: 40,fit: BoxFit.fill,)),
        ),
        title:Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text("Song Name",style:GoogleFonts.manrope(color: Colors.white70,fontSize: 15.5,fontWeight: FontWeight.w600),),
        ),
        subtitle:Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text("Movie name",style: GoogleFonts.manrope(color: Colors.white38,fontSize: 12.5),),
        ),
        trailing:  IconButton(
            onPressed: (){},
            style: ButtonStyle(),
            icon: const Icon(Icons.favorite_outlined,color:Colors.redAccent,size: 27,))
    ),
  );
}