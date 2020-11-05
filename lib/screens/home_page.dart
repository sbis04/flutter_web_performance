import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_web_performance/model/coffee.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    parseJsonData();
  }

  Future<List<Coffee>> parseJsonData() async {
    String jsonData = await DefaultAssetBundle.of(context).loadString('assets/data.json');
    var parsedJson = json.decode(jsonData);

    CoffeeTypes coffeeTypes = CoffeeTypes.fromJson(parsedJson);
    List<Coffee> coffeeList = coffeeTypes.coffee;

    return coffeeList;

    // print('Name: ${coffee[0].name}');
    // print('Description: ${coffee[0].description}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.brown[50],
        title: Text(
          'Coffee Brewery',
          style: TextStyle(color: Colors.brown),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: parseJsonData(),
        builder: (context, snapshot) {
          List<Coffee> coffeeList = snapshot.data;

          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: coffeeList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        '/description',
                        arguments: coffeeList[index],
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          coffeeList[index].name,
                          style: TextStyle(
                              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          coffeeList[index].description,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: 'Ratio: ',
                            style: TextStyle(
                                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: coffeeList[index].ratio,
                                style: TextStyle(
                                  color: Colors.green[800],
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            text: 'Cup: ',
                            style: TextStyle(
                                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: coffeeList[index].cup,
                                style: TextStyle(
                                  color: Colors.green[800],
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
