import 'package:fluent_ui/fluent_ui.dart';

/// Color de superficie semi-transparente para tarjetas sobre fondo cristal.
Color glassSurface(BuildContext context, {double alpha = 0.55}) {
  final dark = FluentTheme.of(context).brightness == Brightness.dark;
  final base = dark ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  return base.withValues(alpha: alpha);
}

/// Borde sutil para tarjetas sobre fondo cristal.
Border glassBorder(BuildContext context, {double alpha = 0.10}) {
  final dark = FluentTheme.of(context).brightness == Brightness.dark;
  final base = dark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
  return Border.all(color: base.withValues(alpha: alpha));
}

/// Tarjeta con estilo "cristal" (vidrio esmerilado) adaptable al tema.
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final double alpha;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.radius = 10,
    this.alpha = 0.55,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: glassSurface(context, alpha: alpha),
        borderRadius: BorderRadius.circular(radius),
        border: glassBorder(context),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.10),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
