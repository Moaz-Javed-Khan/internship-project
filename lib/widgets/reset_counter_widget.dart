import 'package:flutter/material.dart';

class ResetCounterWidget extends StatefulWidget {
  const ResetCounterWidget({
    super.key,
    required this.resetCounter,
  });
  final void Function() resetCounter;

  @override
  State<ResetCounterWidget> createState() => _ResetCounterWidgetState();
}

class _ResetCounterWidgetState extends State<ResetCounterWidget> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      // onPressed: widget.resetCounter,
      onPressed: () => showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text("Are you sure"),
            actions: [
              TextButton(
                child: const Text("Yes"),
                onPressed: () {
                  widget.resetCounter();
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
      ),
    );
  }
}
