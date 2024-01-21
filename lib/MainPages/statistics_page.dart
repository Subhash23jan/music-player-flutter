import 'package:flutter/material.dart';
class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Music Statistics"),
          toolbarHeight: kToolbarHeight,
        ),
        body: const Column(
            children: [

        ]),
      );
  }
}
