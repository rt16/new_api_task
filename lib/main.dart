import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_api_proj/service/api_service.dart';
import 'package:news_api_proj/constants/constants.dart';
import 'package:news_api_proj/model/headlines_model.dart';

import 'wigdets/headlines_tile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      home: HeadLines(title: 'HeadLines'),
    );
  }
}

class HeadLines extends StatefulWidget {
  HeadLines({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HeadLinesState createState() => _HeadLinesState();
}

class _HeadLinesState extends State<HeadLines> {
  bool loader = false;
  ApiService apiService = new ApiService();
  String url;
  HeadLinesModel headLinesModel;
  List<Articles> articlesList;

  List<Articles> filteredList; //temp list to store the filtered list
  @override
  void initState() {
    //load all the data in the list
    getHeadLines();
    super.initState();
  }

//widget for search bar
  Widget _searchBar() {
    return Container(
      color: Colors.grey.shade800,
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusColor: Colors.white,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          hintText: "Search..",
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        onChanged: (text) {
          _filterHeadlines(text);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        centerTitle: true,
        title: Text(
          widget.title,
        ),
      ),
      body: loader == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                _searchBar(),
                //listview for headlines
                Expanded(
                  child: Container(
                    color: Colors.grey.shade800,
                    child: RefreshIndicator(
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 5),
                        physics: ScrollPhysics(),
                        itemCount:
                            filteredList == null ? 0 : filteredList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return HeadLinesTile(filteredList[index]);
                        },
                      ),
                      onRefresh: () async {
                        Completer<Null> completer = new Completer<Null>();
                        await Future.delayed(Duration(seconds: 3))
                            .then((onvalue) {
                          completer.complete();
                          setState(() {
                            headLinesModel = null;
                            getHeadLines();
                          });
                        });
                        return completer.future;
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

//method calling api and populating results
  getHeadLines() {
    url = base_url + headlines_api + "&apiKey=" + api_key;
    apiService.getMethod(url).then((value) {
      print(value);
      if (value['status'] == 200) {
        setState(() {
          headLinesModel = value['body'];
          articlesList = headLinesModel.articles;
          filteredList = headLinesModel.articles;
          loader = false;
        });
      }
    });
  }

//method to filter list
  _filterHeadlines(String text) {
    if (text.isEmpty) {
      setState(() {
        //if text is empty set the default list
        filteredList = articlesList;
      });
    } else {
      final List<Articles> filteredVal = <Articles>[];
      articlesList.map((articles) {
        if (articles.title.contains(text.toString())) {
          //else set the filtered list with the mapped values
          filteredVal.add(articles);
          print(filteredVal);
        }
      }).toList();
      setState(() {
        filteredList = filteredVal;
      });
    }
  }
}
