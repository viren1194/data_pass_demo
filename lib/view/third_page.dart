import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                PromptListBottomSheet(context);
              },
              child: Text("data")),
        ));
  }
}

PromptListBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    context: context,
    builder: (context) => DraggableScrollableSheet(
        initialChildSize: calculateInitialChildSize(context), //        0.3
        maxChildSize: 0.9,
        minChildSize: 0.1,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.amber,
                ),
                child: Text(
                  "Lorem ipsum dolor sit amet",
                  style: TextStyle(fontSize: 30),
                )),
          );
        }),
  );
}

// double calculateInitialChildSize(BuildContext context) {
//   final textHeight = calculateTextHeight(context);
//   return textHeight / MediaQuery.of(context).size.height;

// }

double calculateInitialChildSize(BuildContext context) {
  final textHeight = calculateTextHeight(context);
  final maxHeight =
      MediaQuery.of(context).size.height * 0.9; // Max allowed height
  final initialSize = textHeight / maxHeight;
  print('textHeight ===$textHeight');
  print('maxHeight ===$maxHeight');
  print('initialSize===> $initialSize');
  return initialSize > 0.9 ? 0.9 : initialSize; // Limit it to the maxChildSize
}

double calculateTextHeight(BuildContext context) {
  final text = "Lorem ipsum dolor sit amet";

  final textPainter = TextPainter(
    text: TextSpan(
      text: Text(
                  "Lorem ipsum dolor sit amet",
                  style: TextStyle(fontSize: 30),
                ),
      style: DefaultTextStyle.of(context).style,
    ),
    maxLines: null,
    textDirection: ui.TextDirection.ltr,
  )..layout(
      maxWidth: MediaQuery.of(context).size.width - 20); // Adjust for padding

  return textPainter.height;
}
