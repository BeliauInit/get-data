import 'package:flutter/material.dart';

import 'pages/movie_list.dart';

void main() {
  runApp(const init());
}

class init extends StatelessWidget {
  const init({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Popular Movies!",
      // theme: ThemeData.dark(),
      home: home(),
    );
  }
}

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return movieList();
  }
}


