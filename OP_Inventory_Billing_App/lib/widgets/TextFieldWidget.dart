import 'package:flutter/material.dart';

import 'get_device_size.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final TextInputType? keyBoardType;
  final TextEditingController? textController;

   MyTextField(
      {Key? key, this.hintText, this.labelText, this.errorText, this.keyBoardType, this.textController}) : super(key: key);

  double screenWidth = 0.0;

  @override
  Widget build(BuildContext context) {

    final screenSize = GetDeviceSize.getDeviceSize(context);
    screenWidth = screenSize.width;

    return TextFormField(
        keyboardType: keyBoardType ?? TextInputType.text,
        // style: Theme.of(context).textTheme.headline6,
        controller: textController,
        validator: (value) {
          print(textController.toString());
          if (value!.isEmpty) {
            return errorText;
          }
        },
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          // labelStyle: Theme.of(context).textTheme.headline6,
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 15.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),
          ),
        ));
  }
}
