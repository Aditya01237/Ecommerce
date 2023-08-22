import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart/logic/cubits/product_cubit/product_cubit.dart';
import 'package:cart/logic/cubits/product_cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/services/formatter.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      if (state is ProductLoadingState && state.products.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is ProductErrorState && state.products.isEmpty) {
        return Center(
          child: Text(state.message),
        );
      }

      return ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          final product = state.products[index];

          return Padding(
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
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        Text(
                          "${product.description}",
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("₹ ${Formatter.formatPrice(product.price!)}",
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
