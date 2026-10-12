---
name: Autonomous WAF Command
colors:
  surface: '#0e1323'
  surface-dim: '#0e1323'
  surface-bright: '#34394a'
  surface-container-lowest: '#080d1d'
  surface-container-low: '#161b2b'
  surface-container: '#1a1f30'
  surface-container-high: '#25293a'
  surface-container-highest: '#2f3446'
  on-surface: '#dee1f9'
  on-surface-variant: '#bbc9cd'
  inverse-surface: '#dee1f9'
  inverse-on-surface: '#2b3041'
  outline: '#859397'
  outline-variant: '#3c494c'
  surface-tint: '#2fd9f4'
  primary: '#8aebff'
  on-primary: '#00363e'
  primary-container: '#22d3ee'
  on-primary-container: '#005763'
  inverse-primary: '#006877'
  secondary: '#d0bcff'
  on-secondary: '#3c0091'
  secondary-container: '#571bc1'
  on-secondary-container: '#c4abff'
  tertiary: '#68f5b8'
  on-tertiary: '#003824'
  tertiary-container: '#46d89d'
  on-tertiary-container: '#005a3d'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#a2eeff'
  primary-fixed-dim: '#2fd9f4'
  on-primary-fixed: '#001f25'
  on-primary-fixed-variant: '#004e5a'
  secondary-fixed: '#e9ddff'
  secondary-fixed-dim: '#d0bcff'
  on-secondary-fixed: '#23005c'
  on-secondary-fixed-variant: '#5516be'
  tertiary-fixed: '#6ffbbe'
  tertiary-fixed-dim: '#4edea3'
  on-tertiary-fixed: '#002113'
  on-tertiary-fixed-variant: '#005236'
  background: '#0e1323'
  on-background: '#dee1f9'
  surface-variant: '#2f3446'
typography:
  headline-xl:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '600'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-xl-mobile:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-lg:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: -0.005em
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Inter
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 18px
  code-md:
    fontFamily: JetBrains Mono
    fontSize: 13px
    fontWeight: '400'
    lineHeight: 18px
  code-sm:
    fontFamily: JetBrains Mono
    fontSize: 11px
    fontWeight: '400'
    lineHeight: 16px
  label-caps:
    fontFamily: JetBrains Mono
    fontSize: 10px
    fontWeight: '500'
    lineHeight: 14px
    letterSpacing: 0.08em
  metric-display:
    fontFamily: JetBrains Mono
    fontSize: 28px
    fontWeight: '500'
    lineHeight: 32px
    letterSpacing: -0.03em
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  gutter: 0.75rem
  gutter-desktop: 1rem
  margin: 1rem
  margin-desktop: 1.5rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 0.75rem
  space-lg: 1rem
  space-xl: 1.5rem
---

## Brand & Style

This design system targets SecOps engineers, incident responders, and enterprise infrastructure directors managing high-throughput edge environments. The interface conveys calculated vigilance, zero-latency situational awareness, and algorithmic authority. It rejects theatrical "Hollywood hacker" neon aesthetics in favor of mission-critical instrumentation inspired by aerospace avionics, Cloudflare Radar, and high-fidelity network observability consoles.

The core visual language balances high-density data grids with micro-telemetry indicators. Visual priority is dictated strictly by threat criticality and model confidence metrics. Surfaces utilize tactical dark slate layering with precise 1px hairline segmentation. Critical signals—such as payload drops, token anomalies, and automated mitigations—utilize controlled photon glows against deep obsidian and midnight planes to guarantee instant recognition under cognitive strain.

## Colors

The palette establishes an absolute visual hierarchy tailored to continuous monitoring under dark operational environments:

- **Canvas & Framing:** Base viewport canvas rests at `#0B1020` (Midnight Navy). Primary panel containers use `#141C2E`, stepping up to `#1A243B` for elevated inspection sheets and nested inspect drawers.
- **Structural Lines:** Structural division relies strictly on `#1E293B` for low-priority partitions and `#25334D` for active panel outlines and splitters.
- **Electric Cyan (`#22D3EE`):** Primary system focus, active viewport tabs, selected telemetry ranges, and live traffic volume meters.
- **Model Intelligence Violet (`#8B5CF6`, subtle `#A78BFA`):** Dedicated exclusively to neural transformer decisions, attention weight heatmaps, token risk scoring, and autonomous rule-generation proposals.
- **Tactical Semantics:**
  - **Mitigated / Clean (`#10B981`):** Upstream delivery, valid token streams, zero-deviation TLS handshakes.
  - **Inspection / Degraded (`#F59E0B`):** Rate-limiting challenge, behavioral drift, CAPTCHA queueing.
  - **Blocked / Malicious (`#EF4444`):** Signature hits, prompt injections, zero-day CVE execution blocks, automated edge drop.
- **Neutrals & Typography:** Headings utilize crisp off-white `#F8FAFC`, secondary metrics sit at `#94A3B8`, and disabled or ambient metadata rests at `#64748B`.

## Typography

Typography enforces rigid separation between human analytical prose and machine execution data:

- **Primary Interface (Inter):** Applied across all modal headers, administrative copy, filter configurations, and structural metadata. Renders dense text blocks legibly without optical distortion at sub-14px scales.
- **Telemetry & Machine Code (JetBrains Mono):** Mandated for raw HTTP request payloads, regular expressions, IP CIDR blocks, latency readouts, model confidence ratios, and log tables.
- **Metric Presentation:** Key numerical performance counters employ tabular figures (`tnum`) via monospaced numbers to eliminate jittering during real-time edge streaming.
- **Case Conventions:** High-level categorization tags and table headers enforce uppercase `label-caps` with strict letter spacing to maximize scannability across multi-column data views.

## Layout & Spacing

The layout is built for multi-monitor operations centers, prioritizing screen real estate and low scrolling overhead:

- **Grid Architecture:** 24-column fluid desktop matrix permitting granular split-screen configurations (e.g., global mitigation overview alongside live payload dissectors). Standard gutters contract to `0.75rem` on dense dashboard panels to maintain continuous visual scanning.
- **Operational Density:** Inner component padding defaults to compact (`space-xs` and `space-sm`) increments. Data rows maintain an explicit 32px height standard for logs and 40px for configurable table entities.
- **Breakpoints:**
  - **Desktop (1440px+):** Persistent left-hand contextual rail (240px fixed), multi-pane telemetry canvas, collapsible payload inspector drawer (420px).
  - **Tablet (768px - 1439px):** Inspector drawer switches to absolute slide-over; data columns collapse low-priority indicators (user agent, ASN) into expandable row drawers.
  - **Mobile (<768px):** Single-column stacked mode with sticky top health/threat-level indicators; live log tables switch to aggregated alert cards.

## Elevation & Depth

Depth is established strictly through tonal surface layering and precise hairline borders rather than diffuse, room-filling drop shadows:

- **Level 0 (Base Floor, `#0B1020`):** System background, inactive canvas, grid tracking foundation.
- **Level 1 (Data Deck, `#141C2E`):** Core application panels, analytics cards, persistent timeline streams. Encased with 1px border `rgba(37, 51, 77, 0.6)`.
- **Level 2 (Active Focus & Drawers, `#1A243B`):** Hovered log rows, configuration accordions, active inspector panels. Bordered by `#25334D`.
- **Level 3 (Overlays & Flyouts, `#1E293B`):** Threat detail contextual modals, dropdown popovers, filter menus. Employs a crisp drop shadow: `0 12px 32px -4px rgba(0, 0, 0, 0.65)`, rimmed with a 1px perimeter stroke of `rgba(34, 211, 238, 0.15)`.
- **Photon Luminescence:** Critical states do not use flat backgrounds; they emit restrained perimeter glows. Blocked incidents feature `box-shadow: 0 0 12px -2px rgba(239, 68, 68, 0.35)`. Active transformer analysis states feature `box-shadow: 0 0 14px -2px rgba(139, 92, 246, 0.3)`.

## Shapes

The design system enforces a precise, engineered shape standard (`roundedness: 1`):

- **Panels and Cards:** Use `0.25rem` (4px) corner rounding to maintain tight alignment within dense terminal-like dashboards.
- **Badges, Status Pills, and Indicators:** Use `0.25rem` or explicit full pill radii (`9999px`) for micro-indicators to contrast clearly against rectangular layout grids.
- **Input Fields & Tactical Buttons:** Constrained to `0.25rem` corner radiuses, eliminating consumer-grade softness in favor of utilitarian precision.

## Components

### Buttons & Tactical Triggers
- **Primary Action (Mitigate, Deploy Rule):** Solid `#22D3EE` background with deep navy `#0B1020` text, bold weight, zero drop shadow, sharp transitions. Hover initiates brightness shift with `box-shadow: 0 0 8px rgba(34, 211, 238, 0.4)`.
- **Secondary Action (Inspect, Trace):** Transparent background, 1px border in `#25334D`, text in `#94A3B8`. Hover transitions text to `#F8FAFC` and border to `#22D3EE`.
- **Destructive/Enforce Drop:** Subdued crimson background `rgba(239, 68, 68, 0.15)`, 1px border `rgba(239, 68, 68, 0.4)`, text `#EF4444`.

### Status Pills & Threat Badges
- **Structure:** Pill-shaped (`rounded-full`), padding `2px 8px`, `JetBrains Mono` label-caps font.
- **Allowed:** Background `rgba(16, 185, 129, 0.12)`, text `#10B981`, leading pulse dot in solid `#10B981`.
- **Review / Challenge:** Background `rgba(245, 158, 11, 0.12)`, text `#F59E0B`, leading amber triangle.
- **Blocked / Exploit:** Background `rgba(239, 68, 68, 0.16)`, border `1px solid rgba(239, 68, 68, 0.35)`, text `#F87171`, red ambient luminescent glow.
- **Transformer AI Tag:** Background `rgba(139, 92, 246, 0.15)`, border `1px solid rgba(167, 139, 250, 0.3)`, text `#C4B5FD`.

### High-Density Event Tables
- **Header:** Sticky `#0F1626` base, uppercase `label-caps` typography, 1px bottom border in `#25334D`.
- **Rows:** Alternating subtle zebra striping (`#141C2E` / `#111827`), hover state shifts entire row to `#1A243B` with a left edge 2px indicator in `#22D3EE`.
- **Cells:** Numeric latency, status codes, and IP addresses are rendered in `JetBrains Mono` with fixed character widths.

### Payload & Token Inspectors
- **Diff Containers:** `#0A0E1A` deep inset background, 1px perimeter border `#1E293B`, scrollable with custom 4px dark slate scrollbars.
- **Attention Weight Highlights:** Text spans within HTTP request bodies highlighted in varying opacities of violet (`rgba(139, 92, 246, 0.25)` to `rgba(139, 92, 246, 0.65)`) to indicate transformer anomaly attention scoring.

### Input Fields & Filter Bars
- **Syntax Filter:** Fixed terminal-like input with leading prefix symbol (`>_`), background `#111827`, border `#25334D`, placeholder in `#64748B`. Focus pulls 1px border stroke of `#22D3EE` with no default browser outline.
- **Checkboxes & Toggles:** Square 14px boxes with 2px radius, dark navy fill, bordered by `#25334D`. Checked state presents `#22D3EE` fill with a `#0B1020` checkmark.