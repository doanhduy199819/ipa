import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class InterractionIcon extends StatefulWidget {
  const InterractionIcon(
      {Key? key,
      // this.activeIconData = Icons.arrow_upward_rounded,
      this.onTap,
      this.label,
      // this.activeColor = Colors.green,
      // this.unActiveColor = Colors.grey,
      this.isActive = false,
      this.onActiveChange,
      this.hasBackgroundDecoration = true,
      // this.size = 12.0,
      this.activeIcon,
      this.unActiveIcon,
      this.activeBackgroundColor = Colors.green,
      this.unActiveBackgroundColor = Colors.grey})
      : super(key: key);

  // final IconData? activeIconData;
  final Icon? activeIcon;
  final Icon? unActiveIcon;
  final String? label;
  final bool isActive;
  final bool hasBackgroundDecoration;
  final Color activeBackgroundColor;
  final Color unActiveBackgroundColor;
  // final double size;
  final void Function()? onTap;
  final void Function(bool)? onActiveChange;
  // final MaterialColor activeColor;
  // final MaterialColor unActiveColor;

  @override
  State<InterractionIcon> createState() => _InterractionIconState();
}

class _InterractionIconState extends State<InterractionIcon> {
  // late bool isActive;

  @override
  void initState() {
    // TODO: implement initState
    // isActive = widget.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'rebuild interraction icon ${widget.activeBackgroundColor.toString()}, state:${widget.isActive}');
    return InkWell(
      onTap: () => setState(() {
        widget.onTap != null ? widget.onTap!() : null;
        // isActive = !isActive;
        widget.onActiveChange != null
            ? widget.onActiveChange!(widget.isActive)
            : null;
      }),
      child: Container(
        decoration: widget.hasBackgroundDecoration
            ? BoxDecoration(
                color: widget.isActive
                    ? widget.activeBackgroundColor
                    : widget.unActiveBackgroundColor,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(width: 0.5, color: Colors.grey),
              )
            : null,
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              // padding: EdgeInsets.zero,
              // child: Icon(
              //   widget.activeIconData,
              //   color: isActive ? Colors.white : Colors.grey,
              //   size: widget.size,
              // ),
              child: widget.isActive ? widget.activeIcon : widget.unActiveIcon,
            ),
            if (widget.label != null)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  widget.label!.toString(),
                  style: widget.isActive
                      ? TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)
                      : null,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
