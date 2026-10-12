import 'package:flutter/material.dart';
import '../models/threat_event.dart';
import '../theme/app_theme.dart';

class LiveMonitorScreen extends StatefulWidget {
  final Function(String ip, String path, String payload) onOpenInSandbox;

  const LiveMonitorScreen({
    super.key,
    required this.onOpenInSandbox,
  });

  @override
  State<LiveMonitorScreen> createState() => _LiveMonitorScreenState();
}

class _LiveMonitorScreenState extends State<LiveMonitorScreen> {
  bool isStreaming = true;
  String currentFilter = 'ALL';
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  List<ThreatEvent> allEvents = ThreatEvent.getSampleEvents();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ThreatEvent> get filteredEvents {
    return allEvents.where((evt) {
      if (currentFilter == 'BLOCKED' &&
          evt.statusType != ThreatStatusType.blocked) {
        return false;
      }
      if (currentFilter == 'AI_FLAGGED' &&
          evt.statusType != ThreatStatusType.underReview &&
          evt.score < 90) {
        return false;
      }

      if (searchQuery.isNotEmpty) {
        final q = searchQuery.toLowerCase();
        final matchesIp = evt.clientIp.toLowerCase().contains(q);
        final matchesPath = evt.path.toLowerCase().contains(q);
        final matchesTitle = evt.threatTitle.toLowerCase().contains(q);
        final matchesAsn = evt.asn.toLowerCase().contains(q);
        return matchesIp || matchesPath || matchesTitle || matchesAsn;
      }

      return true;
    }).toList();
  }

  void _showInspectorModal(ThreatEvent event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            border: Border.all(
              color: AppColors.surfaceContainerHigh,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 28,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drawer Handle & Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow.withValues(alpha: 0.95),
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 38,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.terminal,
                              size: 22,
                              color: AppColors.primaryContainer,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'TACTICAL INSPECTOR',
                                  style: AppTypography.labelCaps.copyWith(
                                    color: AppColors.primaryContainer,
                                    letterSpacing: 1.4,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  event.threatTitle,
                                  style: AppTypography.headlineSm.copyWith(
                                    fontSize: 15,
                                    color: AppColors.onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Drawer Body
              Flexible(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: [
                    // Overview stats box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Column(
                        children: [
                          _ModalRow(
                            label: 'SOURCE IP',
                            value: event.clientIp,
                            valueColor: AppColors.primaryContainer,
                            isBold: true,
                          ),
                          const Divider(
                              color: AppColors.surfaceContainerHigh, height: 16),
                          _ModalRow(
                            label: 'TARGET URI',
                            value: '${event.method} ${event.path}',
                            valueColor: AppColors.onSurface,
                          ),
                          const Divider(
                              color: AppColors.surfaceContainerHigh, height: 16),
                          _ModalRow(
                            label: 'AI MODEL SCORE',
                            value: '${event.score}/100 (${event.statusBadge})',
                            valueColor: event.score > 80
                                ? AppColors.error
                                : (event.score > 50
                                    ? AppColors.secondary
                                    : AppColors.tertiary),
                            isBold: true,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Matched Tokens
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'MATCHED PAYLOAD TOKENS',
                          style: AppTypography.labelCaps.copyWith(
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          'Token Count: ${event.matchedTokens.length}',
                          style: AppTypography.codeSm.copyWith(
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: event.matchedTokens.map((tok) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: event.score > 70
                                  ? AppColors.errorContainer
                                  : AppColors.tertiaryContainer.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tok,
                              style: AppTypography.codeSm.copyWith(
                                color: event.score > 70
                                    ? AppColors.error
                                    : AppColors.tertiary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Attention Weight Heatmap
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.psychology,
                                    size: 15,
                                    color: AppColors.secondary,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'ATTENTION WEIGHT HEATMAP',
                                    style: AppTypography.labelCaps.copyWith(
                                      color: AppColors.secondary,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'α = ${event.attentionAlpha}',
                                style: AppTypography.codeSm.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(9999),
                            child: SizedBox(
                              height: 10,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 15,
                                    child: Container(
                                        color:
                                            AppColors.surfaceContainerHighest),
                                  ),
                                  Expanded(
                                    flex: 20,
                                    child: Container(
                                        color: AppColors.secondaryContainer),
                                  ),
                                  Expanded(
                                    flex: 25,
                                    child: Container(
                                        color: AppColors.secondary),
                                  ),
                                  Expanded(
                                    flex: 40,
                                    child: Container(color: AppColors.error),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('token_0: ingress',
                                  style: AppTypography.codeSm.copyWith(
                                    fontSize: 10,
                                    color: AppColors.outline,
                                  )),
                              Text('critical anomaly trigger',
                                  style: AppTypography.codeSm.copyWith(
                                    fontSize: 10,
                                    color: AppColors.error,
                                    fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: SelectableText(
                              event.payloadSnippet,
                              style: AppTypography.codeSm.copyWith(
                                color: AppColors.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Actions
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryContainer,
                        foregroundColor: AppColors.onPrimaryContainer,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.biotech, size: 20),
                      label: Text(
                        'Inspect in AI Sandbox',
                        style: AppTypography.headlineSm.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onPrimaryContainer,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onOpenInSandbox(
                          event.clientIp,
                          event.path,
                          event.payloadSnippet,
                        );
                      },
                    ),
                    const SizedBox(height: 8),

                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: BorderSide(
                          color: AppColors.error.withValues(alpha: 0.5),
                        ),
                        backgroundColor: AppColors.errorContainer.withValues(alpha: 0.15),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.block, size: 18),
                      label: Text(
                        'Add IP to Global Denylist',
                        style: AppTypography.bodyMd.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.errorContainer,
                            content: Text(
                              'IP ${event.clientIp} has been added to Global Denylist (Edge Synced)',
                              style: AppTypography.codeSm.copyWith(
                                color: AppColors.onErrorContainer,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),

                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.onSurface,
                        side: const BorderSide(
                          color: AppColors.surfaceContainerHigh,
                        ),
                        backgroundColor: AppColors.surfaceContainer,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Icon(Icons.download, size: 18),
                      label: Text(
                        'Download Full PCAP (14.2 KB)',
                        style: AppTypography.bodyMd.copyWith(
                          color: AppColors.onSurface,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColors.surfaceContainerHigh,
                            content: Text(
                              'PCAP bundle for ${event.id} downloaded successfully.',
                              style: AppTypography.codeSm.copyWith(
                                color: AppColors.primaryContainer,
                              ),
                            ),
                          ),
                        );
                      },
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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      children: [
        // Streaming Controls Strip
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: AppColors.surfaceContainerHigh,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: isStreaming
                          ? AppColors.tertiary
                          : AppColors.outline,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isStreaming ? 'STREAMING' : 'PAUSED',
                    style: AppTypography.labelCaps.copyWith(
                      color: isStreaming
                          ? AppColors.tertiary
                          : AppColors.outline,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.0,
                    ),
                  ),
                  if (isStreaming) ...[
                    const SizedBox(width: 6),
                    Text(
                      '38 EPS',
                      style: AppTypography.codeSm.copyWith(
                        color: AppColors.primaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      isStreaming = !isStreaming;
                    });
                  },
                  icon: Icon(
                    isStreaming ? Icons.pause : Icons.play_arrow,
                    size: 18,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(width: 6),
                IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.surfaceContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      allEvents = allEvents.reversed.toList();
                    });
                  },
                  icon: const Icon(
                    Icons.sort,
                    size: 18,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Terminal Search Input
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.surfaceContainerHigh,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Text(
                '>_',
                style: AppTypography.codeSm.copyWith(
                  color: AppColors.primaryContainer,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: AppTypography.codeSm.copyWith(
                    color: AppColors.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search IP, CIDR, endpoint, CVE, payload...',
                    hintStyle: AppTypography.codeSm.copyWith(
                      color: AppColors.outline,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onChanged: (val) {
                    setState(() {
                      searchQuery = val;
                    });
                  },
                ),
              ),
              if (searchQuery.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _searchController.clear();
                      searchQuery = '';
                    });
                  },
                  child: const Icon(
                    Icons.clear,
                    size: 16,
                    color: AppColors.outline,
                  ),
                )
              else
                const Icon(
                  Icons.tune,
                  size: 16,
                  color: AppColors.outline,
                ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Filter Pills Strip
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _FilterPill(
                label: 'ALL (3,842)',
                isActive: currentFilter == 'ALL',
                onTap: () => setState(() => currentFilter = 'ALL'),
              ),
              const SizedBox(width: 8),
              _FilterPill(
                label: 'BLOCKED (3,719)',
                isActive: currentFilter == 'BLOCKED',
                onTap: () => setState(() => currentFilter = 'BLOCKED'),
              ),
              const SizedBox(width: 8),
              _FilterPill(
                label: 'AI FLAGGED (1,248)',
                isActive: currentFilter == 'AI_FLAGGED',
                onTap: () => setState(() => currentFilter = 'AI_FLAGGED'),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // Mitigation Rate Summary Bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.security_update_good,
                    size: 20,
                    color: AppColors.primaryContainer,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MITIGATION RATE',
                        style: AppTypography.labelCaps.copyWith(
                          letterSpacing: 1.0,
                        ),
                      ),
                      Text(
                        '96.8%',
                        style: AppTypography.metricDisplay.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.trending_up,
                          size: 14, color: AppColors.tertiary),
                      const SizedBox(width: 3),
                      Text(
                        '0.4ms lat',
                        style: AppTypography.codeSm.copyWith(
                          color: AppColors.tertiary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Cluster: US-East-Primary',
                    style: AppTypography.codeSm.copyWith(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // High-Density Live Feed
        ...filteredEvents.map((evt) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _EventFeedCard(
              event: evt,
              onTap: () => _showInspectorModal(evt),
            ),
          );
        }),

        if (filteredEvents.isEmpty)
          Container(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Text(
                'No events match current filter/search criteria',
                style: AppTypography.bodySm.copyWith(color: AppColors.outline),
              ),
            ),
          ),

        const SizedBox(height: 20),
      ],
    );
  }
}

class _FilterPill extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterPill({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryContainer
              : AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(9999),
          border: Border.all(
            color: isActive
                ? AppColors.primaryContainer
                : AppColors.surfaceContainerHigh,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.codeSm.copyWith(
            color: isActive
                ? AppColors.onPrimaryContainer
                : AppColors.onSurfaceVariant,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _EventFeedCard extends StatelessWidget {
  final ThreatEvent event;
  final VoidCallback onTap;

  const _EventFeedCard({required this.event, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color sideColor;
    Color statusBgColor;
    Color statusTextColor;

    if (event.statusType == ThreatStatusType.blocked) {
      sideColor = AppColors.error;
      statusBgColor = AppColors.errorContainer;
      statusTextColor = AppColors.error;
    } else if (event.statusType == ThreatStatusType.underReview) {
      sideColor = AppColors.secondary;
      statusBgColor = AppColors.secondaryContainer;
      statusTextColor = AppColors.onSecondaryContainer;
    } else {
      sideColor = AppColors.tertiary;
      statusBgColor = AppColors.tertiary.withValues(alpha: 0.15);
      statusTextColor = AppColors.tertiary;
    }

    return Material(
      color: AppColors.surfaceContainerLow,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.surfaceContainerHigh.withValues(alpha: 0.6),
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Side indicator line
                Container(
                  width: 5,
                  decoration: BoxDecoration(
                    color: sideColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                ),

                // Main card content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row 1: Status & Timestamp
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: statusBgColor,
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                  child: Text(
                                    event.statusBadge,
                                    style: AppTypography.labelCaps.copyWith(
                                      color: statusTextColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Row(
                                  children: [
                                    Icon(
                                      event.statusType == ThreatStatusType.allowed
                                          ? Icons.verified_user
                                          : (event.statusType ==
                                                  ThreatStatusType.underReview
                                              ? Icons.warning_amber
                                              : Icons.gpp_bad),
                                      size: 14,
                                      color: sideColor,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      event.scoreBadge,
                                      style: AppTypography.codeSm.copyWith(
                                        color: sideColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              event.timestamp,
                              style: AppTypography.codeSm.copyWith(
                                color: AppColors.onSurfaceVariant,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Row 2: Method + Path
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                event.method,
                                style: AppTypography.codeSm.copyWith(
                                  color: AppColors.primaryContainer,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                event.path,
                                style: AppTypography.codeMd.copyWith(
                                  color: AppColors.onSurface,
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          event.threatTitle,
                          style: AppTypography.headlineSm.copyWith(
                            color: sideColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const SizedBox(height: 8),

                        // Row 3: IP & Origin Meta
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerLowest
                                .withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    event.statusType == ThreatStatusType.allowed
                                        ? Icons.smart_toy
                                        : (event.statusType ==
                                                ThreatStatusType.underReview
                                            ? Icons.cloud
                                            : Icons.dns),
                                    size: 14,
                                    color: AppColors.primaryContainer,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    event.clientIp,
                                    style: AppTypography.codeSm.copyWith(
                                      color: AppColors.onSurface,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    '(${event.origin})',
                                    style: AppTypography.codeSm.copyWith(
                                      color: AppColors.outline,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'ASN: ${event.asn}',
                                style: AppTypography.codeSm.copyWith(
                                  color: AppColors.outline,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Row 4: Tactical Badges & Engine
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              spacing: 6,
                              children: event.tacticalBadges.map((badge) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(9999),
                                  ),
                                  child: Text(
                                    badge,
                                    style: AppTypography.labelCaps.copyWith(
                                      color: AppColors.onSurfaceVariant,
                                      fontSize: 9,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.psychology,
                                  size: 14,
                                  color: AppColors.secondary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  event.aiEngine,
                                  style: AppTypography.codeSm.copyWith(
                                    color: AppColors.secondary,
                                    fontSize: 10.5,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModalRow extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  final bool isBold;

  const _ModalRow({
    required this.label,
    required this.value,
    required this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.labelCaps.copyWith(color: AppColors.outline),
        ),
        Flexible(
          child: Text(
            value,
            style: AppTypography.codeSm.copyWith(
              color: valueColor,
              fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            ),
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
