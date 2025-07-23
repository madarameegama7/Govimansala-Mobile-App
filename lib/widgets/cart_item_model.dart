import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'dart:math';
import '../models/cart_item.dart';

class CartItemModelWidget extends StatelessWidget {
  const CartItemModelWidget({super.key, required this.item});

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final fakeName = "Product #${item.productId}";
    final fakeImage = "assets/images/default.jpg";
    final fakePrice = 999; // Replace with actual logic if needed

    return SizedBox(
      height: 125,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        elevation: 0.1,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                height: double.infinity,
                width: 90,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(fakeImage),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fakeName,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 5),
                    Text("Quantity: ${item.quantity}",
                        style: Theme.of(context).textTheme.bodySmall),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$$fakePrice",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                        ToggleButtons(
                          borderRadius: BorderRadius.circular(99),
                          constraints: const BoxConstraints(minHeight: 30, minWidth: 30),
                          isSelected: const [false, false, false],
                          onPressed: (index) {},
                          children: [
                            const Icon(Icons.remove, size: 20),
                            Text("${item.quantity}"),
                            const Icon(Icons.add, size: 20),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
