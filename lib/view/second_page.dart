import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  List<String> images;
  int index;

  SecondPage({required this.images, required this.index});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: PageView.builder(
    
          itemCount: widget.images.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.network(
                widget.images[index],
                fit: BoxFit.fitHeight,
              ),
            );
          },
        ));
  }
}
