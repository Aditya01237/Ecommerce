import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart/data/models/product/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../logic/services/formatter.dart';
import '../screens/product/product_details_screen.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;
  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return CupertinoButton(
          onPressed: () {
            Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                arguments: product);
          },
          padding: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset:
                        const Offset(0, 3), // changes the position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  CachedNetworkImage(
                    width: MediaQuery.of(context).size.width / 3.5,
                    imageUrl: "${product.images?[0]}",
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${product.title}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black),
                        ),
                        Text(
                          "${product.description}",
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("₹ ${Formatter.formatPrice(product.price!)}",
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
