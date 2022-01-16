import 'dart:convert';


import 'package:flutter_movie/movies_detail.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'config.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  var movies;
  Color mainColor = const Color(0xff3C3261);

  void getData() async {
    var data = await getJson();

    setState(() {
      movies = data['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back,
          color: mainColor,
        ),
        title: Text(
          'Movies',
          style: TextStyle(
              color: mainColor,
              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold),
        ),
        actions: [
          Icon(
            Icons.menu,
            color: mainColor,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MovieTitle(mainColor),
            Expanded(
              child: ListView.builder(
                itemCount: movies == 0 ? null : movies.length,
                itemBuilder: (context, i) {
                  return FlatButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MoviesDetails(movies[i]);
                      }));
                    },
                    child: MovieCell(movies: movies, i: i),
                    color: Colors.white,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<Map> getJson() async {
  var apiKey = getApiKey();
  var url = 'http://api.themoviedb.org/3/discover/movie?api_key=${apiKey}';
  var response = await http.get(Uri.parse(url));
  return json.decode(response.body);
}

class MovieTitle extends StatelessWidget {
  final Color mainColor;

  MovieTitle(this.mainColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Text(
        'Top Rated',
        style: TextStyle(
            fontSize: 40.0,
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arvo'),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class MovieCell extends StatelessWidget {
  final movies;
  final i;
  Color mainColor = Color(0xff3C3261);
  var image_url = 'https://image.tmdb.org/t/p/w500/';

  MovieCell({Key? key, this.movies, this.i});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.all(0.0),
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: Container(
                  width: 70,
                  height: 70,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                  image: DecorationImage(
                      image: NetworkImage(image_url + movies[i]['poster_path']),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                      color: mainColor,
                      blurRadius: 0.5,
                      offset: Offset(2.0, 5.0),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: Column(
                children: [
                  Text(
                    movies[i]['title'],
                    style: TextStyle(
                        color: mainColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arvo'),
                  ),
                  Padding(padding: EdgeInsets.all(2.0)),
                  Text(
                    movies[i]['overview'],
                    maxLines: 3,
                    style:
                        TextStyle(color: Color(0xff8785A4), fontFamily: 'Arvo'),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ))
          ],
        ),
        Container(
          width: 300,
          height: 0.5,
          color: Color(0xD2D2E1ff),
          margin: EdgeInsets.all(16.0),
        )
      ],
    );
  }
}
