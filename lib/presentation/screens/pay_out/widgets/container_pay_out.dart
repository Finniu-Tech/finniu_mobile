import 'package:flutter/material.dart';

class ContainerPayOut extends StatelessWidget {
  const ContainerPayOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const int backgroundColor = 0xffE9FAFF;
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 255,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(backgroundColor),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
