import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Sqlfite/database_helper.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoaded=false;
  @override
  Widget build(BuildContext context) {
    return isLoaded?Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search for song',
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            // Implement your search logic here
            // For simplicity, just print the entered search query
            print('Search query: $value');
          },
        ),
      ),
      body: const Center(
        child: Text('Search Screen Content'),
      ),
    ): FutureBuilder<List<SongModel>>(
      future: OnAudioQuery().querySongs(
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ),
      builder: (context, item) {
        // Display error, if any.
        if (item.hasError) {
          return Text(item.error.toString());
        }

        // Waiting content.
        if (item.data == null) {
          return const Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,));
        }

        // 'Library' is empty.
        if (item.data!.isEmpty) return const Text("Nothing found!");

        // You can use [item.data!] direct or you can create a:
        // List<SongModel> songs = item.data!;
        return ListView.builder(
          itemCount: item.data!.length,
          shrinkWrap: true,
          physics:const ScrollPhysics(),
          itemBuilder: (context, index) {
            DataBaseHelper db=DataBaseHelper();
            db.addSongToDatabase(item.data![index]);
            return null;
          },
        );
      },
    );;
  }
}
