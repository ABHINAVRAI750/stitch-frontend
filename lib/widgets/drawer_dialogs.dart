import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DrawerDialogs {
  DrawerDialogs._();

  static void showNotifications(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(color: AppColors.surfaceContainerHigh),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.surfaceContainerHigh),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.notifications_active,
                            size: 20, color: AppColors.error),
                        const SizedBox(width: 8),
                        Text(
                          'Threat Alerts (14 New)',
                          style: AppTypography.headlineSm.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, size: 20, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(12),
                  children: const [
                    _AlertItem(
                      title: 'Critical SQLi Spike on /api/v1/auth/tokens',
                      time: '1.2s ago',
                      severity: 'CRITICAL',
                      ip: '185.220.101.5 (Tor Exit)',
                      color: AppColors.error,
                    ),
                    _AlertItem(
                      title: 'Polyglot PHP Shell Upload Intercepted',
                      time: '18s ago',
                      severity: 'HIGH',
                      ip: '194.26.29.112 (Known Botnet)',
                      color: AppColors.error,
                    ),
                    _AlertItem(
                      title: 'GraphQL Introspection Depth Anomaly > 8',
                      time: '45s ago',
                      severity: 'ELEVATED',
                      ip: '91.240.118.42 (NL Cloud)',
                      color: AppColors.secondary,
                    ),
                    _AlertItem(
                      title: 'Double-Encoded Path Traversal Attempt',
                      time: '2m ago',
                      severity: 'HIGH',
                      ip: '203.0.113.88 (Mobile Carrier US)',
                      color: AppColors.error,
                    ),
                    _AlertItem(
                      title: 'Rate Limit Threshold Exceeded (50 req/s)',
                      time: '5m ago',
                      severity: 'MEDIUM',
                      ip: '198.51.100.42 (Anonymous Proxy)',
                      color: AppColors.secondary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showPolicies(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainerLow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Row(
            children: [
              const Icon(Icons.policy, color: AppColors.primaryContainer),
              const SizedBox(width: 8),
              Text('Security Policies', style: AppTypography.headlineSm),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Active Edge Enforcement Rules:', style: AppTypography.codeSm),
              const SizedBox(height: 10),
              _PolicyCheckbox(title: 'Strict AST Token Syntax (RoBERTa v4.2)', isChecked: true),
              _PolicyCheckbox(title: 'OWASP Core Rule Set (CRS 3.3.4)', isChecked: true),
              _PolicyCheckbox(title: 'Zero-Day Heuristic Auto-Drop (>85 score)', isChecked: true),
              _PolicyCheckbox(title: 'Tor Exit Node Automated 24h Ban', isChecked: true),
              _PolicyCheckbox(title: 'GraphQL Depth Limit > 6 Challenge', isChecked: true),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: AppTypography.bodyMd.copyWith(color: AppColors.primaryContainer)),
            ),
          ],
        );
      },
    );
  }

  static void showBlockedSources(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainerLow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Row(
            children: [
              const Icon(Icons.block, color: AppColors.error),
              const SizedBox(width: 8),
              Text('Blocked Sources (Denylist)', style: AppTypography.headlineSm),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: const [
                _DenylistRow(ip: '185.220.101.5', reason: 'Tor Exit / SQLi', expires: '23h remaining'),
                _DenylistRow(ip: '194.26.29.112', reason: 'Botnet Shell Upload', expires: 'Permanent'),
                _DenylistRow(ip: '203.0.113.88', reason: 'Path Traversal', expires: '11h remaining'),
                _DenylistRow(ip: '45.154.255.89', reason: 'XSS Reflected Inject', expires: '18h remaining'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Done', style: AppTypography.bodyMd.copyWith(color: AppColors.primaryContainer)),
            ),
          ],
        );
      },
    );
  }

  static void showEventLogs(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainerLow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Row(
            children: [
              const Icon(Icons.receipt_long, color: AppColors.tertiary),
              const SizedBox(width: 8),
              Text('System Event Logs', style: AppTypography.headlineSm),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cluster: US-EAST-EDGE-01', style: AppTypography.labelCaps),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '[2026-10-11 14:38:12] INT8 Model loaded. Weights SHA verified.\\n'
                    '[2026-10-11 14:38:13] 16/16 edge nodes synced successfully.\\n'
                    '[2026-10-11 14:38:15] Intercepted 185.220.101.5 SQLi payload.\\n'
                    '[2026-10-11 14:38:19] Edge worker memory nominal (48%).',
                    style: AppTypography.codeSm.copyWith(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close', style: AppTypography.bodyMd.copyWith(color: AppColors.primaryContainer)),
            ),
          ],
        );
      },
    );
  }

  static void showSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainerLow,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Row(
            children: [
              const Icon(Icons.tune, color: AppColors.secondary),
              const SizedBox(width: 8),
              Text('System Settings', style: AppTypography.headlineSm),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Cluster Orchestration:', style: AppTypography.codeSm),
              const SizedBox(height: 8),
              Text('Version: Sentinel Ops v4.8.2-prod', style: AppTypography.bodySm),
              Text('Runtime: ONNX Runtime 1.17 + CUDA / TensorRT', style: AppTypography.bodySm),
              Text('Quantization: INT8 Tensor Cores', style: AppTypography.bodySm),
              Text('Telemetry Port: 9090 (gRPC mTLS)', style: AppTypography.bodySm),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK', style: AppTypography.bodyMd.copyWith(color: AppColors.primaryContainer)),
            ),
          ],
        );
      },
    );
  }
}

class _AlertItem extends StatelessWidget {
  final String title;
  final String time;
  final String severity;
  final String ip;
  final Color color;

  const _AlertItem({
    required this.title,
    required this.time,
    required this.severity,
    required this.ip,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  severity,
                  style: AppTypography.labelCaps.copyWith(color: color, fontWeight: FontWeight.w700),
                ),
              ),
              Text(time, style: AppTypography.codeSm.copyWith(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 4),
          Text(title, style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text('Source: $ip', style: AppTypography.codeSm.copyWith(color: AppColors.primaryFixed)),
        ],
      ),
    );
  }
}

class _PolicyCheckbox extends StatelessWidget {
  final String title;
  final bool isChecked;

  const _PolicyCheckbox({required this.title, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_box, size: 18, color: AppColors.primaryContainer),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: AppTypography.bodySm)),
        ],
      ),
    );
  }
}

class _DenylistRow extends StatelessWidget {
  final String ip;
  final String reason;
  final String expires;

  const _DenylistRow({required this.ip, required this.reason, required this.expires});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ip, style: AppTypography.codeSm.copyWith(color: AppColors.primaryContainer, fontWeight: FontWeight.w700)),
              Text(reason, style: AppTypography.labelCaps),
            ],
          ),
          Text(expires, style: AppTypography.codeSm.copyWith(color: AppColors.error, fontSize: 10)),
        ],
      ),
    );
  }
}
