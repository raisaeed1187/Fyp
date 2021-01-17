import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class buildCarouselSlider extends StatefulWidget {
  @override
  _buildCarouselSliderState createState() => _buildCarouselSliderState();
}

class _buildCarouselSliderState extends State<buildCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    final banners = Provider.of<QuerySnapshot>(context);
    return CarouselSlider(
      height: 150,
      viewportFraction: 0.9,
      aspectRatio: 16 / 9,
      autoPlay: true,
      enlargeCenterPage: true,
      items: banners.documents.map(
        (doc) {
          return Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(
                    doc.data['picUrl'],
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        doc.data['title'],
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(doc.data['content'],
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ).toList(),
    );
  }
}
