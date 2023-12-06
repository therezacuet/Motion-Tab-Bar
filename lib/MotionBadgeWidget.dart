import 'package:flutter/material.dart';

class MotionBadgeWidget extends StatelessWidget {
  const MotionBadgeWidget({
    Key? key,
    bool? isIndicator,
    this.text,
    Color? textColor,
    double? size,
    Color? color,
    bool? disabled,
    bool? show,
  })  : this._isIndicator = isIndicator ?? false,
        this._color = color ?? Colors.red,
        this._textColor = textColor ?? Colors.white,
        this._size = size ?? (isIndicator == true ? 5 : 18),
        this._disabled = disabled ?? false,
        this._show = show != null ? show : true,
        assert(text != null ? text.length <= 3 : true),
        super(key: key);

  final bool? _isIndicator;
  final String? text;
  final Color? _color;
  final Color? _textColor;
  final double? _size;
  final bool? _disabled;
  final bool? _show;

  @override
  Widget build(BuildContext context) {
    return _show == true && _isIndicator == true
        ? Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(3),
      margin: EdgeInsets.all(7),
      decoration: new BoxDecoration(
        color: _disabled == false ? _color : _color!.withOpacity(0.6),
        borderRadius: BorderRadius.circular(_size! / 2),
      ),
      constraints: BoxConstraints(
        minWidth: _size!,
        minHeight: _size!,
      ),
    )
        : _show == true && text != null && text != ''
        ? Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(3),
      decoration: new BoxDecoration(
        color: _disabled == false ? _color : _color!.withOpacity(0.6),
        borderRadius: BorderRadius.circular(_size! / 2),
      ),
      constraints: BoxConstraints(
        minWidth: _size!,
        minHeight: _size!,
      ),
      child: Text(
        '$text',
        style: TextStyle(
          color: _textColor,
          fontSize: _size != null ? (_size! / 2) : 9,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        textAlign: TextAlign.center,
      ),
    )
        : Container();
  }
}