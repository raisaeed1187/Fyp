import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OverviewWidget extends StatefulWidget {
  List<DocumentSnapshot> compareList;
  List<int> mobilesScore;
  OverviewWidget({Key key, this.compareList, this.mobilesScore})
      : super(key: key);

  @override
  _OverviewWidgetState createState() =>
      _OverviewWidgetState(compareList, mobilesScore);
}

class _OverviewWidgetState extends State<OverviewWidget> {
  List<DocumentSnapshot> compareList;
  List<int> mobilesScore;
  _OverviewWidgetState(this.compareList, this.mobilesScore);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60.0,
                padding: EdgeInsets.only(left: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'OURVIEW',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(
//                        bottom: BorderSide(color: Colors.black, width: 3.0),
                      ),
                  color: Colors.grey[200],
                ),
              ),
              SectionWidget(
                title: 'Ranking',
                compareList: compareList,
                mobilesScore: mobilesScore,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String title;
  String name;
  List<DocumentSnapshot> compareList;
  List<int> mobilesScore;
  List<Color> colors = [
    Colors.greenAccent,
    Colors.deepPurple[100],
    Colors.deepOrange[100],
    Colors.brown[200],
  ];
  SectionWidget({this.title, this.compareList, this.mobilesScore});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
              decoration: BoxDecoration(color: Colors.blue[200]),
            ),
            Column(
                children: List.generate(compareList.length, (index) {
              return ScoreSection(
                compareList: compareList,
                mobilesScore: mobilesScore,
                index: index,
              );
            })),
          ],
        ),
      ),
    );
  }
}

class ScoreSection extends StatelessWidget {
  List<DocumentSnapshot> compareList;
  List<int> mobilesScore;
  List<Color> colors = [
    Colors.greenAccent,
    Colors.deepPurple[100],
    Colors.deepOrange[100],
    Colors.brown[200],
  ];
  int index;

  ScoreSection({this.compareList, this.mobilesScore, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colors[index]),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                compareList[index]['product_name'],
                style: TextStyle(fontSize: 18, letterSpacing: 1),
              ),
            ),
          ),
          Container(
            width: 45,
            height: 35,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                mobilesScore[index].toString(),

                // index != compareList.length - 1
                //     ? mobilesScore[index] > mobilesScore[index + 1]
                //         ? mobilesScore[index].toString()
                //         : mobilesScore[index + 1].toString()
                //     : mobilesScore[index + 1] > mobilesScore[index]
                //         ? mobilesScore[index].toString()
                //         : mobilesScore[index + 1].toString(),
                style: TextStyle(fontSize: 20),
              ),
            ),
            decoration: BoxDecoration(color: Colors.green),
          )
        ],
      ),
    );
  }
}
