import 'package:flutter/material.dart';
import 'get_device_size.dart';


Widget MyTextField(TextEditingController textController, TextInputType keyBoardType, String hintText, String errorText){
  return TextFormField(
    autofocus: true,
      controller: textController,
      keyboardType: keyBoardType,
      // style: Theme.of(context).textTheme.headline6,
      validator: (value) {
        if (value!.isEmpty) {
          return errorText;
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
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
      ),
      onSaved: (value) {
        textController.text = value!;
  },
  );
}
//
// double screenWidth = 0.0;
//
// class MyTextField extends StatefulWidget {
//   final String? hintText;
//   final String? labelText;
//   final String? errorText;
//   final TextInputType? keyBoardType;
//   final TextEditingController textController;
//
//    MyTextField(
//       {Key? key,required this.textController, this.hintText, this.labelText, this.errorText, this.keyBoardType, }) : super(key: key);
//   @override
//   State<StatefulWidget> createState() => TextFieldState();
// }
// class TextFieldState extends State<MyTextField>{
//   @override
//   Widget build(BuildContext context) {
//
//     final screenSize = GetDeviceSize.getDeviceSize(context);
//     screenWidth = screenSize.width;
//     String _inputValue = '';
//
//     return TextFormField(
//       autofocus: false,
//         controller: widget.textController,
//         keyboardType: widget.keyBoardType ?? TextInputType.text,
//         // style: Theme.of(context).textTheme.headline6,
//         validator: (value) {
//           if (value!.isEmpty) {
//             return widget.errorText;
//           }
//         },
//         onChanged: (value) => _inputValue = value,
//         decoration: InputDecoration(
//           labelText: widget.labelText,
//           hintText: widget.hintText,
//           // labelStyle: Theme.of(context).textTheme.headline6,
//           errorStyle: TextStyle(
//             color: Colors.red,
//             fontSize: 15.0,
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.all(Radius.circular(5.0)),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.black,
//               width: 2.0,
//             ),
//           ),
//         ));
//   }
// }
