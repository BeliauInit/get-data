import 'package:flutter/material.dart';
import 'package:http_request/API/http_service.dart';
import 'package:http_request/models/movie.dart';

class movieList extends StatefulWidget {
  const movieList({super.key});

  @override
  State<movieList> createState() => _movieListState();
}

class _movieListState extends State<movieList> {
  int? moviesCount = 0;
  List? movie;
  HttpService? service;

  Future initialize() async {
    movie = [];
    movie = await service?.getPopularMovies();
    setState(() {
      moviesCount = movie!.length;
      movie = movie;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child:
        Text(
          "Popular Movies",
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
        ),
      ),
      body: movie!.isEmpty ? Container(child: Text("Loading..."),) : ListView.builder(
        itemCount: moviesCount,
        itemBuilder: (context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: InkWell(
              onTap: () {
                OverlayState _overlayState = Overlay.of(context);
                OverlayEntry? _overlayEntry;

                _overlayEntry = OverlayEntry(builder: (context) {
                  return Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: const Color.fromARGB(100, 0, 0, 0),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: List.filled(1, BoxShadow(color: Colors.black38, blurRadius: 32))
                          ),
                          margin: EdgeInsets.all(32),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image(
                                    image: NetworkImage(movie![position].posterpath.toString(),),
                                    height: 320,
                                    width: 320,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                movie![position].title.toString(),
                                style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontFamily: "Google Sans", fontWeight: FontWeight.bold, fontSize: 32),
                              ),
                              SizedBox(height: 32),
                              Text(
                                "Overview:",
                                style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontFamily: "Google Sans", fontWeight: FontWeight.normal, fontSize: 20),
                              ),
                              Text(
                                movie![position].overview.toString(),
                                style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontFamily: "Google Sans", fontWeight: FontWeight.normal, fontSize: 16),
                              ),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  Text(
                                    'Vote Average: ',
                                    style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontFamily: "Google Sans", fontWeight: FontWeight.normal, fontSize: 24),
                                  ),
                                  Text(
                                    movie![position].voteaverage.toString(),
                                    style: TextStyle(color: Colors.black, decoration: TextDecoration.none, fontFamily: "Google Sans", fontWeight: FontWeight.bold, fontSize: 24),
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              ElevatedButton(
                                onPressed: () {
                                  _overlayEntry!.remove();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  fixedSize: Size(MediaQuery.of(context).size.width - 32, 50),
                                ),
                                child: Text("Back", style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ]
                  );
                });

                _overlayState.insert(_overlayEntry);
              },
              child:
              ListTile(
                leading: Image(image: NetworkImage(movie![position].posterpath)),
                title: Text(movie![position].title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),),
                subtitle: Text('Rating = ' + movie![position].voteaverage.toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}
