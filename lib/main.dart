


import 'package:flutter/material.dart';
import 'package:music_player_demo/pages/permissionHandlerPage.dart';
import 'package:music_player_demo/provider/songs_provider.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(ChangeNotifierProvider(
    create: (context) => SongsProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PermissionHandler(),
    );
  }
}

