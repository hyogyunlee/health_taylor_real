import 'package:flutter/material.dart';

class CategoryDetail extends StatefulWidget {
  final String goal, brand, category, taste, disease, family;
  const CategoryDetail(
      {super.key,
        required this.goal,
        required this.brand,
        required this.category,
        required this.taste,
        required this.disease,
        required this.family});

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(widget.goal),
          Text(widget.brand),
          Text(widget.category),
          Text(widget.taste),
          Text(widget.disease),
          Text(widget.family),
        ],
      ),
    );
  }
}