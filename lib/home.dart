import 'dart:convert';
import 'package:coolminds/model.dart';
import 'package:coolminds/productDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Store> store = [];
  List<Store> storee = [];
  late String image, name;
  late int idd;
  Map<String, List> map = {};
  List title = [];
  List img = [];
  List id = [];
  late Future<List<Store>> returnMap;
  @override
  void initState() {
    // TODO: implement initState
    fetchDetails().then((value) {
      setState(() {
        storee.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProductDetails(
                          productId: storee[index].id.toString())));
                },
                leading: Image.network(
                  storee[index].image,
                  width: 50,
                  height: 50,
                ),
                title: Text(storee[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(storee[index].price.toString()),
                    Text(storee[index].rating.rate.toString()),
                  ],
                ),
              ),
            );
          },
          itemCount: storee.length,
        ),
      ),
    );
  }

  Future<List<Store>> fetchDetails() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      for (var u in jsonData) {
        store.add(Store.fromJson(u));
      }
      return store;
    } else {
      throw Exception('Failed to load');
    }
  }
}
