import 'package:data_pass_demo/view/second_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "https://tse1.mm.bing.net/th?id=OIP.HxV79tFMPfBAIo0BBF-sOgHaEy&pid=Api&rs=1&c=1&qlt=95&w=177&h=114",
      "https://tse1.mm.bing.net/th?id=OIP.E4IJcali_762Oo_vNhhbFgHaEK&pid=Api&P=0&h=180",
      "https://tse2.mm.bing.net/th?id=OIP.aj48y9KXH2xOZ46X9NvKJQHaEo&pid=Api&P=0&h=180",
      "https://tse1.mm.bing.net/th?id=OIP.YAXlTjvtEKchdMVc5laZhwHaE8&pid=Api&P=0&h=180"
    ];
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(SecondPage(
                images: images,
                index: index,
              ));
            },
            child: SizedBox(
              height: 400,
              width: 400,
              child: Image.network(
                images[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class CommonTextfield extends StatefulWidget {
  CommonTextfield(
      {Key? key, required this.controller, required this.text, this.suffixIcon})
      : super(key: key);

  final TextEditingController controller;
  final String text;
  Widget? suffixIcon;

  @override
  _CommonTextfieldState createState() => _CommonTextfieldState();
}

class _CommonTextfieldState extends State<CommonTextfield> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateSuffixIcon);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateSuffixIcon);
    super.dispose();
  }

  void _updateSuffixIcon() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: widget.text,
        suffixIcon:
            widget.controller.text.isNotEmpty ? widget.suffixIcon : null,
        // widget.controller.text.isNotEmpty
        //     ? InkWell(
        //         onTap: () {
        //           // print('999999999999999Clear');
        //           setState(() {
        //             widget.controller.clear();
        //           });
        //         },
        //         child: const Icon(Icons.close),
        //       )
        //     : const SizedBox.shrink(),
      ),
    );
  }
}
