import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/tactical_widgets.dart';

class ModelCenterScreen extends StatefulWidget {
  const ModelCenterScreen({super.key});

  @override
  State<ModelCenterScreen> createState() => _ModelCenterScreenState();
}

class _ModelCenterScreenState extends State<ModelCenterScreen> {
  bool isShadowDryRun = false;
  bool isEvaluatingDrift = false;

  void _triggerDriftEvaluation() async {
    setState(() {
      isEvaluatingDrift = true;
    });

    await Future.delayed(const Duration(milliseconds: 900));

    if (mounted) {
      setState(() {
        isEvaluatingDrift = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.surfaceContainerHigh,
          content: Text(
            'Sampled 100k edge requests: Drift PSI 0.012 (Nominal, Zero Semantic Skew)',
            style: AppTypography.codeSm.copyWith(
              color: AppColors.tertiary,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      children: [
        // Top edge sync status
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
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
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '16/16 Edge Nodes Synced',
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.tertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.memory, size: 14, color: AppColors.primaryContainer),
                  const SizedBox(width: 5),
                  Text(
                    'TensorRT v8.6',
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Model Identity & Engine Card
        GlowCard(
          padding: const EdgeInsets.all(14),
          backgroundColor: AppColors.surfaceContainerLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.secondaryContainer.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          'RoBERTa-Custom',
                          style: AppTypography.codeSm.copyWith(
                            color: AppColors.secondary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.tertiary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          'LIVE PROD',
                          style: AppTypography.labelCaps.copyWith(
                            color: AppColors.tertiary,
                            fontWeight: FontWeight.w700,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'INT8 Quan 84.2 MB',
                      style: AppTypography.codeSm.copyWith(
                        color: AppColors.primaryFixed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Text(
                'SentinelBERT-CyberWAF',
                style: AppTypography.headlineSm.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'v4.2.0 • Fine-Tuned HTTP AST Syntax',
                style: AppTypography.codeSm.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.bolt, size: 16, color: AppColors.primaryContainer),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('RUNTIME', style: AppTypography.labelCaps),
                                Text(
                                  'ONNX 1.17 + CUDA',
                                  style: AppTypography.codeSm.copyWith(
                                    color: AppColors.onSurface,
                                    fontSize: 10.5,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.verified, size: 16, color: AppColors.tertiary),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('QUANT IMPACT', style: AppTypography.labelCaps),
                                Text(
                                  '0.00% Loss',
                                  style: AppTypography.codeSm.copyWith(
                                    color: AppColors.onSurface,
                                    fontSize: 10.5,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Bento 2x2 ML Performance Matrix
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'EVALUATION METRICS (HOLDOUT VAL)',
              style: AppTypography.labelCaps.copyWith(
                letterSpacing: 1.0,
              ),
            ),
            Text(
              'AUROC 0.998',
              style: AppTypography.codeSm.copyWith(
                color: AppColors.tertiary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.6,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: const [
            _MLMetricTile(
              title: 'Precision',
              icon: Icons.track_changes,
              iconColor: AppColors.primaryContainer,
              value: '99.41',
              unit: '%',
              subText: 'False positive shield',
              color: AppColors.primaryContainer,
            ),
            _MLMetricTile(
              title: 'Recall',
              icon: Icons.filter_alt,
              iconColor: AppColors.secondary,
              value: '98.92',
              unit: '%',
              subText: 'Polyglot payload trap',
              color: AppColors.secondary,
            ),
            _MLMetricTile(
              title: 'F1-Score',
              icon: Icons.balance,
              iconColor: AppColors.tertiary,
              value: '99.16',
              unit: '%',
              subText: 'Harmonic mean stability',
              color: AppColors.tertiary,
            ),
            _MLMetricTile(
              title: 'False Positive',
              icon: Icons.verified_user,
              iconColor: AppColors.primaryFixedDim,
              value: '0.04',
              unit: '%',
              subText: '<0.1% SLA Target',
              color: AppColors.tertiary,
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Edge Inference Latency Stream
        GlowCard(
          padding: const EdgeInsets.all(14),
          backgroundColor: AppColors.surfaceContainerLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.speed, size: 18, color: AppColors.primaryContainer),
                      const SizedBox(width: 8),
                      Text(
                        'Edge Inference Latency',
                        style: AppTypography.headlineSm.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      'Realtime P50/P99',
                      style: AppTypography.codeSm.copyWith(
                        color: AppColors.primaryFixed,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _LatencyBox(
                      label: 'P50 MEDIAN',
                      value: '2.8',
                      unit: 'ms / req',
                      valueColor: AppColors.tertiary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _LatencyBox(
                      label: 'P99 TAIL',
                      value: '5.1',
                      unit: 'ms / req',
                      valueColor: AppColors.primaryContainer,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: _LatencyBox(
                      label: 'PEAK SPIKE',
                      value: '8.4',
                      unit: 'ms / req',
                      valueColor: AppColors.secondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Live Cumulative Queries & Sparkline
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('24H CUMULATIVE QUERIES', style: AppTypography.labelCaps),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              '42,910,240',
                              style: AppTypography.codeMd.copyWith(
                                color: AppColors.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '(+4.8%)',
                              style: AppTypography.codeSm.copyWith(
                                color: AppColors.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 80,
                      height: 28,
                      child: CustomPaint(
                        painter: MicroSparklinePainter(strokeColor: AppColors.primaryContainer),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Visual Benchmark: Model vs RegEx Engine
        GlowCard(
          padding: const EdgeInsets.all(14),
          backgroundColor: AppColors.surfaceContainerLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.compare_arrows, size: 18, color: AppColors.secondary),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Transformer vs RegEx Engine',
                            style: AppTypography.headlineSm.copyWith(
                              color: AppColors.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Empirical validation against ModSecurity CRS',
                            style: AppTypography.codeSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      '+55.7% Lift',
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.onSecondaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // Metric 1: Obfuscated Payloads
              _BenchmarkRow(
                title: 'Obfuscated & Polyglot Payloads',
                metricText: '97.8% vs 42.1%',
                modelValue: 0.978,
                regexValue: 0.421,
                modelColor: AppColors.primaryContainer,
              ),
              const SizedBox(height: 12),

              // Metric 2: Zero-Day Anomaly Generalization
              _BenchmarkRow(
                title: 'Zero-Day Anomaly Generalization',
                metricText: '91.4% vs 18.6%',
                modelValue: 0.914,
                regexValue: 0.186,
                modelColor: AppColors.secondary,
              ),
              const SizedBox(height: 12),

              // Metric 3: False Positive Noise Ratio
              _BenchmarkRow(
                title: 'False Positive Noise Ratio',
                metricText: '0.04% vs 0.82%',
                modelValue: 0.05,
                regexValue: 0.82,
                modelColor: AppColors.tertiary,
                isLowerBetter: true,
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Corpus & Drift Guard
        GlowCard(
          padding: const EdgeInsets.all(14),
          backgroundColor: AppColors.surfaceContainerLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.dataset, size: 18, color: AppColors.primaryContainer),
                      const SizedBox(width: 8),
                      Text(
                        'Corpus & Drift Guard',
                        style: AppTypography.headlineSm.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.tertiary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      'DRIFT: STABLE',
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.tertiary,
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
                  Text('CORPUS SIZE', style: AppTypography.labelCaps),
                  Text(
                    '14.8M Sanitized Payloads',
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Wrap(
                spacing: 6,
                children: ['CSIC-2010', 'CIC-IDS2017', 'SOC-Honeypots-v4'].map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      tag,
                      style: AppTypography.codeSm.copyWith(
                        color: AppColors.secondaryFixed,
                        fontSize: 10.5,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CONCEPT DRIFT PSI', style: AppTypography.labelCaps),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                '0.012',
                                style: AppTypography.metricDisplay.copyWith(
                                  fontSize: 18,
                                  color: AppColors.tertiary,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text('(< 0.10)', style: AppTypography.codeSm),
                            ],
                          ),
                          Text('Zero semantic skew',
                              style: AppTypography.labelCaps
                                  .copyWith(color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('RETRAIN CHECKPOINT', style: AppTypography.labelCaps),
                          const SizedBox(height: 2),
                          Text(
                            '72h Ago',
                            style: AppTypography.metricDisplay.copyWith(
                              fontSize: 18,
                              color: AppColors.onSurface,
                            ),
                          ),
                          Text('GitOps Auto-Pipeline',
                              style: AppTypography.labelCaps
                                  .copyWith(color: AppColors.primaryContainer)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // Cluster ML Governance Actions
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'CLUSTER ML GOVERNANCE ACTIONS',
            style: AppTypography.labelCaps.copyWith(letterSpacing: 1.0),
          ),
        ),

        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.surfaceContainerHigh),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.visibility_off,
                      size: 16,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shadow / Dry-Run',
                        style: AppTypography.bodyMd.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                      ),
                      Text(
                        'Passive inference (No drop actions)',
                        style: AppTypography.codeSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Switch(
                value: isShadowDryRun,
                activeThumbColor: AppColors.primaryContainer,
                onChanged: (val) {
                  setState(() {
                    isShadowDryRun = val;
                  });
                },
              ),
            ],
          ),
        ),

        Material(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: isEvaluatingDrift ? null : _triggerDriftEvaluation,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.surfaceContainerHigh),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: isEvaluatingDrift
                            ? const Center(
                                child: SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primaryContainer,
                                  ),
                                ),
                              )
                            : const Icon(
                                Icons.refresh,
                                size: 18,
                                color: AppColors.primaryContainer,
                              ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trigger Drift Evaluation',
                            style: AppTypography.bodyMd.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.onSurface,
                            ),
                          ),
                          Text(
                            'Sample 100k requests against baseline',
                            style: AppTypography.codeSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: AppColors.outline,
                  ),
                ],
              ),
            ),
          ),
        ),

        Material(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.surfaceContainerHigh,
                  content: Text(
                    'ONNX Package Downloaded: SentinelBERT-v4.2-quant.onnx (84.2 MB)',
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.tertiary,
                    ),
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.surfaceContainerHigh),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.download,
                          size: 18,
                          color: AppColors.tertiary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Download ONNX Model Package',
                            style: AppTypography.bodyMd.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.onSurface,
                            ),
                          ),
                          Text(
                            'SHA256: 7f3a8b...9c41 (Signed)',
                            style: AppTypography.codeSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.check_circle_outline,
                    size: 18,
                    color: AppColors.tertiary,
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

class _MLMetricTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String value;
  final String unit;
  final String subText;
  final Color color;

  const _MLMetricTile({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.unit,
    required this.subText,
    required this.color,
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
              Text(title, style: AppTypography.labelCaps),
              Icon(icon, size: 15, color: iconColor),
            ],
          ),
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
              const SizedBox(width: 2),
              Text(
                unit,
                style: AppTypography.codeSm.copyWith(
                  color: color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          Text(
            subText,
            style: AppTypography.codeSm.copyWith(
              color: AppColors.outline,
              fontSize: 10,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _LatencyBox extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final Color valueColor;

  const _LatencyBox({
    required this.label,
    required this.value,
    required this.unit,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(label, style: AppTypography.labelCaps),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTypography.metricDisplay.copyWith(
              fontSize: 20,
              color: valueColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            unit,
            style: AppTypography.codeSm.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: 9.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _BenchmarkRow extends StatelessWidget {
  final String title;
  final String metricText;
  final double modelValue;
  final double regexValue;
  final Color modelColor;
  final bool isLowerBetter;

  const _BenchmarkRow({
    required this.title,
    required this.metricText,
    required this.modelValue,
    required this.regexValue,
    required this.modelColor,
    this.isLowerBetter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTypography.codeSm.copyWith(
                color: AppColors.onSurface,
              ),
            ),
            Text(
              metricText,
              style: AppTypography.codeSm.copyWith(
                color: isLowerBetter ? AppColors.tertiary : modelColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: Container(
            height: 10,
            color: AppColors.surfaceContainer,
            child: Row(
              children: [
                Expanded(
                  flex: (modelValue * 1000).toInt(),
                  child: Container(color: modelColor),
                ),
                Expanded(
                  flex: (regexValue * 1000).toInt(),
                  child: Container(
                    color: isLowerBetter
                        ? AppColors.error
                        : AppColors.outlineVariant,
                  ),
                ),
                Expanded(
                  flex: (1000 - ((modelValue + regexValue) * 500)).toInt().clamp(0, 1000),
                  child: const SizedBox(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: modelColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  isLowerBetter ? '20x Lower False Alarm Rate' : 'SentinelBERT',
                  style: AppTypography.labelCaps.copyWith(
                    color: isLowerBetter ? AppColors.tertiary : AppColors.outline,
                    fontSize: 8.5,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: isLowerBetter ? AppColors.error : AppColors.outlineVariant,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  isLowerBetter ? '0.82% Legacy Friction' : 'RegEx Core',
                  style: AppTypography.labelCaps.copyWith(
                    color: isLowerBetter ? AppColors.error : AppColors.outline,
                    fontSize: 8.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
