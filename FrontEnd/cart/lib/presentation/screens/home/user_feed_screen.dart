import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
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
                  offset: Offset(0, 3), // changes the position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                  width: MediaQuery.of(context).size.width / 3.5,
                  imageUrl:
                      "https://s8ul.store/cdn/shop/files/FRONT_5d78bd71-9062-4d13-bd3a-f051e243a6fe.png?v=1691260302&width=823",
                ),
                SizedBox(width: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Title",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(
                      "Product Description",
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("₹ 999", style: TextStyle(fontSize: 30)),
                    SizedBox(
                      height: 10,
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
