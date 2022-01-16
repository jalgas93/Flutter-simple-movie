import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MoviesDetails extends StatelessWidget {
  final movie;

  var image_url = 'https://image.tmdb.org/t/p/w500/';
  Color mainColor = Color(0xff3C3261);

  MoviesDetails(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            image_url + movie['poster_path'],
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    child: Container(
                      alignment: Alignment.center,
                      width: 400,
                      height: 400,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: NetworkImage(image_url + movie['poster_path']),
                          fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 20.0,
                          offset: Offset(0.0, 10.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 0.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            movie['title'],
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontFamily: 'Arvo'),
                          ),
                        ),
                        Text(
                          '${movie['vote_average']}/10',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontFamily: 'Arvo'),
                        ),
                      ],
                    ),
                  ),
                  Text(movie['overview'],
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Arvo')),
                  Padding(padding: EdgeInsets.all(10.0)),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        width: 150,
                        height: 60,
                        alignment: Alignment.center,
                        child: Text(
                          'Rate Movie',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Arvo',
                              fontSize: 20.0),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color(0xaa3C3261)),
                      )),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              color: const Color(0xaa3C3261)),
                        ),
                      ),
                      new Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: new Icon(
                              Icons.bookmark,
                              color: Colors.white,
                            ),
                            decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(10.0),
                                color: const Color(0xaa3C3261)),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
