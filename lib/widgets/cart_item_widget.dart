import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_project/cart/bloc/cart_bloc.dart';
import 'package:internship_project/models/cart_item_model.dart';
import 'package:internship_project/widgets/cart_card_footer_widget.dart';

class CartItemWidget extends StatefulWidget {
  const CartItemWidget({super.key, required this.item});

  final CartItemModel item;

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  int count = 0;

  void _incrementCounter() {
    setState(() {
      count += 1;
    });
    print("count $count");
  }

  void _decrementCounter() {
    setState(() {
      if (count > 0) {
        count -= 1;
      } else {
        final snackBar = SnackBar(
          content: const Text('Reached 0, can\'t decrement more'),
          backgroundColor: (Colors.black),
          action: SnackBarAction(
            label: 'dismiss',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    print("count $count");
  }

  void _resetCounter() {
    setState(() {
      count = 0;
    });
    print("count $count");
  }

  void _onChanged(value) {
    count = int.parse(value);
  }

  void newOnChanged(int? value) {
    if (value != null) {
      setState(() {
        count = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.item.product.id),
      background: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.grey, size: 40),
      ),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) =>
          context.read<CartBloc>().add(CartItemRemoved(widget.item.product.id)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 8,
        shadowColor: Colors.black26,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ColoredBox(
                color: Colors.black.withOpacity(0.01),
                child: Image.network(
                  widget.item.product.image,
                  height: 120,
                  width: 120,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${widget.item.product.name}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Subtotal: ${widget.item.subTotal.toStringAsFixed(2)} ${widget.item.product.price.currency}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    CartCardFooterWidget(
                      // decrementCounter: () => newOnChanged(count - 1),
                      decrementCounter: (widget.item.quantity <= 1)
                          ? () => showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text("Are you sure"),
                                    actions: [
                                      TextButton(
                                        child: const Text("Yes"),
                                        onPressed: () {
                                          context
                                              .read<CartBloc>()
                                              .add(CartItemRemoved(
                                                widget.item.product.id,
                                              ));
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("No"),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  );
                                },
                              )
                          : () => context
                              .read<CartBloc>()
                              .add(CartItemDecrement(widget.item.product.id)),
                      incrementCounter: () => context
                          .read<CartBloc>()
                          .add(CartItemIncrement(widget.item.product.id)),
                      // incrementCounter: () => newOnChanged(count + 1),
                      // resetCounter: () => newOnChanged(0),
                      removeItem: () => context
                          .read<CartBloc>()
                          .add(CartItemRemoved(widget.item.product.id)),
                      onChanged: (value) => newOnChanged(int.tryParse(value)),
                      count: widget.item.quantity,
                      maxItem: widget.item.product.maxItem,
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }
}












//OG code 
// Card(
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Image.asset(
//                 "assets/image.jpg",
//                 height: 85,
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//               ),
//               const SizedBox(height: 2),
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     // ignore: prefer_const_literals_to_create_immutables
//                     children: [
//                       Text(
//                         widget.item.product.name,
//                         style: const TextStyle(fontSize: 17),
//                       ),
//                       Text(
//                         widget.item.subTotal.toString(),
//                         style: const TextStyle(fontSize: 17),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     widget.item.quantity.toString(),
//                     style: const TextStyle(fontSize: 15, color: Colors.grey),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 2),
//               CartCardFooterWidget(
//                 // decrementCounter: () => newOnChanged(count - 1),
//                 decrementCounter: (widget.item.quantity <= 1)
//                     ? () => context
//                         .read<CartBloc>()
//                         .add(CartItemRemoved(widget.item.product.id))
//                     : () => context
//                         .read<CartBloc>()
//                         .add(CartItemDecrement(widget.item.product.id)),
//                 incrementCounter: () => context
//                     .read<CartBloc>()
//                     .add(CartItemIncrement(widget.item.product.id)),
//                 // incrementCounter: () => newOnChanged(count + 1),
//                 // resetCounter: () => newOnChanged(0),
//                 removeItem: () => context
//                     .read<CartBloc>()
//                     .add(CartItemRemoved(widget.item.product.id)),
//                 onChanged: (value) => newOnChanged(int.tryParse(value)),
//                 count: widget.item.quantity,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );