import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_header.dart';
import '../widgets/app_drawer.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/drawer_dialogs.dart';
import 'overview_screen.dart';
import 'live_monitor_screen.dart';
import 'request_inspector_screen.dart';
import 'model_center_screen.dart';
import 'threat_analytics_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentTabIndex = 0;

  // Sandbox pre-filled parameters if navigated from live stream or overview
  String? _sandboxIp;
  String? _sandboxPath;
  String? _sandboxPayload;

  final List<String> _screenTitles = [
    'Overview',
    'Live Monitor',
    'Inspector',
    'Model Center',
    'Threat Intel',
  ];

  void _navigateToTab(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  void _openInSandbox(String ip, String path, String payload) {
    setState(() {
      _sandboxIp = ip;
      _sandboxPath = path;
      _sandboxPayload = payload;
      _currentTabIndex = 2; // Jump to Inspector tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.surface,
      appBar: AppHeader(
        title: _screenTitles[_currentTabIndex],
        onOpenDrawer: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        onOpenNotifications: () {
          DrawerDialogs.showNotifications(context);
        },
      ),
      drawer: AppDrawer(
        onSelectTab: (index) {
          _navigateToTab(index);
        },
        onOpenPolicies: () {
          DrawerDialogs.showPolicies(context);
        },
        onOpenBlockedSources: () {
          DrawerDialogs.showBlockedSources(context);
        },
        onOpenEventLogs: () {
          DrawerDialogs.showEventLogs(context);
        },
        onOpenSettings: () {
          DrawerDialogs.showSettings(context);
        },
      ),
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          OverviewScreen(
            onViewAllThreats: () => _navigateToTab(1),
            onInspectPayload: (ip, path, title) => _openInSandbox(ip, path, title),
          ),
          LiveMonitorScreen(
            onOpenInSandbox: (ip, path, payload) => _openInSandbox(ip, path, payload),
          ),
          RequestInspectorScreen(
            initialIp: _sandboxIp,
            initialPath: _sandboxPath,
            initialPayload: _sandboxPayload,
          ),
          const ModelCenterScreen(),
          const ThreatAnalyticsScreen(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _currentTabIndex,
        onTabSelected: (index) {
          _navigateToTab(index);
        },
      ),
    );
  }
}

