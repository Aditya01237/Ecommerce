import 'package:cart/logic/cubits/category_cubit/category_cubit.dart';
import 'package:cart/presentation/screens/product/category_product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubits/category_cubit/category_state.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadingState && state.categories.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is CategoryErrorState && state.categories.isEmpty) {
          return Center(
            child: Text(state.message.toString()),
          );
        }

        return ListView.builder(
          itemCount: state.categories.length,
          itemBuilder: (context, index) {
            final category = state.categories[index];

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.indigo[100],
                  borderRadius:
                      BorderRadius.circular(10), // Adjust the radius as needed
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                          context, CategoryProductScreen.routeName,
                          arguments: category);
                    },
                    title: Text(
                      "${category.title}",
                      style: const TextStyle(fontSize: 25),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
