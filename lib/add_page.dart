import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController buyPriceController = TextEditingController();
  TextEditingController sellPriceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController stockMinController = TextEditingController();
  TextEditingController satuanController = TextEditingController();
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Product');

  addProduct() async {
    showLoaderDialog(context);
    await productCollection.add({
      "code": codeController.text,
      "name": nameController.text,
      "buyPrice": int.parse(buyPriceController.text),
      "sellPrice": int.parse(sellPriceController.text),
      "stock": int.parse(stockController.text),
      "stock_min": int.parse(stockMinController.text),
      "satuan": satuanController.text
    });
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
        title: Text("Tambah Barang"),
      ),
      body: Container(
        color: Colors.white,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: codeController,
                decoration: const InputDecoration(
                  label: Text("Kode Barang"),
                ),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text("Nama Barang"),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: buyPriceController,
                decoration: const InputDecoration(
                  label: Text("Harga Beli Barang"),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: sellPriceController,
                decoration: const InputDecoration(
                  label: Text("Harga Jual Barang"),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: stockController,
                decoration: const InputDecoration(
                  label: Text("Stok Barang"),
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: stockMinController,
                decoration: const InputDecoration(
                  label: Text("Stok Minimal Barang"),
                ),
              ),
              TextField(
                controller: satuanController,
                decoration: const InputDecoration(
                  label: Text("Satuan Barang"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  addProduct();
                },
                child: const Text(
                  "Tambah Barng",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
