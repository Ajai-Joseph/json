import 'dart:convert';

import 'package:coolminds/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetails extends StatefulWidget {
  String productId;
  ProductDetails({required this.productId});
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late Future<Store> storeDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeDetails = fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Product Details"),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: FutureBuilder<Store>(
                future: storeDetails,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Image.network(snapshot.data!.image)),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "₹ ${snapshot.data!.price}",
                                  style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${snapshot.data!.title}",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 0.3,
                                color: Colors.black,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${snapshot.data!.description}",
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Rating",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${snapshot.data!.rating.rate}",
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Category",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${snapshot.data!.category}",
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Available Stock",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "${snapshot.data!.rating.count}",
                                ),
                              ),
                              Divider(
                                thickness: 0.3,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Store> fetchDetails() async {
    final response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/${widget.productId}'));

    if (response.statusCode == 200) {
      return Store.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
