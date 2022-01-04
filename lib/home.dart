import 'dart:convert';

import 'package:app_firestore/add_page.dart';
import 'package:app_firestore/edit_page.dart';
import 'package:app_firestore/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('Product');
  List<ProductModel> products = [];
  @override
  initState() {
    super.initState();
    this.fetchProduct();
  }

  fetchProduct() async {
    products = [];
    QuerySnapshot response = await productsCollection.get();
    setState(() {
      products = response.docs.map(
        (e) {
          Map<String, dynamic> productJson = e.data() as Map<String, dynamic>;
          productJson["id"] = e.id;
          return ProductModel.fromJson(productJson);
        },
      ).toList();
    });
  }

  deleteProduct(String id) async {
    showLoaderDialog(context);
    await productsCollection.doc(id).delete();
    await this.fetchProduct();
    Navigator.pop(context);
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firestore"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.create),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddPage()))
              .then((value) {
            fetchProduct();
          });
        },
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: ListView(
          children: products
              .map(
                (product) => Card(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${product.name!} (${product.code})",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                  "Stock : ${product.stock} ${product.satuan}"),
                              Text(
                                  "Min-Stock : ${product.stockMin} ${product.satuan}"),
                              Text("Harga Beli : ${product.buyPrice}"),
                              Text("Harga Jual : ${product.sellPrice}")
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) =>
                                            EditPage(product: product))).then((value){
                                              fetchProduct();
                                            });
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {
                                deleteProduct(product.id!);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
