import 'package:flutter/material.dart';
import 'package:rey_inventory/models/product.dart';
import 'package:rey_inventory/widgets/left_drawer.dart';

class DetailProductPage extends StatefulWidget {
  final Product product;

  const DetailProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<DetailProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Detail'),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.fields.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Amount: ${widget.product.fields.amount}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Description: ${widget.product.fields.description}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to List'),
            ),
          ],
        ),
      ),
    );
  }
}
