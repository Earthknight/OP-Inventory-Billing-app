import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyDatePickerTextFormField extends StatefulWidget {

  final ValueChanged<DateTime> onDateChanged;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  TextEditingController dateController;
  final DateFormat? dateFormat;
  final FocusNode? focusNode;
  String? labelText;
  final String? hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;

  MyDatePickerTextFormField(
      {
        Key? key,
        this.labelText,
        this.hintText,
        this.prefixIcon,
        this.suffixIcon,
        this.focusNode,
        this.dateFormat,
        required this.lastDate,
        required this.firstDate,
        required this.initialDate,
        required this.onDateChanged, required this.dateController,
      }
      ):assert(initialDate != null),
        assert(firstDate != null),
        assert(lastDate != null),
        assert(!initialDate.isBefore(firstDate),
        'initialDate must be on or after firstDate'),
        assert(!initialDate.isAfter(lastDate),
        'initialDate must be on or before lastDate'),
        assert(!firstDate.isAfter(lastDate),
        'lastDate must be on or after firstDate'),
        assert(onDateChanged != null, 'onDateChanged must not be null'),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyDatePickerTextFormFieldState();
  }
}
class _MyDatePickerTextFormFieldState extends State<MyDatePickerTextFormField>{

  DateFormat _dateFormat= DateFormat('yyyy-MM-dd');
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.dateFormat != null) {
      _dateFormat = widget.dateFormat!;
    } else {
      _dateFormat = DateFormat.MMMEd();
    }

    _selectedDate = widget.initialDate;

    widget.dateController = TextEditingController();
    widget.dateController.text = _dateFormat.format(DateTime.now());
    // _dateFormat.format(_selectedDate)
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      focusNode: widget.focusNode,
      controller: widget.dateController,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        suffixIcon: widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,

          ),
        ),
        // prefixIcon: widget.prefixIcon,


      ),
      onTap: () {
        _selectDate(context);

      },
      readOnly: true,
    );

  }
  @override
  void dispose() {
    widget.dateController.dispose();
    super.dispose();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: widget.firstDate,
        lastDate: widget.lastDate,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Color(0xff17213e),
                onPrimary: Colors.white,
                surface: Color(0xff17213e),
                onSurface: Colors.white,
              ),
              // dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        });

    setState(() {
      _selectedDate = pickedDate!;
      widget.dateController.text = "${_selectedDate.toLocal()}".split(' ')[0];
    });
    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      print(_selectedDate.toString());
      widget.dateController.text = _dateFormat.format(_selectedDate);
      widget.onDateChanged(_selectedDate);
    }

    if (widget.focusNode != null) {
      widget.focusNode?.nextFocus();
    }
  }

}


class DateDropDown extends StatelessWidget {
  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget? child;

  const DateDropDown(
      {Key? key,
        required this.labelText,
        required this.valueText,
        required this.valueStyle,
        required this.onPressed,
         this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: InputDecorator(
        decoration: InputDecoration(labelText: labelText),
        baseStyle: valueStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              valueText,
              style: valueStyle,
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade700
                  : Colors.white70,
            )
          ],
        ),
      ),
    );
  }
}