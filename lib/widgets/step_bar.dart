import 'package:flutter/material.dart';

class StepBar extends StatefulWidget {
  final int currentStep;
  final int totalSteps;
  final double width;
  final double height;
  final Color activeColor;
  final Color inactiveColor;

  const StepBar({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    this.width = 184,
    this.height = 13,
    this.activeColor = const Color(0xffA2E6FA),
    this.inactiveColor = const Color(0xff0D3A5C),
  }) : super(key: key);

  @override
  _StepBarState createState() => _StepBarState();
}

class _StepBarState extends State<StepBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stepWidth = widget.width / widget.totalSteps;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.totalSteps,
            (index) {
              final isCurrentStep = index == widget.currentStep;
              final stepColor = widget.inactiveColor;

              if (isCurrentStep) {
                if (index == 0) {
                  return Container(
                    decoration: BoxDecoration(
                      color: widget.inactiveColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                    ),
                    width: stepWidth,
                    child: Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: widget.activeColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  );
                } else if (index == widget.totalSteps - 1) {
                  return Container(
                    decoration: BoxDecoration(
                      color: widget.inactiveColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    width: stepWidth,
                    child: Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: widget.activeColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    decoration: BoxDecoration(
                      color: widget.inactiveColor,
                      // borderRadius: BorderRadius.circular(5),
                    ),
                    width: stepWidth,
                    child: Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: widget.activeColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  );
                }
              } else {
                if (index == 0) {
                  return SizedBox(
                    width: stepWidth,
                    child: Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: stepColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                    ),
                  );
                } else if (index == widget.totalSteps - 1) {
                  return SizedBox(
                    width: stepWidth,
                    child: Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: stepColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    width: stepWidth,
                    child: Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: stepColor,
                        borderRadius: const BorderRadius.only(),
                      ),
                    ),
                  );
                }
              }
            },
          ),
        );
      },
    );
  }
}





// import 'package:flutter/material.dart';

// class StepBar extends StatelessWidget {
//   final int currentStep;
//   final int maxSteps;
//   final double width;
//   final double height;
//   final Color activeColor;
//   final Color inactiveColor;

//   StepBar({
//     required this.currentStep,
//     required this.maxSteps,
//     this.width = 184,
//     this.height = 13,
//     this.activeColor = const Color(0xffA2E6FA),
//     this.inactiveColor = const Color(0xff0D3A5C),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         color: inactiveColor,
//         borderRadius: BorderRadius.all(Radius.circular(height / 2)),
//       ),
//       child: Stack(
//         children: <Widget>[
//           Container(
//             width: width / maxSteps * currentStep,
//             height: height,
//             decoration: BoxDecoration(
//               color: activeColor,
//               borderRadius: BorderRadius.all(Radius.circular(height / 2)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
