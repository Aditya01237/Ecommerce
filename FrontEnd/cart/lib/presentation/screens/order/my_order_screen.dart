import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart/core/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubits/order_cubit/order_cubit.dart';
import '../../../logic/cubits/order_cubit/order_state.dart';
import '../../../logic/services/calculations.dart';
import '../../../logic/services/formatter.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({Key? key}) : super(key: key);

  static const routeName = "my_orders";

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: TextStyles.heading3,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderLoadingState && state.orders.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is OrderErrorState && state.orders.isEmpty) {
              return Center(child: Text(state.message));
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.orders.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemBuilder: (context, index) {
                final order = state.orders[index];

                return Card(
                  color: (index % 2 == 0)
                      ? Colors.indigo[50]
                      : Colors.deepPurple[50],
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order id: ${order.sId}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("Date: ${Formatter.formatDate(order.createdOn!)}",
                            style: TextStyles.body2),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: order.items!.length,
                          itemBuilder: (context, index) {
                            final item = order.items![index];
                            final product = item.product!;

                            return Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CachedNetworkImage(
                                    imageUrl: product.images![0],
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text("${product.title}"),
                                  subtitle: Text("Qty: ${item.quantity}"),
                                  trailing: Text(
                                    Formatter.formatPrice(
                                        product.price! * item.quantity!),
                                  ),
                                ),
                                const Divider(
                                  height: 5,
                                  thickness: 1,
                                )
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status: ${order.status}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Total:  ₹${Formatter.formatPrice(Calculations.cartTotal(order.items!) as int)}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class AppColors {
  // Define your color constants here
}

// Define TextStyles, Formatter, and Calculations classes if not already defined
