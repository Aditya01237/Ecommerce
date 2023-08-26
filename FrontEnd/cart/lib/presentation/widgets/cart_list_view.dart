import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';
import '../../data/models/cart/cart_item_model.dart';
import '../../logic/cubits/cart_cubit/cart_cubit.dart';
import '../../logic/services/formatter.dart';

class CartListView extends StatelessWidget {
  final List<CartItemModel> items;
  final bool shrinkWrap;
  final bool noScroll;

  const CartListView(
      {super.key,
      required this.items,
      this.shrinkWrap = false,
      this.noScroll = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: (noScroll) ? const NeverScrollableScrollPhysics() : null,
      shrinkWrap: shrinkWrap,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 3,
            color: Colors.white70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    width: 80,
                    imageUrl: item.product!.images![0],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${item.product?.title}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "₹ ${Formatter.formatPrice(item.product!.price!)}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InputQty(
                        maxVal: 99,
                        initVal: item.quantity!,
                        minVal: 1,
                        showMessageLimit: false,
                        onQtyChanged: (value) {
                          if (value == item.quantity) return;
                          BlocProvider.of<CartCubit>(context)
                              .addToCart(item.product!, value as int);
                        },
                      ),
                      const SizedBox(height: 8),
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<CartCubit>(context)
                              .removeFromCart(item.product!);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ],
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
