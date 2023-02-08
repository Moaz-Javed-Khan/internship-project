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
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: Colors.blue,
          width: 1,
        ),
      ),
      child: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: widget.resetCounter,
      ),
    );
  }
}
