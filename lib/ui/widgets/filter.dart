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
  double _upperValue = 50000;
  List<String> brands = [];
  void _priceFilter(int lower, int upper) {
    setState(() {
      AppData.filterMobiles = AppData.filterMobiles
          .where((mobile) =>
              int.parse(mobile['price']) >= lower &&
              int.parse(mobile['price']) <= upper)
          .toList();
    });
  }

  List<String> allBrands = [];
  getAllbrands() async {
    QuerySnapshot results =
        await Firestore.instance.collection('mobiles').getDocuments();
    results.documents.forEach((element) {
      allBrands.add(element.data['brand']);
    });
  }

  applyFilters() async {
    AppData.filterMobiles.clear();
    print(allBrands.length);
    final QuerySnapshot result = await Firestore.instance
        .collection('mobiles')
        // .where('brand', isEqualTo: 'Xiaomi')
        .where('brand', whereIn: brands)
        // .where('price', isGreaterThanOrEqualTo: _lowerValue.toString())
        .where('price', isLessThanOrEqualTo: _upperValue)
        .getDocuments();
    print(result.documents.length);
    AppData.filterMobiles = result.documents;
  }

  bool _checkbox = false;
  @override
  Widget build(BuildContext context) {
    getAllbrands();
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
                              value: _checkbox,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
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
                              value: _checkbox,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
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
                              value: _checkbox,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
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
                              value: _checkbox,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
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
                              value: _checkbox,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
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
                              value: _checkbox,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
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
                              value: _checkbox,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
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
                              value: _checkbox,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
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
                              value: _checkbox,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
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
                            height: 30,
                            child: Checkbox(
                              value: _checkbox,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('5 GB'),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            // width: 10,
                            height: 30,
                            child: Checkbox(
                              value: _checkbox,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _checkbox = !_checkbox;
                                });
                              },
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                          Text('6 GB & Above'),
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
                  onPressed: () async {
                    print('apply filter click');
                    print("total filter: ${AppData.mobilesList.length}");

                    if (brands.isNotEmpty) {
                      await applyFilters();
                      print("total filter: ${AppData.filterMobiles.length}");
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              ProductList(mobilesList: AppData.filterMobiles)));
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductList(mobilesList: AppData.mobilesList),
                        ),
                      );
                    }
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
        setState(() {
          _isSelected = isSelected;
          if (_isSelected == true) {
            widget.brands.add(widget.chipName);
          } else {
            widget.brands.remove(widget.chipName);
          }
        });
      },
      selectedColor: Theme.of(context).primaryColor,
    );
  }
}
