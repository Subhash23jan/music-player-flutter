import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/Global_Variables.dart';

Widget recentPlays(BuildContext context){
   const String imageUrl="https://images.firstpost.com/wp-content/uploads/2017/04/prabhas-baahubali.jpg";
  return Container(
    margin: const EdgeInsets.only(right: 18),
    height: 150,
    width: MediaQuery.sizeOf(context).width*0.8,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(12),
    ),
    child:  Row(
      children: [
        ClipRRect(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12),topLeft: Radius.circular(12)),
            child: Image.network(imageUrl,fit:BoxFit.fill,width: MediaQuery.sizeOf(context).width*0.4,height:150,opacity:const AlwaysStoppedAnimation(0.45),)),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text("Song name",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 18),),
            ),
            Expanded(
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12),topRight: Radius.circular(12)),
                  child: Image.network(imageUrl,fit:BoxFit.cover,width: MediaQuery.sizeOf(context).width*0.4,height:150,opacity:const AlwaysStoppedAnimation(0.3),)),
            ),
          ],
        ),
      ],
    ),
  );
}