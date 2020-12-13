import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:flutterfirebase/modal/data.dart';
import 'package:flutterfirebase/ui/screens/products_list.dart';

class Filtre extends StatefulWidget {
  @override
  _FiltreState createState() => _FiltreState();
}

class _FiltreState extends State<Filtre> {
  double _lowerValue = 6000;
  double _upperValue = 50000;

  void _priceFilter(int lower, int upper) {
    setState(() {
      AppData.filterMobiles = AppData.mobilesList
          .where((mobile) =>
              int.parse(mobile['price']) >= lower &&
              int.parse(mobile['price']) <= upper)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Reset"),
              Text("Filters"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              color: Colors.black26,
              height: 2,
            ),
          ),
          SingleChildScrollView(
            child: Wrap(
              spacing: 5.0,
              children: <Widget>[
                filterChipWidget(
                  chipName: 'Apple',
                ),
                filterChipWidget(
                  chipName: 'Sumsang',
                ),
                filterChipWidget(
                  chipName: 'Oppo',
                ),
                filterChipWidget(
                  chipName: 'Realme',
                ),
                filterChipWidget(
                  chipName: 'Infinix',
                ),
                filterChipWidget(
                  chipName: 'Techno',
                ),
                filterChipWidget(
                  chipName: 'Huawei',
                ),
                filterChipWidget(
                  chipName: 'HTC',
                ),
                filterChipWidget(
                  chipName: 'Vivo',
                ),
                filterChipWidget(
                  chipName: 'Nokia',
                ),
              ],
            ),
          ),
          // Row(
          //   children: <Widget>[
          //     buildChip(
          //         "Infinix", Colors.grey.shade400, "A", Colors.grey.shade600),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("SORT BY"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Top Rated",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.check,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Divider(
              color: Colors.black26,
              height: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Nearest Me"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Divider(
              color: Colors.black26,
              height: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Cost Hight to Low"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Divider(
              color: Colors.black26,
              height: 2,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Cost Low to Hight"),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0),
            child: Divider(
              color: Colors.black26,
              height: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 8.0, left: 8.0, right: 8.0),
            child: Text("PRICE"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Rs " + '$_lowerValue'),
                Text("Rs " + '$_upperValue'),
              ],
            ),
          ),
          FlutterSlider(
            tooltip: FlutterSliderTooltip(
              leftPrefix: Icon(
                Icons.attach_money,
                size: 19,
                color: Colors.black45,
              ),
              rightSuffix: Icon(
                Icons.attach_money,
                size: 19,
                color: Colors.black45,
              ),
            ),
            trackBar: FlutterSliderTrackBar(
              inactiveTrackBar: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black12,
                border: Border.all(width: 3, color: Colors.blue),
              ),
              activeTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.red.withOpacity(0.5)),
            ),
            values: [3000, 42000],
            rangeSlider: true,
            max: 50000,
            min: 0,
            onDragging: (handlerIndex, lowerValue, upperValue) {
              _lowerValue = lowerValue;
              _upperValue = upperValue;
              // int lower = _lowerValue;
              int lower = _lowerValue.round();
              int upper = _upperValue.round();
              print("lower :${lower.toString()}");
              print("upper :${upper.toString()}");
              print(AppData.filterMobiles.length);
              _priceFilter(lower, upper);
              print(AppData.filterMobiles.length);
            },
          ),
          Center(
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ProductList(mobilesList: AppData.filterMobiles)));
              },
              color: Theme.of(context).primaryColor,
              child: Text(
                'Apply Filter',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding buildChip(
      String label, Color color, String avatarTitle, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, right: 2.0, left: 2.0),
      child: FilterChip(
        padding: EdgeInsets.all(4.0),
        label: Text(
          label,
          style: TextStyle(color: color),
        ),
        backgroundColor: Colors.transparent,
        shape: StadiumBorder(
          side: BorderSide(color: color),
        ),
        onSelected: (bool value) {
          print(label);
        },
      ),
    );
  }
}

class filterChipWidget extends StatefulWidget {
  final String chipName;

  filterChipWidget({Key key, this.chipName}) : super(key: key);

  @override
  _filterChipWidgetState createState() => _filterChipWidgetState();
}

class _filterChipWidgetState extends State<filterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.chipName),
      labelStyle: TextStyle(
          color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Colors.grey.shade400,
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          AppData.filterMobiles = AppData.mobilesList
              .where((mobile) => mobile['brand'] == widget.chipName)
              .toList();
          print(AppData.filterMobiles.length);
        });
      },
      selectedColor: Theme.of(context).primaryColor,
    );
  }
}
