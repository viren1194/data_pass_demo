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
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                CommonTextfield(
                  controller: nameController,
                  text: "Name",
                  suffixIcon: InkWell(
                    onTap: () {
                      nameController.clear();
                    },
                    child: const Icon(Icons.close),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonTextfield(
                  controller: emailController,
                  text: "Email",
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Get.to(SecondPage(
                      email: emailController.text,
                      name: nameController.text,
                    ));
                  },
                  child: const Text("Next"),
                ),
              ],
            ),
          ),
        ],
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
