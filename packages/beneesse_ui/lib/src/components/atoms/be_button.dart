import 'package:flutter/material.dart';

import 'be_button_style.dart';

/// Token-driven button with text, text+icon, or icon-only content modes.
class BeButton extends StatelessWidget {
  BeButton({
    required String label,
    super.key,
    this.onPressed,
    this.variant = BeButtonVariant.primary,
    this.size = BeButtonSize.md,
    this.icon,
    this.iconPosition = BeButtonIconPosition.leading,
    this.isLoading = false,
  })  : label = label,
        assert(label.isNotEmpty),
        _isIconOnly = false;

  const BeButton.icon({
    required this.icon,
    super.key,
    this.onPressed,
    this.variant = BeButtonVariant.primary,
    this.size = BeButtonSize.md,
    this.isLoading = false,
  })  : label = null,
        iconPosition = BeButtonIconPosition.leading,
        _isIconOnly = true;

  final String? label;
  final VoidCallback? onPressed;
  final BeButtonVariant variant;
  final BeButtonSize size;
  final IconData? icon;
  final BeButtonIconPosition iconPosition;
  final bool isLoading;
  final bool _isIconOnly;

  bool get _isIconOnlyMode => _isIconOnly || (label == null && icon != null);

  bool get _enabled => onPressed != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final metrics = BeButtonStyle.resolve(
      context,
      variant: variant,
      size: size,
      enabled: _enabled,
      isIconOnly: _isIconOnlyMode,
    );

    final borderRadius = BorderRadius.circular(metrics.borderRadius);
    final child = _buildChild(metrics);

    if (_isIconOnlyMode) {
      return SizedBox.square(
        dimension: metrics.height,
        child: _buildButtonContent(
          metrics: metrics,
          borderRadius: borderRadius,
          child: child,
        ),
      );
    }

    return SizedBox(
      height: metrics.height,
      child: _buildButtonContent(
        metrics: metrics,
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }

  Widget _buildButtonContent({
    required BeButtonMetrics metrics,
    required BorderRadius borderRadius,
    required Widget child,
  }) {
    return Material(
      color: metrics.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: metrics.borderColor != null
            ? BorderSide(
                color: metrics.borderColor!,
                width: metrics.borderWidth,
              )
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _enabled ? onPressed : null,
        borderRadius: borderRadius,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: metrics.horizontalPadding,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }

  Widget _buildChild(BeButtonMetrics metrics) {
    if (isLoading) {
      return SizedBox(
        width: metrics.iconSize,
        height: metrics.iconSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: metrics.foregroundColor,
        ),
      );
    }

    if (_isIconOnlyMode) {
      return Icon(
        icon,
        size: metrics.iconSize,
        color: metrics.foregroundColor,
      );
    }

    final labelWidget = Text(
      label!,
      style: metrics.labelStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    if (icon == null) {
      return labelWidget;
    }

    final iconWidget = Icon(
      icon,
      size: metrics.iconSize,
      color: metrics.foregroundColor,
    );

    final children = iconPosition == BeButtonIconPosition.leading
        ? <Widget>[
            iconWidget,
            SizedBox(width: metrics.iconGap),
            Flexible(child: labelWidget),
          ]
        : <Widget>[
            Flexible(child: labelWidget),
            SizedBox(width: metrics.iconGap),
            iconWidget,
          ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
