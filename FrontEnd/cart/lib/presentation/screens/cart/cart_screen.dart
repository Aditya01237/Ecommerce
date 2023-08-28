import 'package:cart/presentation/screens/order/order_detail_screen.dart';
import 'package:cart/presentation/widgets/primary_cart_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/ui.dart';
import '../../../logic/cubits/cart_cubit/cart_cubit.dart';
import '../../../logic/cubits/cart_cubit/cart_state.dart';
import '../../../logic/services/calculations.dart';
import '../../../logic/services/formatter.dart';
import '../../widgets/cart_list_view.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = "cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart", style: TextStyle(fontSize: 30)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
          if (state is CartLoadingState && state.items.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CartErrorState && state.items.isEmpty) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is CartLoadedState && state.items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.cart_badge_plus,
                    size: 80,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "No Item Added",
                    style: TextStyle(fontSize: 30),
                  )
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(child: CartListView(items: state.items)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.items.length} items",
                            style: TextStyles.body1
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Total: ${Formatter.formatPrice(Calculations.cartTotal(state.items).toInt())}",
                            style: TextStyles.heading3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: PrimaryCartButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, OrderDetailScreen.routeName);
                        },
                        text: "Place Order",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
