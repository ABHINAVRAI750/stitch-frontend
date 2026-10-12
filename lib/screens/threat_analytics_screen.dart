import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/tactical_widgets.dart';

class ThreatAnalyticsScreen extends StatefulWidget {
  const ThreatAnalyticsScreen({super.key});

  @override
  State<ThreatAnalyticsScreen> createState() => _ThreatAnalyticsScreenState();
}

class _ThreatAnalyticsScreenState extends State<ThreatAnalyticsScreen> {
  final List<Map<String, dynamic>> ruleProposals = [
    {
      'id': 'RULE-2026-901',
      'title': 'Autonomous Rate-Limit on Tor Exit AS42234',
      'confidence': '99.4%',
      'riskMitigated': 'SQLi Credential Stuffing',
      'action': 'Rate-Limit (5 req/min)',
      'deployed': false,
    },
    {
      'id': 'RULE-2026-902',
      'title': 'Strict Introspection Depth Limiter (/graphql)',
      'confidence': '97.8%',
      'riskMitigated': 'GraphQL Schema Harvesting',
      'action': 'Turnstile Challenge',
      'deployed': true,
    },
    {
      'id': 'RULE-2026-903',
      'title': 'Multi-Part Shell Extension Trap (.php.pdf)',
      'confidence': '99.9%',
      'riskMitigated': 'Remote Shell Upload',
      'action': 'Edge Immediate TCP RST',
      'deployed': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      children: [
        // Sub-header
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
                  const Icon(Icons.shield_outlined,
                      size: 16, color: AppColors.primaryContainer),
                  const SizedBox(width: 8),
                  Text(
                    'Global Threat Intelligence',
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.errorContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  'DEFCON 2 • ACTIVE SHIELD',
                  style: AppTypography.labelCaps.copyWith(
                    color: AppColors.error,
                    fontSize: 8.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Autonomous Rule Proposals from AI
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
                      const Icon(Icons.auto_awesome,
                          size: 18, color: AppColors.secondary),
                      const SizedBox(width: 8),
                      Text(
                        'Autonomous Rule Proposals',
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
                      color: AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      'AI SYNTHESIZED',
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.onSecondaryContainer,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'SentinelBERT detected cluster patterns and synthesized edge rules',
                style: AppTypography.bodySm.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 12),

              ...ruleProposals.map((rule) {
                final isDeployed = rule['deployed'] as bool;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isDeployed
                          ? AppColors.tertiary.withValues(alpha: 0.4)
                          : AppColors.surfaceContainerHigh,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            rule['id'],
                            style: AppTypography.codeSm.copyWith(
                              color: AppColors.primaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDeployed
                                  ? AppColors.tertiary.withValues(alpha: 0.15)
                                  : AppColors.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              isDeployed ? 'DEPLOYED ON EDGE' : 'PENDING REVIEW',
                              style: AppTypography.labelCaps.copyWith(
                                color: isDeployed
                                    ? AppColors.tertiary
                                    : AppColors.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                                fontSize: 8.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        rule['title'],
                        style: AppTypography.bodyMd.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Action: ${rule['action']}',
                            style: AppTypography.codeSm.copyWith(
                              color: AppColors.secondaryFixed,
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            'Confidence: ${rule['confidence']}',
                            style: AppTypography.codeSm.copyWith(
                              color: AppColors.tertiary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (!isDeployed)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryContainer,
                              foregroundColor: AppColors.onPrimaryContainer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            onPressed: () {
                              setState(() {
                                rule['deployed'] = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColors.surfaceContainerHigh,
                                  content: Text(
                                    '${rule['id']} successfully deployed across 16 edge worker clusters.',
                                    style: AppTypography.codeSm.copyWith(
                                      color: AppColors.tertiary,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'Deploy Rule to Edge',
                              style: AppTypography.codeSm.copyWith(
                                color: AppColors.onPrimaryContainer,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Geographic Threat Origin Matrix
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
                      const Icon(Icons.public, size: 18, color: AppColors.tertiary),
                      const SizedBox(width: 8),
                      Text(
                        'Threat Origins by Country',
                        style: AppTypography.headlineSm.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text('Last 24 Hours', style: AppTypography.labelCaps),
                ],
              ),
              const SizedBox(height: 12),

              _CountryThreatRow(country: 'Germany (Tor Exits)', volume: '1,420 attacks', share: 0.38, color: AppColors.error),
              const SizedBox(height: 8),
              _CountryThreatRow(country: 'Netherlands (Hosting ASN)', volume: '984 attacks', share: 0.26, color: AppColors.secondary),
              const SizedBox(height: 8),
              _CountryThreatRow(country: 'Russian Fed (Botnets)', volume: '812 attacks', share: 0.22, color: AppColors.error),
              const SizedBox(height: 8),
              _CountryThreatRow(country: 'United States (Proxies)', volume: '526 attacks', share: 0.14, color: AppColors.primaryContainer),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Top Targeted Endpoints
        GlowCard(
          padding: const EdgeInsets.all(14),
          backgroundColor: AppColors.surfaceContainerLow,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.api, size: 18, color: AppColors.primaryContainer),
                  const SizedBox(width: 8),
                  Text(
                    'Most Targeted Endpoints',
                    style: AppTypography.headlineSm.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _TargetedEndpointRow(method: 'POST', endpoint: '/api/v1/auth/tokens', hits: '1,920 drops', vector: 'SQLi & Brute Force'),
              const SizedBox(height: 8),
              _TargetedEndpointRow(method: 'GET', endpoint: '/graphql', hits: '840 challenged', vector: 'Query Depth Exceeded'),
              const SizedBox(height: 8),
              _TargetedEndpointRow(method: 'POST', endpoint: '/upload/resume.pdf.php', hits: '612 resets', vector: 'Polyglot Shell Upload'),
              const SizedBox(height: 8),
              _TargetedEndpointRow(method: 'GET', endpoint: '/search?q=...', hits: '470 sanitized', vector: 'Reflected XSS Injection'),
            ],
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}

class _CountryThreatRow extends StatelessWidget {
  final String country;
  final String volume;
  final double share;
  final Color color;

  const _CountryThreatRow({
    required this.country,
    required this.volume,
    required this.share,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(country, style: AppTypography.codeSm.copyWith(color: AppColors.onSurface)),
            Text(volume, style: AppTypography.codeSm.copyWith(color: color, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: share,
            backgroundColor: AppColors.surfaceContainer,
            color: color,
            minHeight: 5,
          ),
        ),
      ],
    );
  }
}

class _TargetedEndpointRow extends StatelessWidget {
  final String method;
  final String endpoint;
  final String hits;
  final String vector;

  const _TargetedEndpointRow({
    required this.method,
    required this.endpoint,
    required this.hits,
    required this.vector,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    endpoint,
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    vector,
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.outline,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            hits,
            style: AppTypography.codeSm.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
