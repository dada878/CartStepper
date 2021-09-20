library cart_stepper;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartStepper<VM extends num> extends StatefulWidget {
  final VM _count;
  final VM _stepper;
  final double size;
  final double numberSize;
  final Axis axis;
  final Color? activeForegroundColor;
  final Color? activeBackgroundColor;
  final Color? deActiveForegroundColor;
  final Color? deActiveBackgroundColor;
  final void Function(VM count) didChangeCount;
  final double elevation;
  final BoxShape? shape;
  final Radius? radius;
  final Color? shadowColor;

  const CartStepper({
    Key? key,
    VM? count,
    VM? stepper,
    required this.didChangeCount,
    this.activeForegroundColor,
    this.activeBackgroundColor,
    this.deActiveForegroundColor,
    this.deActiveBackgroundColor,
    this.size = 30.0,
    this.axis = Axis.horizontal,
    this.numberSize = 2,
    this.elevation = 2,
    this.shape,
    this.radius,
    this.shadowColor,
  })  : _count = (count ?? 0) as VM,
        _stepper = (stepper ?? 1) as VM,
        super(key: key);
  @override
  State<CartStepper<VM>> createState() => _CartStepperState<VM>();
}

class _CartStepperState<VM extends num> extends State<CartStepper<VM>> {
  bool _editMode = false;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget._count.toString())
      ..addListener(() {});
    _focusNode = FocusNode();
  }

  VM parseValue(String text) {
    double? value = double.tryParse(text);
    if (value == null) return widget._count;
    if (value is VM) return value as VM;
    return value.toInt() as VM;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final afColor = widget.activeForegroundColor ?? colorScheme.onPrimary;
    final abColor = widget.activeBackgroundColor ?? colorScheme.primary;
    final dfColor = widget.deActiveForegroundColor ?? colorScheme.onSurface;
    final dbColor = widget.deActiveBackgroundColor ?? colorScheme.surface;

    List<Widget> childs = [
      Expanded(
        child: IconButton(
          iconSize: widget.size * 0.6,
          padding: EdgeInsets.all(widget.size * 0.2),
          icon: Icon(
            Icons.add,
            color: widget._count > 0 ? afColor : dfColor,
          ),
          onPressed: () {
            widget.didChangeCount((widget._count + widget._stepper) as VM);
          },
        ),
      ),
    ];
    if (widget._count > 0) {
      childs.add(
        Container(
          alignment: Alignment.center,
          width: widget.axis == Axis.vertical
              ? widget.size
              : widget.size * widget.numberSize * .5,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _editMode = !_editMode;
                _focusNode.requestFocus();
              });
            },
            child: _editMode
                ? EditableText(
                    controller: _controller,
                    focusNode: _focusNode,
                    style: TextStyle(color: afColor),
                    cursorColor: afColor,
                    backgroundCursorColor: abColor,
                    onEditingComplete: () {
                      widget.didChangeCount(parseValue(_controller.text));
                      setState(() {
                        _editMode = false;
                      });
                    })
                : Text(
                    widget._count.toString(),
                    softWrap: false,
                    style: TextStyle(
                      color: afColor,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Quicksand",
                      fontStyle: FontStyle.normal,
                      fontSize: widget.size * 0.5,
                    ),
                  ),
          ),
        ),
      );
      childs.add(Expanded(
        child: IconButton(
          iconSize: widget.size * 0.6,
          padding: EdgeInsets.all(widget.size * 0.2),
          icon: Icon(
            Icons.remove,
            color: afColor,
          ),
          onPressed: () {
            if (widget._count > 0) {
              widget.didChangeCount((widget._count - widget._stepper) as VM);
            }
          },
        ),
      ));
    }

    double width = widget.size;
    double height = width;
    if (widget._count > 0) {
      if (widget.axis == Axis.vertical) {
        height *= 2 + widget.numberSize * .5;
      } else {
        width *= 2 + widget.numberSize * .5;
      }
    }

    return AnimatedPhysicalModel(
      shape: widget.shape ?? BoxShape.rectangle,
      borderRadius: BorderRadius.all(widget.radius ?? Radius.circular(height)),
      shadowColor: widget.shadowColor ?? const Color.fromARGB(255, 0, 0, 0),
      color: widget._count != 0 ? abColor : dbColor,
      elevation: widget.elevation,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
      child: SizedBox(
        width: width,
        height: height,
        child: widget.axis == Axis.vertical
            ? Column(
                children: childs,
              )
            : Row(
                children: childs.reversed.toList(),
              ),
      ),
    );
  }
}

typedef CartStepperInt = CartStepper<int>;
typedef CartStepperDouble = CartStepper<double>;
