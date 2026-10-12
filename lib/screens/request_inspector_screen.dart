import 'package:flutter/material.dart';
import '../models/inspection_preset.dart';
import '../theme/app_theme.dart';
import '../widgets/tactical_widgets.dart';

class RequestInspectorScreen extends StatefulWidget {
  final String? initialIp;
  final String? initialPath;
  final String? initialPayload;

  const RequestInspectorScreen({
    super.key,
    this.initialIp,
    this.initialPath,
    this.initialPayload,
  });

  @override
  State<RequestInspectorScreen> createState() => _RequestInspectorScreenState();
}

class _RequestInspectorScreenState extends State<RequestInspectorScreen> {
  final List<InspectionPreset> presets = InspectionPreset.getPresets();
  late InspectionPreset activePreset;

  late String selectedMethod;
  late TextEditingController _endpointController;
  late TextEditingController _payloadController;
  bool isInferencing = false;
  int charCount = 0;

  @override
  void initState() {
    super.initState();
    activePreset = presets.first;
    selectedMethod = activePreset.method;
    _endpointController = TextEditingController(
      text: widget.initialPath ?? activePreset.endpoint,
    );
    _payloadController = TextEditingController(
      text: widget.initialPayload ?? activePreset.payload,
    );
    charCount = _payloadController.text.length;
  }

  @override
  void dispose() {
    _endpointController.dispose();
    _payloadController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RequestInspectorScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When "Open in Sandbox" is triggered from another tab, the parent
    // passes new initialIp/Path/Payload props. Since this widget lives in an
    // IndexedStack (state is preserved), we must update the controllers here.
    final newIp = widget.initialIp;
    final newPath = widget.initialPath;
    final newPayload = widget.initialPayload;
    final hasNewSandboxParams = newIp != null &&
        (newIp != oldWidget.initialIp ||
            newPath != oldWidget.initialPath ||
            newPayload != oldWidget.initialPayload);
    if (hasNewSandboxParams) {
      setState(() {
        if (newPath != null) {
          _endpointController.text = newPath;
        }
        if (newPayload != null) {
          _payloadController.text = newPayload;
          charCount = newPayload.length;
        }
        selectedMethod = 'POST';
      });
    }
  }

  void _applyPreset(InspectionPreset preset) {
    setState(() {
      activePreset = preset;
      selectedMethod = preset.method;
      _endpointController.text = preset.endpoint;
      _payloadController.text = preset.payload;
      charCount = preset.payload.length;
    });
  }

  void _runInference() async {
    setState(() {
      isInferencing = true;
    });

    await Future.delayed(const Duration(milliseconds: 600));

    if (mounted) {
      setState(() {
        isInferencing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.surfaceContainerHigh,
          content: Text(
            'Inference executed in ${activePreset.runtimeMs}ms. Verdict: ${activePreset.verdictName}',
            style: AppTypography.codeSm.copyWith(
              color: AppColors.primaryContainer,
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
        // Operational Sub-Header & Presets
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'INTERACTIVE SANDBOX',
                  style: AppTypography.labelCaps.copyWith(
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.tertiaryContainer.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.psychology,
                    size: 13,
                    color: AppColors.tertiary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'ONNX INT8 Edge',
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.tertiary,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Request Inspection',
              style: AppTypography.headlineSm.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: () => _applyPreset(presets.first),
              child: Row(
                children: [
                  const Icon(
                    Icons.restart_alt,
                    size: 15,
                    color: AppColors.outline,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Reset',
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.outline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Quick Fixture Presets Horizontal Slider
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: presets.map((p) {
              final isSelected = p.key == activePreset.key;
              IconData icon;
              if (p.key == 'sqli') {
                icon = Icons.bug_report;
              } else if (p.key == 'xss') {
                icon = Icons.code;
              } else if (p.key == 'log4j') {
                icon = Icons.dns;
              } else {
                icon = Icons.verified_user;
              }

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => _applyPreset(p),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryContainer.withValues(alpha: 0.2)
                          : AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryContainer.withValues(alpha: 0.5)
                            : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          icon,
                          size: 13,
                          color: isSelected
                              ? AppColors.primaryFixedDim
                              : AppColors.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          p.label,
                          style: AppTypography.codeSm.copyWith(
                            color: isSelected
                                ? AppColors.primaryFixedDim
                                : AppColors.onSurfaceVariant,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 12),

        // Interactive Request Crafting Deck
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
                        Icons.tune,
                        size: 15,
                        color: AppColors.primaryContainer,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'REQUEST BUILDER',
                        style: AppTypography.labelCaps.copyWith(
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'HTTP/2 Edge Target',
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Method buttons
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: ['POST', 'GET', 'PUT', 'DELETE'].map((m) {
                    final isM = selectedMethod == m;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMethod = m;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: isM
                              ? AppColors.primaryContainer
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          m,
                          style: AppTypography.codeSm.copyWith(
                            color: isM
                                ? AppColors.onPrimaryContainer
                                : AppColors.onSurfaceVariant,
                            fontWeight: isM ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 8),

              // Endpoint field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      '>_',
                      style: AppTypography.codeSm.copyWith(
                        color: AppColors.primaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _endpointController,
                        style: AppTypography.codeSm.copyWith(
                          color: AppColors.onSurface,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Headers card
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ACTIVE HEADERS',
                          style: AppTypography.labelCaps,
                        ),
                        Text(
                          '${activePreset.headers.length} headers active',
                          style: AppTypography.codeSm.copyWith(
                            color: AppColors.tertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ...activePreset.headers.entries.map((e) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${e.key}: ',
                                style: AppTypography.codeSm.copyWith(
                                  color: AppColors.secondaryFixed,
                                ),
                              ),
                              TextSpan(
                                text: e.value,
                                style: AppTypography.codeSm.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Payload Textarea
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PAYLOAD BODY (JSON / RAW)',
                    style: AppTypography.labelCaps.copyWith(
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    '$charCount chars',
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.outline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _payloadController,
                  maxLines: 4,
                  style: AppTypography.codeSm.copyWith(
                    color: AppColors.primaryFixed,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  onChanged: (val) {
                    setState(() {
                      charCount = val.length;
                    });
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Run inference button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryContainer,
                    foregroundColor: AppColors.onPrimaryContainer,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  icon: isInferencing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.onPrimaryContainer,
                          ),
                        )
                      : const Icon(Icons.bolt, size: 20),
                  label: Text(
                    isInferencing
                        ? 'ANALYZING ATTENTION WEIGHTS...'
                        : 'RUN TRANSFORMER INFERENCE',
                    style: AppTypography.headlineSm.copyWith(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.onPrimaryContainer,
                      letterSpacing: 0.5,
                    ),
                  ),
                  onPressed: isInferencing ? null : _runInference,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // AI Verdict Card
        GlowCard(
          padding: const EdgeInsets.all(14),
          backgroundColor: AppColors.surfaceContainerLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: activePreset.score > 70
                                  ? AppColors.error
                                  : (activePreset.score > 30
                                      ? AppColors.secondary
                                      : AppColors.tertiary),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            activePreset.verdictSeverity.toUpperCase(),
                            style: AppTypography.labelCaps.copyWith(
                              color: activePreset.score > 70
                                  ? AppColors.error
                                  : (activePreset.score > 30
                                      ? AppColors.secondary
                                      : AppColors.tertiary),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        activePreset.verdictName,
                        style: AppTypography.headlineSm.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: activePreset.score > 70
                              ? AppColors.errorContainer
                              : AppColors.tertiaryContainer.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          children: [
                            Text(
                              '${activePreset.score}',
                              style: AppTypography.metricDisplay.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: activePreset.score > 70
                                    ? AppColors.error
                                    : AppColors.tertiary,
                              ),
                            ),
                            Text(
                              '/100',
                              style: AppTypography.codeSm.copyWith(
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'CONFIDENCE ${activePreset.confidence}',
                        style: AppTypography.labelCaps.copyWith(
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Firewall Decision Callout
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (activePreset.score > 70
                          ? AppColors.error
                          : AppColors.tertiary)
                      .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: (activePreset.score > 70
                            ? AppColors.error
                            : AppColors.tertiary)
                        .withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          activePreset.score > 70
                              ? Icons.gpp_bad
                              : Icons.verified_user,
                          size: 22,
                          color: activePreset.score > 70
                              ? AppColors.error
                              : AppColors.tertiary,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activePreset.firewallAction,
                              style: AppTypography.codeSm.copyWith(
                                color: activePreset.score > 70
                                    ? AppColors.error
                                    : AppColors.tertiary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              activePreset.firewallDetail,
                              style: AppTypography.codeSm.copyWith(
                                color: AppColors.onSurfaceVariant,
                                fontSize: 10.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${activePreset.runtimeMs} ms',
                          style: AppTypography.codeSm.copyWith(
                            color: AppColors.primaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'EDGE RUNTIME',
                          style: AppTypography.labelCaps.copyWith(
                            fontSize: 8.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // 5-Stage Pipeline Analysis
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'MULTI-STAGE PIPELINE ANALYSIS',
                    style: AppTypography.labelCaps.copyWith(
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    '5 of 5 Stages Passed',
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.tertiary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              ...activePreset.stages.map((stage) {
                Color iconBg;
                Color iconColor;
                IconData icon;

                if (stage.isPassed) {
                  iconBg = AppColors.tertiary.withValues(alpha: 0.18);
                  iconColor = AppColors.tertiary;
                  icon = Icons.check;
                } else if (stage.isTriggered) {
                  iconBg = AppColors.errorContainer;
                  iconColor = AppColors.error;
                  icon = Icons.priority_high;
                } else {
                  iconBg = AppColors.secondaryContainer;
                  iconColor = AppColors.secondary;
                  icon = Icons.psychology;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: iconBg,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 14, color: iconColor),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  stage.title,
                                  style: AppTypography.codeSm.copyWith(
                                    color: AppColors.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  stage.latency,
                                  style: AppTypography.codeSm.copyWith(
                                    color: stage.isPassed
                                        ? AppColors.onSurfaceVariant
                                        : AppColors.error,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              stage.detail,
                              style: AppTypography.bodySm.copyWith(
                                fontSize: 11.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 12),

              // Attention Weight Heatmap
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ATTENTION WEIGHT HEATMAP',
                    style: AppTypography.labelCaps.copyWith(
                      letterSpacing: 1.0,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        color: AppColors.error,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'High Anomaly Weight',
                        style: AppTypography.codeSm.copyWith(
                          fontSize: 10,
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 6),

              Text(
                'TOKENIZED STREAM (LAYER 6 / HEAD 4):',
                style: AppTypography.labelCaps.copyWith(
                  color: AppColors.outline,
                  fontSize: 9,
                ),
              ),
              const SizedBox(height: 6),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: activePreset.tokens.map((tok) {
                    if (tok.isCritical) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tok.text,
                          style: AppTypography.codeSm.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }
                    if (tok.isSecondary) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tok.text,
                          style: AppTypography.codeSm.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }
                    return Text(
                      tok.text,
                      style: AppTypography.codeSm.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 14),

              // Tactical remediation actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryContainer,
                        side: const BorderSide(
                          color: AppColors.primaryContainer,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.code, size: 16),
                      label: Text('Export JSON', style: AppTypography.codeSm),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.surfaceContainerHigh,
                            content: Text(
                              'Inference audit payload exported as JSON.',
                              style: AppTypography.codeSm.copyWith(
                                color: AppColors.primaryContainer,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.tertiary,
                        side: const BorderSide(
                          color: AppColors.tertiary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.add_moderator, size: 16),
                      label: Text('Add Signature', style: AppTypography.codeSm),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.surfaceContainerHigh,
                            content: Text(
                              'Synthesized AST rule dispatched to edge CRS.',
                              style: AppTypography.codeSm.copyWith(
                                color: AppColors.tertiary,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.onSurface,
                    side: const BorderSide(
                      color: AppColors.surfaceContainerHigh,
                    ),
                    backgroundColor: AppColors.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.share, size: 16),
                  label: Text(
                    'Dispatch Incident Bundle to SOC Slack #incident-feed',
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.onSurface,
                      fontSize: 11,
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.surfaceContainerHigh,
                        content: Text(
                          'Incident bundle dispatched to Slack #incident-feed.',
                          style: AppTypography.codeSm.copyWith(
                            color: AppColors.primaryFixed,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}
