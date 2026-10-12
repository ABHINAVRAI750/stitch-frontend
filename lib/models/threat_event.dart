enum ThreatStatusType {
  blocked,
  underReview,
  allowed,
}

class MatchedToken {
  final String text;
  final bool isMalicious;
  final bool isDelim;

  const MatchedToken({
    required this.text,
    this.isMalicious = false,
    this.isDelim = false,
  });
}

class ThreatEvent {
  final String id;
  final String clientIp;
  final String origin;
  final String asn;
  final String method;
  final String path;
  final String threatTitle;
  final int score;
  final String scoreBadge;
  final String statusBadge;
  final ThreatStatusType statusType;
  final String timestamp;
  final String timeAgo;
  final List<String> tacticalBadges;
  final String aiEngine;
  final String payloadSnippet;
  final List<String> matchedTokens;
  final double attentionAlpha;
  final String mitigationRule;

  const ThreatEvent({
    required this.id,
    required this.clientIp,
    required this.origin,
    required this.asn,
    required this.method,
    required this.path,
    required this.threatTitle,
    required this.score,
    required this.scoreBadge,
    required this.statusBadge,
    required this.statusType,
    required this.timestamp,
    required this.timeAgo,
    required this.tacticalBadges,
    required this.aiEngine,
    required this.payloadSnippet,
    required this.matchedTokens,
    required this.attentionAlpha,
    required this.mitigationRule,
  });

  static List<ThreatEvent> getSampleEvents() {
    return [
      const ThreatEvent(
        id: 'evt-001',
        clientIp: '185.220.101.5',
        origin: 'Tor Exit Node, DE',
        asn: '42234',
        method: 'POST',
        path: '/api/v1/auth/tokens',
        threatTitle: 'SQL Injection (Bypass Authentication)',
        score: 99,
        scoreBadge: '99/100 CRIT',
        statusBadge: 'BLOCKED 403',
        statusType: ThreatStatusType.blocked,
        timestamp: '14:38:12.402 UTC',
        timeAgo: '1.2s ago',
        tacticalBadges: ['Automated Ban 24h', 'Payload Redacted'],
        aiEngine: 'SentinelBERT-v4',
        payloadSnippet: "username=admin'&pass=UNION+SELECT+1,schema_name--",
        matchedTokens: ["' UNION '", "' ALL '", "' SELECT '", "' 1,schema_name '"],
        attentionAlpha: 0.942,
        mitigationRule: 'CRS #942100 (SQLi Auth Bypass) + Transformer Drop',
      ),
      const ThreatEvent(
        id: 'evt-002',
        clientIp: '91.240.118.42',
        origin: 'Cloud Provider, NL',
        asn: '201124',
        method: 'GET',
        path: '/graphql?query={user(id:1){...}}',
        threatTitle: 'Suspicious GraphQL Introspection & Depth Anomaly',
        score: 74,
        scoreBadge: '74/100 ELEVATED',
        statusBadge: 'UNDER REVIEW',
        statusType: ThreatStatusType.underReview,
        timestamp: '14:38:09.118 UTC',
        timeAgo: '4.5s ago',
        tacticalBadges: ['Challenged: Turnstile', 'Depth > 8'],
        aiEngine: 'Attention Anomaly',
        payloadSnippet: 'query={user(id:1){friends{friends{friends{id,email}}}}}',
        matchedTokens: ['__schema', 'introspectionQuery', 'depth_exceeded'],
        attentionAlpha: 0.741,
        mitigationRule: 'Rate-Limiting Challenge & CAPTCHA Verification',
      ),
      const ThreatEvent(
        id: 'evt-003',
        clientIp: '194.26.29.112',
        origin: 'Known Botnet, RU',
        asn: '58224',
        method: 'POST',
        path: '/upload/resume.pdf.php',
        threatTitle: 'Remote Code Execution / Shell Upload',
        score: 98,
        scoreBadge: '98/100 CRIT',
        statusBadge: 'TERM DROP',
        statusType: ThreatStatusType.blocked,
        timestamp: '14:37:55.820 UTC',
        timeAgo: '17.8s ago',
        tacticalBadges: ['Polyglot Signature', 'TCP Reset'],
        aiEngine: 'MultiModal-Tokeni...',
        payloadSnippet: 'GIF89a; <?php system(\$_GET["cmd"]); ?>',
        matchedTokens: ['<?php', 'system(', 'cmd_injection', '.php_extension'],
        attentionAlpha: 0.982,
        mitigationRule: 'MIME Sniff Mismatch + Shell Signature Drop',
      ),
      const ThreatEvent(
        id: 'evt-004',
        clientIp: '203.0.113.88',
        origin: 'Mobile Carrier, US',
        asn: '10796',
        method: 'GET',
        path: '/search?q=%252e%252e%252f%252e%252e%252fetc%252fpasswd',
        threatTitle: 'Double-URL Encoded Path Traversal',
        score: 92,
        scoreBadge: '92/100 AI DROP',
        statusBadge: 'BLOCKED 400',
        statusType: ThreatStatusType.blocked,
        timestamp: '14:37:41.004 UTC',
        timeAgo: '32.1s ago',
        tacticalBadges: ['Recursive Decode', '/etc/passwd Probe'],
        aiEngine: 'Byte-Level Encoder',
        payloadSnippet: '../../../../etc/passwd (Hex recursive: %252e%252e)',
        matchedTokens: ['%252e', '%252f', 'etc/passwd'],
        attentionAlpha: 0.925,
        mitigationRule: 'Recursive URI Normalizer + Canonical Reject',
      ),
      const ThreatEvent(
        id: 'evt-005',
        clientIp: '66.249.66.1',
        origin: 'Googlebot Verified',
        asn: '15169',
        method: 'GET',
        path: '/robots.txt',
        threatTitle: 'None (Verified Crawler)',
        score: 2,
        scoreBadge: '02/100 BENIGN',
        statusBadge: 'ALLOWED 200',
        statusType: ThreatStatusType.allowed,
        timestamp: '14:37:30.912 UTC',
        timeAgo: '42.3s ago',
        tacticalBadges: ['Search Indexer', 'TLS 1.3'],
        aiEngine: 'Trust Engine (rDNS Passed)',
        payloadSnippet: 'User-agent: Googlebot\\nDisallow: /private/',
        matchedTokens: ['Googlebot', 'robots.txt', 'RFC-compliant'],
        attentionAlpha: 0.021,
        mitigationRule: 'Cryptographic Forward-DNS Verification Passed',
      ),
    ];
  }
}

