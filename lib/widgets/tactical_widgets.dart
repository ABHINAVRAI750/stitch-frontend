import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlowCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final VoidCallback? onTap;
  final Color? glowColor;

  const GlowCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.backgroundColor = AppColors.surfaceContainerLow,
    this.borderColor,
    this.borderRadius = 12,
    this.onTap,
    this.glowColor,
  });

  @override
  Widget build(BuildContext context) {
    final border = Border.all(
      color: borderColor ?? AppColors.surfaceContainerHigh.withValues(alpha: 0.8),
      width: 1,
    );

    final boxDecoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: border,
      boxShadow: [
        if (glowColor != null)
          BoxShadow(
            color: glowColor!.withValues(alpha: 0.25),
            blurRadius: 12,
            spreadRadius: -2,
          )
        else
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
      ],
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: padding,
            decoration: boxDecoration,
            child: child,
          ),
        ),
      );
    }

    return Container(
      padding: padding,
      decoration: boxDecoration,
      child: child,
    );
  }
}

class StatusPill extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color backgroundColor;
  final Widget? leading;
  final EdgeInsetsGeometry padding;

  const StatusPill({
    super.key,
    required this.label,
    required this.textColor,
    required this.backgroundColor,
    this.leading,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: AppTypography.labelCaps.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class BentoKpiCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String value;
  final String? unit;
  final String trendText;
  final IconData? trendIcon;
  final Color trendColor;

  const BentoKpiCard({
    super.key,
    required this.title,
    required this.icon,
    this.iconColor = AppColors.primary,
    required this.value,
    this.unit,
    required this.trendText,
    this.trendIcon,
    this.trendColor = AppColors.tertiary,
  });

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      padding: const EdgeInsets.all(10),
      backgroundColor: AppColors.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: AppTypography.labelCaps.copyWith(
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 0.8,
                ),
              ),
              Icon(icon, size: 16, color: iconColor),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: AppTypography.metricDisplay.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
              ),
              if (unit != null) ...[
                const SizedBox(width: 3),
                Text(
                  unit!,
                  style: AppTypography.codeSm.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              if (trendIcon != null) ...[
                Icon(trendIcon, size: 14, color: trendColor),
                const SizedBox(width: 3),
              ],
              Expanded(
                child: Text(
                  trendText,
                  style: AppTypography.codeSm.copyWith(
                    color: trendColor,
                    fontSize: 10.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TelemetryWaveChart extends StatelessWidget {
  final double height;
  const TelemetryWaveChart({super.key, this.height = 160});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: WaveChartPainter(),
      ),
    );
  }
}

class WaveChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Grid lines
    final gridPaint = Paint()
      ..color = AppColors.surfaceContainerHigh.withValues(alpha: 0.5)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    for (int i = 1; i <= 3; i++) {
      final y = h * (i / 4);
      // Dashed line
      double startX = 0;
      while (startX < w) {
        canvas.drawLine(
          Offset(startX, y),
          Offset(startX + 4, y),
          gridPaint,
        );
        startX += 8;
      }
    }

    // 1. Cyan Allowed Area
    final cyanFill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.primaryContainer.withValues(alpha: 0.35),
          AppColors.primaryContainer.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    final cyanPath = Path();
    cyanPath.moveTo(0, h * 0.68);
    cyanPath.cubicTo(w * 0.15, h * 0.45, w * 0.25, h * 0.60, w * 0.35, h * 0.42);
    cyanPath.cubicTo(w * 0.45, h * 0.25, w * 0.50, h * 0.18, w * 0.55, h * 0.35);
    cyanPath.cubicTo(w * 0.65, h * 0.55, w * 0.75, h * 0.58, w * 0.85, h * 0.36);
    cyanPath.cubicTo(w * 0.92, h * 0.25, w * 0.96, h * 0.35, w, h * 0.50);
    cyanPath.lineTo(w, h);
    cyanPath.lineTo(0, h);
    cyanPath.close();
    canvas.drawPath(cyanPath, cyanFill);

    final cyanStroke = Paint()
      ..color = AppColors.primaryContainer
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final cyanStrokePath = Path();
    cyanStrokePath.moveTo(0, h * 0.68);
    cyanStrokePath.cubicTo(w * 0.15, h * 0.45, w * 0.25, h * 0.60, w * 0.35, h * 0.42);
    cyanStrokePath.cubicTo(w * 0.45, h * 0.25, w * 0.50, h * 0.18, w * 0.55, h * 0.35);
    cyanStrokePath.cubicTo(w * 0.65, h * 0.55, w * 0.75, h * 0.58, w * 0.85, h * 0.36);
    cyanStrokePath.cubicTo(w * 0.92, h * 0.25, w * 0.96, h * 0.35, w, h * 0.50);
    canvas.drawPath(cyanStrokePath, cyanStroke);

    // 2. Purple Suspicious Wave (Dashed)
    final purplePath = Path();
    purplePath.moveTo(0, h * 0.87);
    purplePath.cubicTo(w * 0.25, h * 0.82, w * 0.40, h * 0.68, w * 0.50, h * 0.60);
    purplePath.cubicTo(w * 0.60, h * 0.68, w * 0.75, h * 0.80, w, h * 0.84);

    final purpleStroke = Paint()
      ..color = AppColors.secondary
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawPath(purplePath, purpleStroke);

    // 3. Crimson Spike
    final crimsonFill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.error.withValues(alpha: 0.35),
          AppColors.error.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..style = PaintingStyle.fill;

    final crimsonPath = Path();
    crimsonPath.moveTo(0, h * 0.97);
    crimsonPath.lineTo(w * 0.44, h * 0.97);
    crimsonPath.lineTo(w * 0.48, h * 0.70);
    crimsonPath.lineTo(w * 0.50, h * 0.35); // Spike apex
    crimsonPath.lineTo(w * 0.52, h * 0.82);
    crimsonPath.lineTo(w * 0.56, h * 0.97);
    crimsonPath.lineTo(w, h * 0.97);
    crimsonPath.lineTo(w, h);
    crimsonPath.lineTo(0, h);
    crimsonPath.close();
    canvas.drawPath(crimsonPath, crimsonFill);

    final crimsonStroke = Paint()
      ..color = AppColors.error
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    final crimsonLine = Path();
    crimsonLine.moveTo(0, h * 0.97);
    crimsonLine.lineTo(w * 0.44, h * 0.97);
    crimsonLine.lineTo(w * 0.48, h * 0.70);
    crimsonLine.lineTo(w * 0.50, h * 0.35);
    crimsonLine.lineTo(w * 0.52, h * 0.82);
    crimsonLine.lineTo(w * 0.56, h * 0.97);
    crimsonLine.lineTo(w, h * 0.97);
    canvas.drawPath(crimsonLine, crimsonStroke);

    // Crosshair line at apex (x = w * 0.50)
    final crosshairPaint = Paint()
      ..color = AppColors.outline.withValues(alpha: 0.6)
      ..strokeWidth = 1.0;
    canvas.drawLine(
      Offset(w * 0.50, 10),
      Offset(w * 0.50, h),
      crosshairPaint,
    );

    // Points at apex
    final ptCyan = Paint()..color = AppColors.primaryContainer;
    final ptCrimson = Paint()..color = AppColors.error;
    final ptBorder = Paint()
      ..color = AppColors.surfaceContainerLowest
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(w * 0.50, h * 0.22), 3.5, ptCyan);
    canvas.drawCircle(Offset(w * 0.50, h * 0.22), 3.5, ptBorder);

    canvas.drawCircle(Offset(w * 0.50, h * 0.35), 3.5, ptCrimson);
    canvas.drawCircle(Offset(w * 0.50, h * 0.35), 3.5, ptBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AttackProportionBar extends StatelessWidget {
  const AttackProportionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: SizedBox(
            height: 12,
            child: Row(
              children: [
                Expanded(
                  flex: 41,
                  child: Container(color: AppColors.error),
                ),
                const SizedBox(width: 2),
                Expanded(
                  flex: 28,
                  child: Container(color: AppColors.primaryContainer),
                ),
                const SizedBox(width: 2),
                Expanded(
                  flex: 18,
                  child: Container(color: AppColors.secondary),
                ),
                const SizedBox(width: 2),
                Expanded(
                  flex: 13,
                  child: Container(color: AppColors.tertiary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 3.8,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: const [
            _AttackCategoryItem(
              color: AppColors.error,
              label: 'SQL Injection',
              percentage: '41%',
            ),
            _AttackCategoryItem(
              color: AppColors.primaryContainer,
              label: 'XSS Reflected',
              percentage: '28%',
            ),
            _AttackCategoryItem(
              color: AppColors.secondary,
              label: 'Path Traversal',
              percentage: '18%',
            ),
            _AttackCategoryItem(
              color: AppColors.tertiary,
              label: 'RCE / SSRF',
              percentage: '13%',
            ),
          ],
        ),
      ],
    );
  }
}

class _AttackCategoryItem extends StatelessWidget {
  final Color color;
  final String label;
  final String percentage;

  const _AttackCategoryItem({
    required this.color,
    required this.label,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.surfaceContainerHigh.withValues(alpha: 0.6),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTypography.codeSm.copyWith(
                  color: AppColors.onSurface,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          Text(
            percentage,
            style: AppTypography.codeSm.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class MicroSparklinePainter extends CustomPainter {
  final Color strokeColor;
  const MicroSparklinePainter({this.strokeColor = AppColors.primaryContainer});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path();
    path.moveTo(0, h * 0.7);
    path.cubicTo(w * 0.25, h * 0.8, w * 0.35, h * 0.6, w * 0.5, h * 0.4);
    path.cubicTo(w * 0.65, h * 0.7, w * 0.8, h * 0.6, w, h * 0.2);

    final fillPath = Path.from(path)
      ..lineTo(w, h)
      ..lineTo(0, h)
      ..close();

    final fillPaint = Paint()
      ..color = strokeColor.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    final strokePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, strokePaint);

    final dotPaint = Paint()..color = strokeColor;
    canvas.drawCircle(Offset(w, h * 0.2), 3, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
