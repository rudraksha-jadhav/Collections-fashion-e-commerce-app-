import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final double price;
  const PriceTag({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Text('\$$price');
  }
}
