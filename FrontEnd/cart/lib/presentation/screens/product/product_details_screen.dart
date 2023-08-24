import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart/data/models/product/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import '../../../logic/cubits/cart_cubit/cart_cubit.dart';
import '../../../logic/cubits/cart_cubit/cart_state.dart';
import '../../../logic/services/formatter.dart';
import '../../widgets/primary_cart_button.dart';
import '../cart/cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductDetailsScreen({super.key, required this.productModel});

  static const routeName = "product_details";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Text(
          "${widget.productModel.title}",
          style: const TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            icon: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Badge(
                  label: Text("${state.items.length}"),
                  isLabelVisible: (state is CartLoadingState) ? false : true,
                  child: const Icon(CupertinoIcons.cart_fill),
                );
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                itemCount: widget.productModel.images?.length ?? 0,
                slideBuilder: (index) {
                  String url = widget.productModel.images![index];
                  return CachedNetworkImage(
                    imageUrl: url,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.productModel.title}",
                    style: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "₹ ${Formatter.formatPrice(widget.productModel.price!)}",
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                    bool isInCart = BlocProvider.of<CartCubit>(context)
                        .cartContains(widget.productModel);

                    return PrimaryCartButton(
                        onPressed: () {
                          if (isInCart) {
                            return;
                          }

                          BlocProvider.of<CartCubit>(context)
                              .addToCart(widget.productModel, 1);
                        },
                        text: (isInCart) ? "Already in Cart" : "Add to Cart");
                  }),
                  const SizedBox(height: 20),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.productModel.description}",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
