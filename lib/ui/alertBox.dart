import 'package:commons/commons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlertBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Commons Example',
      home: MyHomePage(title: 'Commons Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _online = false;
  bool _connected = false;
  var listener;
  String singleInput = "";
  Set<SimpleItem> _selectedItems = Set();

  _checkInternet() async {
    listener = await ConnectionChecker()
        .getInstance()
        .setDuration(Duration(
          seconds: 1,
        ))
        .listener(
      connected: () {
        setState(() {
          _online = true;
        });
      },
      disconnected: () {
        setState(() {
          _online = false;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _checkInternet();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
          child: ListView(children: <Widget>[
        ListTile(
          onTap: () {
            successDialog(context, "Success demo dialog");
          },
          title: Text("Success Dialog"),
        ),
        ListTile(
          onTap: () {
            errorDialog(
              context,
              "Contrary to popular belief, Lorem Ipsum is not years old. Richard McClintock",
              negativeText: "Try Again",
              negativeAction: () {},
              positiveText: "Details",
              positiveAction: () {},
            );
          },
          title: Text("Error Dialog"),
        ),
        ListTile(
          onTap: () {
            warningDialog(context, "Warning demo dialog");
          },
          title: Text("Warning Dialog"),
        ),
        ListTile(
          onTap: () {
            infoDialog(context, "Info demo dialog");
          },
          title: Text("Info Dialog"),
        ),
        ListTile(
          onTap: () {
            confirmationDialog(context, "Confirm demo dialog",
                positiveText: "Delete",
                positiveAction: () {},
                confirmationText: "Check this");
          },
          title: Text("Confirm Dialog"),
        ),
        ListTile(
          onTap: () {
            dialog(
              context,
              Colors.pink,
              "Title",
              "Some message",
              false,
              true,
              customIcon: Icon(
                Icons.ac_unit,
                size: 64,
                color: Colors.white,
              ),
            );
          },
          title: Text("Custom Dialog"),
        ),
        ListTile(
          onTap: () {
            singleInputDialog(
              context,
              title: "Input Dialog",
              label: "Name",
              value: singleInput,
              validator: (value) {
                print("Validator: $value");
                return value.isEmpty ? "Required!" : null;
              },
              positiveAction: (value) {
                print("Submit: $value");
                setState(() {
                  singleInput = value;
                });
              },
              negativeAction: () {
                print("negative action");
              },
              neutralAction: () {
                print("neutral action");
              },
            );
          },
          title: Text("Single input dialog"),
          subtitle: Text("$singleInput"),
        ),
        ListTile(
          onTap: () {
            waitDialog(context, duration: Duration(seconds: 3));
          },
          title: Text("Wait Dialog"),
        ),
        ListTile(
          onTap: () {
            List<SimpleItem> list = List()
              ..add(SimpleItem(1, "One", remarks: "sub title"))
              ..add(SimpleItem(2, "Teo", remarks: "sub title"))
              ..add(SimpleItem(3, "Three", remarks: "sub title"))
              ..add(SimpleItem(4, "Four", remarks: "sub title"))
              ..add(SimpleItem(5, "Five", remarks: "sub title"))
              ..add(SimpleItem(6, "Six", remarks: "sub title"))
              ..add(SimpleItem(7, "Seven", remarks: "sub title"))
              ..add(SimpleItem(8, "Eight", remarks: "sub title"))
              ..add(SimpleItem(9, "Nine", remarks: "sub title"));
            push(
              context,
              ListViewScreen(
                "List View Example",
                list,
                (item, index, searchValue) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    elevation: 1,
                    child: ListTile(
                      onTap: () {
                        popThis();
                        print("$item at index $index");
                      },
                      title: highlightTitleTextWidget(
                          context, item.title, searchValue),
                      subtitle: highlightSubTitleTextWidget(
                          context, item.remarks, searchValue),
                    ),
                  );
                },
                searchCriteria: (item, text) => item.title.contains(text),
              ),
            );
          },
          title: Text("List View Screen"),
        ),
        ListTile(
          onTap: () {
            var options = List<Option>()
              ..add(Option.edit())
              ..add(Option.view())
              ..add(Option.details())
              ..add(Option.delete())
              ..add(Option.item(Text("Custom"), icon: Icon(Icons.details)));
            optionsDialog(context, "Options", options);
          },
          title: Text("Options Dialog"),
        ),
        ListTile(
          onTap: () {
            var list = Set<SimpleItem>()
              ..add(SimpleItem(1, "Version 1.0"))
              ..add(SimpleItem(1, "Version 2.0"))
              ..add(SimpleItem(1, "Version 3.0"))
              ..add(SimpleItem(1, "Version 4.0"))
              ..add(SimpleItem(2, "Version 5.0"))
              ..add(SimpleItem(3, "Version 6.0"))
              ..add(SimpleItem(4, "Version 7.0"));
            singleSelectDialog(context, "Single Select", list, (item) {
              print(item);
            });
          },
          title: Text("Single select dialog"),
        ),
        ListTile(
          onTap: () {
            Set<SimpleItem> list = Set()
              ..add(SimpleItem(1, "Version 1.0"))
              ..add(SimpleItem(1, "Version 2.0"))
              ..add(SimpleItem(1, "Version 3.0"))
              ..add(SimpleItem(1, "Version 4.0"))
              ..add(SimpleItem(2, "Version 5.0"))
              ..add(SimpleItem(3, "Version 6.0"))
              ..add(SimpleItem(4, "Version 7.0"))
              ..add(SimpleItem(4, "Version 8.0"))
              ..add(SimpleItem(4, "Version 9.0"))
              ..add(SimpleItem(4, "Version 10.0"));
            multiSelectDialog(
              context,
              "Multi Selects",
              list,
              _selectedItems,
              (values) {
                setState(() {
                  _selectedItems = values;
                });
                print(values);
              },
            );
          },
          title: Text("Multi select dialog"),
        ),
        ListTile(
          onTap: () {
            Set<SimpleItem> set = Set<SimpleItem>()
              ..add(SimpleItem(1, "One"))
              ..add(SimpleItem(2, "Two"))
              ..add(SimpleItem(3, "Three"));
            radioListDialog(
              context,
              "Select one",
              set,
              (item) {
                print(item);
              },
            );
          },
          title: Text("Radio list dialog"),
        ),
        ListTile(
          onTap: () {
            successToast("Success toast");
          },
          title: Text("Success toast"),
        ),
        ListTile(
          onTap: () {
            errorToast("Error toast");
          },
          title: Text("Error toast"),
        ),
        ListTile(
          onTap: () {
            warningToast("Warning toast");
          },
          title: Text("Warning toast"),
        ),
        ListTile(
          onTap: () {
            infoToast("Info toast");
          },
          title: Text("Info toast"),
        ),
        ListTile(
          onTap: () {
            push(
              context,
              loadingScreen(
                context,
                duration: Duration(
                  seconds: 5,
                ),
                loadingType: LoadingType.JUMPING,
              ),
            );
          },
          title: Text("Loading Screen"),
        ),
        ListTile(
          onTap: () {
            getPackageInfo().then((info) {
              infoDialog(context, info, textAlign: TextAlign.start);
            });
          },
          title: Text("Package Info Dialog"),
        ),
        ListTile(
          onTap: () {
            getDeviceInfo().then((info) {
              infoDialog(context, info, textAlign: TextAlign.start);
            });
          },
          title: Text("Device Info Dialog"),
        ),
      ])),
    );
  }
}
