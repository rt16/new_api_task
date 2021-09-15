import 'package:flutter/material.dart';
import 'package:news_api_proj/model/headlines_model.dart';

class HeadLinesTile extends StatefulWidget {
  final Articles articles;
  HeadLinesTile(this.articles);

  @override
  _HeadLinesTileState createState() => _HeadLinesTileState();
}

class _HeadLinesTileState extends State<HeadLinesTile> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    final publishedDate = DateTime.parse(widget.articles.publishedAt);
    final toDayDate = DateTime.now();
    var different = toDayDate.difference(publishedDate).inHours;
    var hrs = different == 1 ? "hr" : "hrs";
    return Container(
        margin: EdgeInsets.only(bottom: 24),
        width: MediaQuery.of(context).size.width,
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.articles.urlToImage,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: 12,
                ),
                Text(
                  widget.articles.title,
                  maxLines: 2,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.5),
                ),
                SizedBox(
                  height: 4,
                ),
                // Text(
                //   widget.articles.description != null
                //       ? widget.articles.description
                //       : "",
                //   maxLines: 3,
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 14,
                //       fontFamily: 'OpenSans'),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //news source
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.source,
                          color: Colors.yellow.shade200,
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          widget.articles.source.name != null
                              ? widget.articles.source.name
                              : "",
                          maxLines: 3,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 8),
                          child: Text(
                            ". ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Text(
                          "$different " + hrs,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ),
                    SizedBox(height: 40), //news actions button
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              liked = !liked;
                            });
                          },
                          icon: Icon(
                              liked ? Icons.favorite : Icons.favorite_outline),
                          color: liked ? Colors.red : Colors.grey,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Icon(
                          Icons.share_outlined,
                          color: Colors.grey,
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: Colors.grey,
                  height: 1,
                )
              ],
            ),
          ),
        ));
  }
}
