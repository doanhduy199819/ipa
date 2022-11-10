import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class InterractionIcon extends StatefulWidget {
  const InterractionIcon(
      {Key? key,
      this.activeIconData = Icons.arrow_upward_rounded,
      this.onTap,
      this.label,
      this.activeColor = Colors.green,
      this.unActiveColor = Colors.grey,
      this.isActive = false})
      : super(key: key);

  final IconData? activeIconData;
  final String? label;
  final bool? isActive;
  final void Function()? onTap;
  final MaterialColor activeColor;
  final MaterialColor unActiveColor;

  @override
  State<InterractionIcon> createState() => _InterractionIconState();
}

class _InterractionIconState extends State<InterractionIcon> {
  @override
  Widget build(BuildContext context) {
    bool isActive = widget.isActive ?? false;

    return InkWell(
      onTap: () => setState(() {
        widget.onTap!();
        isActive = !isActive;
      }),
      child: Container(
        decoration: BoxDecoration(
          color: isActive
              ? widget.activeColor.shade300
              : widget.unActiveColor.shade300,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
              width: 0.5,
              color: isActive
                  ? widget.activeColor.shade500
                  : widget.unActiveColor.shade500),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              // padding: EdgeInsets.zero,
              child: Icon(
                widget.activeIconData,
                color: isActive ? Colors.white : Colors.grey,
                size: 12.0,
              ),
            ),
            if (widget.label != null)
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  widget.label!.toString(),
                  style: isActive
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
