import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  final Function(int) onSelectTab;
  final VoidCallback onOpenPolicies;
  final VoidCallback onOpenBlockedSources;
  final VoidCallback onOpenEventLogs;
  final VoidCallback onOpenSettings;

  const AppDrawer({
    super.key,
    required this.onSelectTab,
    required this.onOpenPolicies,
    required this.onOpenBlockedSources,
    required this.onOpenEventLogs,
    required this.onOpenSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surfaceContainerLow,
      elevation: 16,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.primaryContainer.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.security,
                          color: AppColors.primaryContainer,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sentinel Ops',
                            style: AppTypography.headlineSm.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.onSurface,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'v4.8.2-prod',
                            style: AppTypography.codeSm.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.onSurfaceVariant,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: AppColors.surfaceContainerHigh, height: 1),

            // Navigation section
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 18, bottom: 8),
              child: Text(
                'OPERATIONAL CONTROLS',
                style: AppTypography.labelCaps.copyWith(
                  color: AppColors.outline,
                  letterSpacing: 1.2,
                ),
              ),
            ),

            _DrawerTile(
              icon: Icons.policy_outlined,
              label: 'Security Policies',
              onTap: () {
                Navigator.of(context).pop();
                onOpenPolicies();
              },
            ),
            _DrawerTile(
              icon: Icons.block,
              label: 'Blocked Sources',
              onTap: () {
                Navigator.of(context).pop();
                onOpenBlockedSources();
              },
            ),
            _DrawerTile(
              icon: Icons.receipt_long,
              label: 'Event Logs',
              onTap: () {
                Navigator.of(context).pop();
                onOpenEventLogs();
              },
            ),
            _DrawerTile(
              icon: Icons.tune,
              label: 'System Settings',
              onTap: () {
                Navigator.of(context).pop();
                onOpenSettings();
              },
            ),

            const Spacer(),

            // Engine Health Bottom Panel
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.surfaceContainerHigh,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Engine Health',
                        style: AppTypography.codeSm.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      Text(
                        '99.99%',
                        style: AppTypography.codeSm.copyWith(
                          color: AppColors.tertiary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: Container(
                      height: 6,
                      color: AppColors.surfaceContainerHighest,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 9999,
                            child: Container(
                              color: AppColors.tertiary,
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          hoverColor: AppColors.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(icon, size: 20, color: AppColors.onSurfaceVariant),
                const SizedBox(width: 14),
                Text(
                  label,
                  style: AppTypography.bodyMd.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w500,
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
