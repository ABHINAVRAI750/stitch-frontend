import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/tactical_widgets.dart';

class OverviewScreen extends StatefulWidget {
  final VoidCallback onViewAllThreats;
  final Function(String ip, String path, String threatTitle) onInspectPayload;

  const OverviewScreen({
    super.key,
    required this.onViewAllThreats,
    required this.onInspectPayload,
  });

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  String selectedTimeRange = '1h';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      children: [
        // 1. Status Banner: WAF Engine State
        GlowCard(
          padding: const EdgeInsets.all(14),
          backgroundColor: AppColors.surfaceContainer,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: AppColors.tertiary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.tertiary,
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'TRANSFORMER V4.2 ACTIVE',
                        style: AppTypography.labelCaps.copyWith(
                          color: AppColors.primaryContainer,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.errorContainer.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(
                        color: AppColors.error.withValues(alpha: 0.4),
                        width: 0.8,
                      ),
                    ),
                    child: Text(
                      'ENFORCING / BLOCKING',
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.memory,
                        size: 15,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'ONNX Runtime INT8',
                        style: AppTypography.codeSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.hub,
                        size: 15,
                        color: AppColors.tertiary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'US-EAST-EDGE-01',
                        style: AppTypography.codeSm.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // 2. Bento 2-Column KPI Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.6,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: const [
            BentoKpiCard(
              title: 'Total Volume',
              icon: Icons.data_usage,
              iconColor: AppColors.primaryContainer,
              value: '1,429,812',
              trendText: '+12.4% vs hr',
              trendIcon: Icons.trending_up,
              trendColor: AppColors.tertiary,
            ),
            BentoKpiCard(
              title: 'Threats Found',
              icon: Icons.gpp_maybe,
              iconColor: AppColors.error,
              value: '3,842',
              trendText: '+4.2% SQLi spike',
              trendIcon: Icons.warning_amber,
              trendColor: AppColors.error,
            ),
            BentoKpiCard(
              title: 'Mitigated',
              icon: Icons.shield,
              iconColor: AppColors.tertiary,
              value: '3,719',
              trendText: '96.8% auto-drop',
              trendColor: AppColors.tertiary,
            ),
            BentoKpiCard(
              title: 'Suspect Hosts',
              icon: Icons.smart_toy_outlined,
              iconColor: AppColors.secondary,
              value: '428',
              trendText: 'Botnet swarm tracing',
              trendColor: AppColors.onSurfaceVariant,
            ),
            BentoKpiCard(
              title: 'Live Rate',
              icon: Icons.speed,
              iconColor: AppColors.primaryContainer,
              value: '8,420',
              unit: 'rps',
              trendText: 'Peak: 11.2k rps',
              trendColor: AppColors.primaryFixed,
            ),
            BentoKpiCard(
              title: 'Infer Latency',
              icon: Icons.timer_outlined,
              iconColor: AppColors.tertiary,
              value: '3.8',
              unit: 'ms',
              trendText: 'Quantized INT8 edge',
              trendColor: AppColors.tertiary,
            ),
          ],
        ),

        const SizedBox(height: 12),

        // 3. Traffic Telemetry Wave Chart
        GlowCard(
          padding: const EdgeInsets.all(14),
          backgroundColor: AppColors.surfaceContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Traffic Telemetry',
                        style: AppTypography.headlineSm.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Layer 7 ingress vs anomaly rate',
                        style: AppTypography.codeSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: ['15m', '1h', '24h', '7d'].map((range) {
                        final isSelected = selectedTimeRange == range;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedTimeRange = range;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryContainer
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              range,
                              style: AppTypography.codeSm.copyWith(
                                color: isSelected
                                    ? AppColors.onPrimaryContainer
                                    : AppColors.onSurfaceVariant,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                fontSize: 10.5,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Legend
              Row(
                children: [
                  _ChartLegendItem(
                    color: AppColors.primaryContainer,
                    label: 'Allowed (97.4%)',
                  ),
                  const SizedBox(width: 14),
                  _ChartLegendItem(
                    color: AppColors.secondary,
                    label: 'Suspect (2.3%)',
                  ),
                  const SizedBox(width: 14),
                  _ChartLegendItem(
                    color: AppColors.error,
                    label: 'Drop (0.3%)',
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Chart Area with Callout Annotation
              Stack(
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
                        width: 0.8,
                      ),
                    ),
                    child: const TelemetryWaveChart(height: 144),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceBright.withValues(alpha: 0.95),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.error.withValues(alpha: 0.5),
                            width: 0.8,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Spike 14:22 UTC: 11.2k rps',
                              style: AppTypography.codeSm.copyWith(
                                color: AppColors.error,
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('13:30', style: AppTypography.labelCaps),
                  Text('13:45', style: AppTypography.labelCaps),
                  Text('14:00',
                      style: AppTypography.labelCaps
                          .copyWith(color: AppColors.primaryContainer)),
                  Text('14:15', style: AppTypography.labelCaps),
                  Text('14:22 (Peak)',
                      style: AppTypography.labelCaps
                          .copyWith(color: AppColors.error)),
                  Text('14:30', style: AppTypography.labelCaps),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // 4. Attack Classification
        GlowCard(
          padding: const EdgeInsets.all(14),
          backgroundColor: AppColors.surfaceContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attack Classification',
                        style: AppTypography.headlineSm.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Top mitigated heuristic profiles',
                        style: AppTypography.codeSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      'TRANSFORMER CONFIDENCE 99.4%',
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.primaryContainer,
                        fontSize: 8.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const AttackProportionBar(),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // 5. Critical Interceptions Panel
        GlowCard(
          padding: const EdgeInsets.all(14),
          backgroundColor: AppColors.surfaceContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.crisis_alert,
                        size: 18,
                        color: AppColors.error,
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Critical Interceptions',
                            style: AppTypography.headlineSm.copyWith(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Live dropped payloads with attention scoring',
                            style: AppTypography.codeSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: widget.onViewAllThreats,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryContainer.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'VIEW ALL',
                        style: AppTypography.labelCaps.copyWith(
                          color: AppColors.primaryContainer,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _InterceptionTile(
                method: 'POST',
                ip: '185.220.101.5',
                asn: 'Tor Exit',
                riskScore: 'RISK 98/100',
                path: '/api/v1/auth/login ?payload=UNION+SELECT+1,...',
                statusDetail: 'BLOCKED • SQLi Pattern Match',
                timeAgo: '1.2s ago',
                onTap: () => widget.onInspectPayload(
                  '185.220.101.5',
                  '/api/v1/auth/login',
                  'SQL Injection Pattern Match',
                ),
              ),
              const SizedBox(height: 8),

              _InterceptionTile(
                method: 'GET',
                ip: '45.154.255.89',
                asn: 'AS49505',
                riskScore: 'RISK 89/100',
                path: '/products?search=<script>document.cookie...',
                statusDetail: 'BLOCKED • Script Tag Sanitized',
                timeAgo: '4.7s ago',
                onTap: () => widget.onInspectPayload(
                  '45.154.255.89',
                  '/products?search=<script>...',
                  'Cross-Site Scripting Injection',
                ),
              ),
              const SizedBox(height: 8),

              _InterceptionTile(
                method: 'GET',
                ip: '103.251.167.20',
                asn: 'AS133190',
                riskScore: 'RISK 94/100',
                path: '/../../../../etc/passwd (LFI probe)',
                statusDetail: 'BLOCKED • Canonical Path Reject',
                timeAgo: '12.1s ago',
                onTap: () => widget.onInspectPayload(
                  '103.251.167.20',
                  '/../../../../etc/passwd',
                  'Path Traversal Canonical Reject',
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // 6. Compact Cluster Health & Edge Workers
        GlowCard(
          padding: const EdgeInsets.all(14),
          backgroundColor: AppColors.surfaceContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.dns,
                        size: 16,
                        color: AppColors.tertiary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Edge Workers',
                        style: AppTypography.headlineSm.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.tertiary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '4 / 4 Nodes Active',
                        style: AppTypography.codeSm.copyWith(
                          color: AppColors.tertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _ClusterStatBox(
                      label: 'AVG CPU',
                      value: '24%',
                      subText: 'Nominal',
                      subTextColor: AppColors.tertiary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _ClusterStatBox(
                      label: 'MEMORY',
                      value: '48%',
                      subText: 'Cache 1.9G',
                      subTextColor: AppColors.primaryFixed,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _ClusterStatBox(
                      label: 'BACKLOG',
                      value: '0',
                      valueColor: AppColors.tertiary,
                      subText: '0.00ms delay',
                      subTextColor: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
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
                  _NodeStatusChip(nodeName: 'edge-va-01', status: 'OK'),
                  _NodeStatusChip(nodeName: 'edge-va-02', status: 'OK'),
                  _NodeStatusChip(nodeName: 'edge-nj-01', status: 'OK'),
                  _NodeStatusChip(nodeName: 'edge-ga-01', status: 'OK'),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

class _ChartLegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _ChartLegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: AppTypography.codeSm.copyWith(
            color: AppColors.onSurfaceVariant,
            fontSize: 10.5,
          ),
        ),
      ],
    );
  }
}

class _InterceptionTile extends StatelessWidget {
  final String method;
  final String ip;
  final String asn;
  final String riskScore;
  final String path;
  final String statusDetail;
  final String timeAgo;
  final VoidCallback onTap;

  const _InterceptionTile({
    required this.method,
    required this.ip,
    required this.asn,
    required this.riskScore,
    required this.path,
    required this.statusDetail,
    required this.timeAgo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
              width: 0.8,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          method,
                          style: AppTypography.labelCaps.copyWith(
                            color: AppColors.primaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        ip,
                        style: AppTypography.codeSm.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '($asn)',
                        style: AppTypography.labelCaps.copyWith(
                          color: AppColors.outline,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.errorContainer.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      riskScore,
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w700,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  path,
                  style: AppTypography.codeSm.copyWith(
                    color: AppColors.primaryFixed,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    statusDetail,
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    timeAgo,
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClusterStatBox extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final String subText;
  final Color subTextColor;

  const _ClusterStatBox({
    required this.label,
    required this.value,
    this.valueColor,
    required this.subText,
    required this.subTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label, style: AppTypography.labelCaps),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTypography.headlineSm.copyWith(
              color: valueColor ?? AppColors.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subText,
            style: AppTypography.labelCaps.copyWith(
              color: subTextColor,
              fontSize: 9.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _NodeStatusChip extends StatelessWidget {
  final String nodeName;
  final String status;

  const _NodeStatusChip({required this.nodeName, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            nodeName,
            style: AppTypography.codeSm.copyWith(
              color: AppColors.onSurface,
            ),
          ),
          Text(
            status,
            style: AppTypography.labelCaps.copyWith(
              color: AppColors.tertiary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
