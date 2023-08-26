import 'package:cart/core/ui.dart';
import 'package:cart/data/models/user/user_model.dart';
import 'package:cart/logic/cubits/cart_cubit/cart_cubit.dart';
import 'package:cart/logic/cubits/cart_cubit/cart_state.dart';
import 'package:cart/logic/cubits/order_cubit/order_cubit.dart';
import 'package:cart/logic/cubits/user_cubit/user_cubit.dart';
import 'package:cart/logic/cubits/user_cubit/user_state.dart';
import 'package:cart/presentation/screens/order/order_placed_screen.dart';
import 'package:cart/presentation/screens/order/provider/order_detail_provider.dart';
import 'package:cart/presentation/screens/ui/edit_profile_screen.dart';
import 'package:cart/presentation/widgets/primary_cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../widgets/order_list_view.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  static const routeName = "order_detail";

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Order",
          style: TextStyles.heading3,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is UserLoggedInState) {
                  UserModel user = state.userModel;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "User Details",
                              style: TextStyles.heading2,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, EditProfileScreen.routeName);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${user.fullName}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.heading3,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Email: ${user.email}",
                                      style: TextStyles.body2,
                                    ),
                                    Text(
                                      "Phone: ${user.phoneNumber}",
                                      style: TextStyles.body2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Address",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "${user.address}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.body2,
                                    ),
                                    Text(
                                      "${user.city}, ${user.state}",
                                      style: TextStyles.body2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Cart Items",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }
                return const SizedBox(height: 10);
              },
            ),
            BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                if (state is CartLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is CartErrorState) {
                  return Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  );
                }

                return OrderListView(
                  items: state.items,
                  shrinkWrap: true,
                  noScroll: true,
                );
              },
            ),
            Consumer<OrderDetailProvider>(
              builder: (context, provider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "Payment Method",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    RadioListTile(
                      value: "pay--delivery",
                      groupValue: provider.paymentMethod,
                      contentPadding: EdgeInsets.zero,
                      onChanged: provider.changePaymentMethod,
                      title: const Text("Pay on Delivery"),
                    ),
                    RadioListTile(
                      value: "pay-now",
                      groupValue: provider.paymentMethod,
                      contentPadding: EdgeInsets.zero,
                      onChanged: provider.changePaymentMethod,
                      title: const Text("Pay Now"),
                    ),
                    const SizedBox(height: 20),
                    PrimaryCartButton(
                      onPressed: () async {
                        bool sucess = await BlocProvider.of<OrderCubit>(context)
                            .createOrder(
                          items:
                              BlocProvider.of<CartCubit>(context).state.items,
                          paymentMethod: Provider.of<OrderDetailProvider>(
                                  context,
                                  listen: false)
                              .paymentMethod
                              .toString(),
                        );
                        if (sucess) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushNamed(
                              context, OrderPlacedScreen.routeName);
                        }
                      },
                      text: "Place Order",
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
