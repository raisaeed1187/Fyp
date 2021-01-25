import 'package:cloud_firestore/cloud_firestore.dart';
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
  double _upperValue = 500000;
  List<String> brands = [];
  List<String> rams = [];
  List<int> batteries = [];

  void _priceFilter(int lower, int upper) {
    setState(() {
      AppData.filterMobiles = AppData.filterMobiles
          .where((mobile) =>
              int.parse(mobile['price']) >= lower &&
              int.parse(mobile['price']) <= upper)
          .toList();
    });
  }

  void brandFilter(String brand) {
    setState(() {
      AppData.filterMobiles.addAll(AppData.mobilesList
              .where((mobile) => (mobile['brand']) == brand)
              ?.toList() ??
          []);
    });
  }

  List<String> allBrands = [
    'Apple',
    'Samsung',
    'Oppo',
    'RealMe',
    'Nokia',
    'Tecno',
    'Vivo',
    'Infinix',
    'Itel',
  ];
  int minPrice = 10000;
  int maxPrice = 100000;
  List<int> allBattries = [2500, 3000, 3500, 4000, 4500, 5000];
  List<String> allrams = ['2 GB', '3 GB', '4 GB', '5 GB', '6 GB'];
  List<bool> ramList = [false, false, false, false, false, false];
  applyFilters() async {
    AppData.filterMobiles.clear();
    print(allBrands.length);
    // if (rams.length == batteries.length) {
    for (var i = 0; i < rams.length; i++) {
      final QuerySnapshot result = await Firestore.instance
          .collection('mobiles')
          // .where('battery_size',
          //     isGreaterThanOrEqualTo:
          //         batteries.isEmpty ? null : batteries[0] - 500)
          // .where('battery_size',
          //     isEqualTo: batteries.isEmpty ? null : batteries[0])
          .where('brand', whereIn: brands.isEmpty ? null : brands)
          // .where('ram', isEqualTo: '2 GB')
          .where('ram', isEqualTo: rams.isEmpty ? null : rams[i])
          // .where('ram', whereIn: rams.isEmpty ? allrams : rams)
          .where('price', isGreaterThanOrEqualTo: minPrice)
          .where('price', isLessThanOrEqualTo: maxPrice)
          .getDocuments();
      print(result.documents.length);
      AppData.filterMobiles.addAll(result.documents);
    }
    // }
  }

//---------battery checkbox----------
  bool _checkbox = false;
  bool _checkbox25 = false;
  bool _checkbox30 = false;
  bool _checkbox35 = false;
  bool _checkbox40 = false;
  bool _checkbox45 = false;
  bool _checkbox50 = false;
//------------ram checkbox--------
  bool _checkbox2 = false;
  bool _checkbox3 = false;
  bool _checkbox4 = false;
  bool _checkbox5 = false;
  bool _checkbox6 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("In filterchip ${AppData.filterMobiles.length}");
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(12.0),
        // height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
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
                      brands: brands,
                    ),
                    filterChipWidget(
                      chipName: 'Samsung',
                      brands: brands,
                    ),
                    filterChipWidget(
                      chipName: 'Oppo',
                      brands: brands,
                    ),
                    filterChipWidget(
                      chipName: 'Realme',
                      brands: brands,
                    ),
                    filterChipWidget(
                      chipName: 'Infinix',
                      brands: brands,
                    ),
                    filterChipWidget(
                      chipName: 'Tecno',
                      brands: brands,
                    ),
                    filterChipWidget(
                      chipName: 'Huawei',
                      brands: brands,
                    ),
                    filterChipWidget(
                      chipName: 'HTC',
                      brands: brands,
                    ),
                    filterChipWidget(
                      chipName: 'Vivo',
                      brands: brands,
                    ),
                    filterChipWidget(
                      chipName: 'Nokia',
                      brands: brands,
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
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: Divider(
                  color: Colors.black26,
                  height: 2,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Battery",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Checkbox(
                              value: _checkbox25,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox25 = !_checkbox25;
                                  if (_checkbox25 == true) {
                                    batteries.add(2500);
                                    AppData.battries.add(2500);
                                  } else {
                                    AppData.battries.remove(2500);
                                    batteries.remove(2500);
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('2500 mAh'),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Checkbox(
                              value: _checkbox30,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox30 = !_checkbox30;
                                  if (_checkbox30 == true) {
                                    batteries.add(3000);
                                    AppData.battries.add(3000);
                                  } else {
                                    AppData.battries.remove(3000);
                                    batteries.remove(3000);
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('3000 mAh'),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Checkbox(
                              value: _checkbox35,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox35 = !_checkbox35;
                                  if (_checkbox35 == true) {
                                    batteries.add(3500);
                                    AppData.battries.add(3500);
                                  } else {
                                    AppData.battries.remove(3500);
                                    batteries.remove(3500);
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('3500 mAh'),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Checkbox(
                              value: _checkbox40,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox40 = !_checkbox40;
                                  if (_checkbox40 == true) {
                                    batteries.add(4000);
                                    AppData.battries.add(4000);
                                  } else {
                                    AppData.battries.remove(4000);
                                    batteries.remove(4000);
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('4000 mAh'),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            // width: 10,
                            height: 30,
                            child: Checkbox(
                              value: _checkbox45,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox45 = !_checkbox45;
                                  if (_checkbox45 == true) {
                                    batteries.add(4500);
                                    AppData.battries.add(4500);
                                  } else {
                                    AppData.battries.remove(4500);
                                    batteries.remove(4500);
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('4500 mAh'),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Checkbox(
                              value: _checkbox50,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox50 = !_checkbox50;
                                  if (_checkbox50 == true) {
                                    batteries.add(5000);
                                    AppData.battries.add(5000);
                                  } else {
                                    AppData.battries.remove(5000);
                                    batteries.remove(5000);
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('5000 mAh & Above'),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "RAM",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Checkbox(
                              value: ramList[0],
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  ramList[0] = value;
                                  if (ramList[0] == true) {
                                    rams.add('2 GB');
                                    AppData.rams.add('2 GB');
                                  } else {
                                    AppData.rams.remove('2 GB');
                                    rams.remove('2 GB');
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('2 GB'),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Checkbox(
                              value: ramList[1],
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  ramList[1] = value;
                                  if (ramList[1] == true) {
                                    rams.add('3 GB');
                                    AppData.rams.add('3 GB');
                                  } else {
                                    AppData.rams.remove('3 GB');
                                    rams.remove('3 GB');
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('3 GB'),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Checkbox(
                              value: ramList[2],
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  ramList[2] = value;
                                  if (ramList[2] == true) {
                                    rams.add('4 GB');
                                    AppData.rams.add('4 GB');
                                  } else {
                                    AppData.rams.remove('4 GB');
                                    rams.remove('4 GB');
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('4 GB'),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            // width: 10,
                            height: 30,
                            child: Checkbox(
                              value: ramList[4],
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  ramList[4] = !ramList[4];
                                  if (ramList[4] == true) {
                                    rams.add('6 GB');
                                    AppData.rams.add('6 GB');
                                  } else {
                                    AppData.rams.remove('6 GB');
                                    rams.remove('6 GB');
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('6 GB'),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Checkbox(
                              value: ramList[3],
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  ramList[3] = !ramList[3];
                                  if (_checkbox5 == true) {
                                    rams.add('8 GB');
                                    AppData.rams.add('8 GB');
                                  } else {
                                    AppData.rams.remove('8 GB');
                                    rams.remove('8 GB');
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('8 GB'),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            child: Checkbox(
                              value: ramList[5],
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  ramList[5] = !ramList[5];
                                  if (ramList[5] == true) {
                                    rams.add('12 GB');
                                    AppData.rams.add('12 GB');
                                  } else {
                                    AppData.rams.remove('12 GB');
                                    rams.remove('12 GB');
                                  }
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('12 GB & Above'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, bottom: 8.0, left: 8.0, right: 8.0),
                child: Text(
                  "PRICE",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 16),
                ),
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
                values: [3000, 420000],
                rangeSlider: true,
                max: 500000,
                min: 0,
                onDragging: (handlerIndex, lowerValue, upperValue) {
                  _lowerValue = lowerValue;
                  _upperValue = upperValue;
                  // int lower = _lowerValue;
                  int lower = _lowerValue.round();
                  int upper = _upperValue.round();

                  setState(() {
                    minPrice = lowerValue.round();
                    maxPrice = upperValue.round();
                    AppData.minPrice = lower;
                    AppData.maxPrice = upper;
                  });
                  print("lower :${lower.toString()}");
                  print("upper :${upper.toString()}");
                  // print(AppData.filterMobiles.length);
                  // _priceFilter(lower, upper);
                  // print(AppData.filterMobiles.length);
                },
              ),
              Center(
                child: FlatButton(
                  onPressed: () async {
                    print('apply filter click');
                    print("total filter: ${AppData.mobilesList.length}");

                    // if (brands.isNotEmpty) {
                    // await applyFilters();
                    print("total filter: ${AppData.filterMobiles.length}");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProductList(mobilesList: AppData.filterMobiles)));
                    // } else {
                    //   Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (context) =>
                    //           ProductList(mobilesList: AppData.mobilesList),
                    //     ),
                    //   );
                    // }
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Apply Filter',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
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
  final List<String> brands;
  filterChipWidget({Key key, this.chipName, this.brands}) : super(key: key);

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
        // widget.filterBrands(widget.chipName);
        print(AppData.filterMobiles.length);
        setState(() {
          _isSelected = isSelected;
          if (_isSelected == true) {
            widget.brands.add(widget.chipName);
            AppData.brands.add(widget.chipName);
          } else {
            widget.brands.remove(widget.chipName);
            AppData.brands.remove(widget.chipName);
          }
        });
      },
      selectedColor: Theme.of(context).primaryColor,
    );
  }
}
