import 'package:flutter/material.dart';

// void main() => runApp(SideDesign());

class SideDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("A Nice Nav"),
        ),
        body: Row(children: [
          SizedBox(
            width: 96,
            child: ListView(
              children: List.generate(10, (index) => index)
                  .map((e) => InkWell(
                      onTap: () {
                        setState(() {
                          _currentIndex = e;
                          _pageController.jumpToPage(_currentIndex);
                        });
                      },
                      child: Container(
                          alignment: Alignment.center,
                          width: 96,
                          height: 96,
                          color:
                              e == _currentIndex ? Colors.blue : Colors.white,
                          child: Text((e + 1).toString()))))
                  .toList(),
            ),
          ),
          Expanded(
              child: PageView(
            onPageChanged: (i) {
              setState(() => _currentIndex = i);
            },
            controller: _pageController,
            scrollDirection: Axis.vertical,
            children: List.generate(10, (index) => index)
                .map((e) => InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = e;
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: Text((e + 1).toString()))))
                .toList(),
          ))
        ]));
  }
}
