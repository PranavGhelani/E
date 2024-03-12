import 'package:flutter/material.dart';

class CountingLabel extends StatefulWidget {
  final int startValue;
  final int endValue;
  final Duration duration;
  final TextStyle textStyle;

  CountingLabel({
    required this.startValue,
    required this.endValue,
    required this.duration,
    this.textStyle = const TextStyle(fontSize: 24.0),
  });

  @override
  _CountingLabelState createState() => _CountingLabelState();
}

class _CountingLabelState extends State<CountingLabel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = IntTween(
      begin: widget.startValue,
      end: widget.endValue,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _animation.value.toString(),
      style: widget.textStyle,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Example usage
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: CountingLabel(
            startValue: 0,
            endValue: 100,
            duration: Duration(seconds: 3),
            textStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}