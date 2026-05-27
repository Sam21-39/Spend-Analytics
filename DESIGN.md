# Spend Analytics — Design System

> **Design language**: iOS-style Liquid Glass  
> **Mode support**: Full dark & light, driven by `ThemeMode.system`  
> **Framework**: Flutter · Material 3 · Inter typeface  
> **Token file**: [lib/core/theme/liquid_glass_tokens.dart](lib/core/theme/liquid_glass_tokens.dart)

---

## Table of Contents

1. [Design Philosophy](#1-design-philosophy)
2. [Brand Identity](#2-brand-identity)
3. [Color System](#3-color-system)
4. [Typography](#4-typography)
5. [Spacing & Layout](#5-spacing--layout)
6. [Border Radius Scale](#6-border-radius-scale)
7. [Animation Tokens](#7-animation-tokens)
8. [Liquid Glass Surface](#8-liquid-glass-surface)
9. [Background System](#9-background-system)
10. [Navigation Components](#10-navigation-components)
11. [Form Elements](#11-form-elements)
12. [Semantic States](#12-semantic-states)
13. [Component Gallery](#13-component-gallery)
14. [Dark ↔ Light Mode Rules](#14-dark--light-mode-rules)
15. [Do / Don't Guidelines](#15-do--dont-guidelines)

---

## 1. Design Philosophy

Spend Analytics uses an **iOS-style Liquid Glass** design language — a visual idiom that combines:

| Principle | How it manifests |
|---|---|
| **Depth through layers** | Glow backdrop → blurred glass surface → content on top |
| **Light physics** | Specular highlights (lighter top-left edge, subtler bottom-right) |
| **Contextual transparency** | Dark mode: show the glow through thin glass · Light mode: mostly-white frosted pane |
| **Motion coherence** | Consistent easing curves (`easeOutCubic`), fast taps (160 ms), deliberate transitions (260 ms) |
| **Privacy signal** | Dark → premium / secure · Light → airy / trustworthy |

The design system is **mode-symmetric**: every token has an explicit dark and light value — there is no "default" mode that the other inherits from.

---

## 2. Brand Identity

| Element | Value |
|---|---|
| **App name** | Spend Analytics |
| **Word-mark font** | Inter 800 |
| **Logo icon** | `Icons.bar_chart_rounded` |
| **Logo container** | Rounded square, `borderRadius: 20`, `primaryContainer` tinted fill |
| **Tagline** | Your private-first financial companion |

### Word-mark usage

```
[bar_chart icon]  Spend Analytics
```

The word-mark appears in the pill app bar on every main screen. The icon is always colored `scheme.primary`; the text is `scheme.onSurface` at weight 800.

**Do not** use "SpendSense" — that was a legacy name.

---

## 3. Color System

All tokens are defined in [lib/core/theme/liquid_glass_tokens.dart](lib/core/theme/liquid_glass_tokens.dart) and exposed through [lib/core/theme/color_schemes.dart](lib/core/theme/color_schemes.dart) as `ColorScheme` objects.

### 3.1 Dark Mode (`SADark`)

| Role | Token | Hex | Usage |
|---|---|---|---|
| Background | `SADark.background` | `#080A10` | Scaffold background |
| Surface | `SADark.surface` | `#0E1018` | Base layer below glass |
| Surface container | `SADark.surfaceContainer` | `#181A26` | Elevated surfaces |
| Surface container high | `SADark.surfaceContainerHigh` | `#22263C` | Modal / dialog |
| Surface container highest | `SADark.surfaceContainerHighest` | `#2C3050` | Highest elevation |
| **Primary** | `SADark.primary` | `#5B9FFF` | Actions, active states, accents |
| Primary container | `SADark.primaryContainer` | `#0A3A7A` | FAB, active chips |
| On primary container | `SADark.onPrimaryContainer` | `#B0D0FF` | Text on FAB |
| **Secondary** | `SADark.secondary` | `#B0A0FF` | Analytics charts, budget #2 |
| **Tertiary** | `SADark.tertiary` | `#3FDDA0` | Success / "on budget" |
| **Error** | `SADark.error` | `#FF6B6B` | Over-budget, destructive |
| On Surface | `SADark.onSurface` | `#EEF0F8` | Primary text |
| On Surface Variant | `SADark.onSurfaceVariant` | `#8890AA` | Secondary text, icons |
| Outline | `SADark.outline` | `#3E4460` | Borders, dividers |
| **Warning** | `SADark.warning` | `#FFB860` | 80–99% budget usage |

#### Background glow orbs (dark)

| Orb | Token | Usage |
|---|---|---|
| Blue (top-left) | `SADark.glowBlue` `rgba(80,158,255, 0.22)` | Primary brand glow |
| Purple (mid) | `SADark.glowPurple` `rgba(130,95,255, 0.16)` | Secondary depth accent |
| Mint (bottom-right) | `SADark.glowMint` `rgba(55,220,150, 0.16)` | Success / financial accent |

---

### 3.2 Light Mode (`SALight`)

| Role | Token | Hex | Usage |
|---|---|---|---|
| Background | `SALight.background` | `#EDF0FA` | Scaffold background |
| Surface | `SALight.surface` | `#F4F6FE` | Base layer below glass |
| Surface container | `SALight.surfaceContainer` | `#E6EAF8` | Cards, sheets |
| Surface container high | `SALight.surfaceContainerHigh` | `#DAD FF2` | Dialogs |
| **Primary** | `SALight.primary` | `#1A6FFF` | Actions, active states |
| Primary container | `SALight.primaryContainer` | `#D4E7FF` | FAB, active chips |
| On primary container | `SALight.onPrimaryContainer` | `#002E7A` | Text on FAB |
| **Secondary** | `SALight.secondary` | `#7B57FF` | Analytics, budget #2 |
| **Tertiary** | `SALight.tertiary` | `#00B882` | Success / "on budget" |
| **Error** | `SALight.error` | `#D32F2F` | Over-budget, destructive |
| On Surface | `SALight.onSurface` | `#0D0F1C` | Primary text |
| On Surface Variant | `SALight.onSurfaceVariant` | `#565C7A` | Secondary text, icons |
| Outline | `SALight.outline` | `#B0B6D0` | Borders, dividers |
| **Warning** | `SALight.warning` | `#E67E00` | 80–99% budget usage |

#### Background glow orbs (light)

| Orb | Token | Usage |
|---|---|---|
| Blue (top-left) | `SALight.glowBlue` `rgba(26,111,255, 0.13)` | Pastel brand glow |
| Purple (mid) | `SALight.glowPurple` `rgba(123,87,255, 0.09)` | Secondary depth |
| Mint (bottom-right) | `SALight.glowMint` `rgba(0,184,130, 0.09)` | Success accent |

---

### 3.3 Semantic Color Usage

| State | Dark token | Light token | Context |
|---|---|---|---|
| **Safe** | `SADark.tertiary` `#3FDDA0` | `SALight.tertiary` `#00B882` | Budget < 80% |
| **Warning** | `SADark.warning` `#FFB860` | `SALight.warning` `#E67E00` | Budget 80–99% |
| **Danger** | `SADark.error` `#FF6B6B` | `SALight.error` `#D32F2F` | Budget ≥ 100% |
| **Info** | `SADark.info` `#5B9FFF` | `SALight.info` `#1A6FFF` | Neutral alerts |

---

## 4. Typography

**Typeface**: Inter (via `google_fonts`)  
**Scale**: Material 3 text roles, customised

| Role | Weight | Size | Letter-spacing | Usage |
|---|---|---|---|---|
| `displayLarge` | 800 | 57 | −2.0 | (reserved) |
| `displayMedium` | 800 | 45 | −1.4 | (reserved) |
| `displaySmall` | 700 | 36 | −0.8 | Login hero amount |
| `headlineLarge` | 800 | 32 | −0.8 | Page titles |
| `headlineMedium` | 700 | 28 | −0.5 | Section headings |
| `headlineSmall` | 700 | 24 | −0.3 | Card metric values |
| `titleLarge` | 700 | 22 | — | App bar word-mark |
| `titleMedium` | 600 | 16 | — | Card headers, chips |
| `titleSmall` | 600 | 14 | — | List item titles |
| `bodyLarge` | 400 | 16 | — | Body text, line-height 1.45 |
| `bodyMedium` | 400 | 14 | — | Secondary body |
| `bodySmall` | 400 | 12 | — | Captions, timestamps |
| `labelLarge` | 600 | 14 | 0.3 | Buttons, section labels |

### Usage rules

- Never use `bodySmall` for primary information.
- `displaySmall` is reserved for the amount field on the Add Transaction screen.
- All monetary amounts use `fontWeight: FontWeight.w800` to signal importance.
- Date labels use `labelLarge` with `letterSpacing: 1.1`.

---

## 5. Spacing & Layout

The app uses an **8-point grid**:

| Size | px | Usage |
|---|---|---|
| `xs` | 4 | Icon-to-text gap in tight rows |
| `sm` | 8 | Card internal spacing, sibling gap |
| `md` | 12 | Standard sibling section gap |
| `lg` | 16 | Screen edge padding, primary section gap |
| `xl` | 20 | Bottom nav horizontal padding |
| `xxl` | 24 | Between glass cards |
| `xxxl` | 32 | Large section breaks |

### Page structure

```
SafeArea
 ├─ App bar pill  [16 px horizontal, 10 px top]
 └─ SingleChildScrollView
      padding: left 16, right 16, top 16,
               bottom 116 (with nav) | 24 (without)
      ├─ Page title (headlineMedium)
      ├─ 16 px gap
      └─ Glass cards (24 px gap between them)
```

### Bottom nav clearance

Content must not be occluded by the floating bottom nav. The `LiquidPageScaffold` automatically applies `116 px` bottom padding when `showBottomNav: true`.

---

## 6. Border Radius Scale

```dart
SARadius.xs   → 10 px   // input corners, small chips
SARadius.sm   → 14 px   // buttons, type selectors
SARadius.md   → 20 px   // standard glass card (default)
SARadius.lg   → 24 px   // large glass card, modal bottom sheet
SARadius.xl   → 28 px   // dialogs, login hero card
SARadius.full → 999 px  // pills: bottom nav, app bar, choice chips
```

---

## 7. Animation Tokens

```dart
SAAnimation.fast     → 160 ms   // button press feedback, chip toggle
SAAnimation.standard → 260 ms   // page transitions, sheet appear
SAAnimation.slow     → 400 ms   // onboarding entrance, lottie sequences
SAAnimation.spring   → Curves.easeOutCubic  // all interactive transitions
SAAnimation.ease     → Curves.easeInOut     // looping / ambient animations
```

**No linear animations** outside loading indicators — all UI transitions use `easeOutCubic`.

---

## 8. Liquid Glass Surface

**Widget**: [lib/shared/widgets/liquid_glass_surface.dart](lib/shared/widgets/liquid_glass_surface.dart)

The foundational glass panel primitive. Every card, modal, and nav element uses this widget.

### Anatomy

```
┌──────────────────────────────────────────────┐  ← Container: border + shadow
│░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│  ← ClipRRect (clips blur)
│▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│  ← BackdropFilter (blur σ=26)
│░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│  ← Container: specular gradient fill
│                  content                     │  ← child widget
└──────────────────────────────────────────────┘
```

### Glass parameters

| Parameter | Dark mode | Light mode |
|---|---|---|
| White fill opacity | `0.09` (9%) | `0.64` (64%) |
| Blur sigma | `26.0` | `26.0` |
| Border opacity (white) | `0.15` | — |
| Border opacity (black) | — | `0.09` |
| Border width | `0.8 px` | `0.8 px` |
| Shadow color / blur | `rgba(0,0,0, 0.30)` / `32` | `rgba(0,0,0, 0.08)` / `20` |
| Shadow offset | `(0, 12)` | `(0, 6)` |

### Specular highlight gradient

The gradient runs **top-left → bottom-right** to simulate light hitting the glass from the upper-left — the iOS default light direction.

| Layer | Dark | Light |
|---|---|---|
| Top-left (bright edge) | `fill + 0.07` | `fill + 0.10` |
| Bottom-right (shadow edge) | `fill − 0.04` | `fill − 0.15` |

### API

```dart
LiquidGlassSurface(
  child: ...,

  // Optional overrides
  padding:     const EdgeInsets.all(16),      // default
  margin:      null,                           // default: no margin
  borderRadius: SARadius.md,                  // default: 20 px
  blur:        SAGlass.blurSigma,             // default: 26.0
  fillOpacity: null,                          // null = auto (dark 0.09, light 0.64)
)
```

### Variants in practice

| Use case | `fillOpacity` | `blur` | `borderRadius` |
|---|---|---|---|
| Content card (default) | auto | 26 | `SARadius.md` (20) |
| App bar pill | `0.11` / `0.68` | 32 | `SARadius.full` |
| Bottom nav pill | `0.13` / `0.70` | 32 | `SARadius.full` |
| Login hero card | auto | 26 | `SARadius.xl` (28) |
| Bottom sheet | auto | 26 | top 28, bottom 0 |

---

## 9. Background System

**Widget**: [lib/shared/widgets/liquid_glass_background.dart](lib/shared/widgets/liquid_glass_background.dart)

The ambient glow backdrop is three overlapping `RadialGradient` orbs on top of a solid base color, all inside an `IgnorePointer`.

### Orb positions

| Orb | Center | Radius | Role |
|---|---|---|---|
| Blue | `(-0.80, -0.72)` | `0.90` | Brand accent, top-left |
| Purple | `(0.35, -0.10)` | `0.70` | Depth/dimension, upper mid |
| Mint | `(0.88, 0.82)` | `0.95` | Success / financial, bottom-right |

### Mode differences

| Element | Dark | Light |
|---|---|---|
| Base color | `#080A10` | `#EDF0FA` |
| Blue glow | `rgba(80,158,255, 0.22)` | `rgba(26,111,255, 0.13)` |
| Purple glow | `rgba(130,95,255, 0.16)` | `rgba(123,87,255, 0.09)` |
| Mint glow | `rgba(55,220,150, 0.16)` | `rgba(0,184,130, 0.09)` |

The light mode orbs are ~40% less intense — enough to create depth without washing out the predominantly white glass panels above them.

---

## 10. Navigation Components

### 10.1 App Bar Pill

Rendered by `LiquidPageScaffold`. A full-width frosted pill containing:

```
[bar_chart icon 18px]  [Spend Analytics weight 800]  [SPACER]  [action icons]
```

- Shape: `SARadius.full` (999 px)
- Padding: `horizontal 16, vertical 11`
- Fill opacity: `0.11` dark / `0.68` light
- Blur: `32`

### 10.2 Floating Bottom Navigation

**Widget**: [lib/shared/widgets/liquid_bottom_nav.dart](lib/shared/widgets/liquid_bottom_nav.dart)

A floating pill with 4 tab items. Positioned `28 px` from the bottom, `20 px` from each side edge.

#### Items

| Tab | Default icon | Active icon | Route |
|---|---|---|---|
| Home | `home_outlined` | `home_rounded` | `/dashboard` |
| Analytics | `analytics_outlined` | `analytics_rounded` | `/analytics` |
| Budgets | `account_balance_wallet_outlined` | `account_balance_wallet_rounded` | `/budgets` |
| Rules | `auto_awesome_outlined` | `auto_awesome_rounded` | `/rules` |

#### Active state

When a tab is active:
- Icon switches to the filled variant
- A transparent pill highlight (`primary` at 14% opacity) wraps the icon via `AnimatedContainer` (220 ms, `easeOutCubic`)
- Icon color = `scheme.primary`
- Inactive icon color = `scheme.onSurfaceVariant` at 55%

---

## 11. Form Elements

### Input fields

Uses Material 3 `InputDecorationTheme`:

- Fill: `white 6%` (dark) / `black 4%` (light)
- Border radius: `SARadius.sm` (14 px)
- Border: `white 12%` (dark) / `black 10%` (light) at 1.0 px
- Focused border: `scheme.primary` at 1.5 px
- Error border: `scheme.error` at 1.5 px

### Choice chips (category selector)

- Shape: `StadiumBorder` (full-round pill)
- Unselected fill: `white 8%` (dark) / `black 5%` (light)
- Selected fill: `scheme.primaryContainer`
- Border: `0.8 px` at 10% opacity

### Type selector buttons (`_TypeButton`)

- Shape: `borderRadius 14`
- Active: `white 12%` fill + `scheme.primary` 80% border
- Inactive: transparent fill + `white 12%` border
- Transition: `AnimatedContainer` at 220 ms

### Filled button

- Shape: `SARadius.sm` (14 px)
- Full-height pill when `minimumSize: Size.fromHeight(54)` with `borderRadius: 999`
- Font: `titleMedium` weight 700

---

## 12. Semantic States

### Budget progress bar

| Usage % | Color | Status icon |
|---|---|---|
| 0 – 79% | `SADark.tertiary` / `SALight.tertiary` (mint/green) | `check_circle_rounded` |
| 80 – 99% | `SADark.warning` / `SALight.warning` (amber) | `warning_amber_rounded` |
| ≥ 100% | `SADark.error` / `SALight.error` (red) | `error_rounded` |

### Rule alert badges

| Rule | Icon | Accent |
|---|---|---|
| Budget threshold crossed | `warning_amber_rounded` | `scheme.error` |
| Daily limit crossed | `trending_up_rounded` | `scheme.primary` |
| Notification | `notifications_active_rounded` | `scheme.primary` |

### Guest mode banner

Shown at the top of `DashboardScreen` when `isGuestMode.value == true`:
- Icon: `cloud_off_rounded`
- Action button: `Sync Now` → navigates to `/login`
- Tint: standard glass (no special color — guest is neutral, not a warning)

---

## 13. Component Gallery

### LiquidGlassSurface

The base glass card. Used directly or through higher-level components.

```
╔══════════════════════════════╗  ← border 0.8 px (white 15% / black 9%)
║                              ║
║  ← blur σ=26 ──────────────→ ║
║                              ║
║  Content goes here           ║  ← 16 px padding all sides
║                              ║
╚══════════════════════════════╝  ← shadow 30% / 8%
```

---

### SpendCard

A key-value metric card built on `LiquidGlassSurface`.

```
╔════════════════════════════════╗
║  [icon box 36×36]  TITLE LABEL ║  ← labelLarge, onSurfaceVariant
║                                ║
║  ₹12,450                       ║  ← headlineSmall, weight 800
║  ↑ 8% vs last month            ║  ← bodySmall, onSurfaceVariant
╚════════════════════════════════╝
```

Props: `title`, `value`, `icon?`, `accentColor?`, `subtitle?`, `onTap?`

---

### LiquidPageScaffold

Full-page layout wrapper:

```
┌─────────────────────────────────┐
│       LiquidGlassBackground     │ ← always fills screen
│  ┌───────────────────────────┐  │
│  │ [icon] Spend Analytics    │  │ ← pill app bar (full-width)
│  └───────────────────────────┘  │
│  ┌───────────────────────────┐  │
│  │ Page Title  (headlineM)   │  │
│  │                           │  │
│  │   [scrollable content]    │  │
│  │                           │  │
│  └───────────────────────────┘  │
│  ┌─────────────────────────────┐│
│  │  🏠  📊  💰  ✨            ││ ← floating bottom nav pill
│  └─────────────────────────────┘│
└─────────────────────────────────┘
```

---

### LiquidBottomNav

Floating pill navigation:

```
     ┌─────────────────────────────┐
     │  🏠  ·  📊  ·  💰  ·  ✨  │
     │  ▔▔▔                        │  ← active pill highlight
     └─────────────────────────────┘
        ↑
  20px from edge, 28px from bottom
```

Active item has a soft `primaryContainer` tinted rounded background, not an underline or bold label.

---

### Budget Progress Card

```
╔═══════════════════════════════════════╗
║  [🍔 icon]  Food                      ║
║                                       ║
║  ₹3,200 of ₹4,000       ✓ ₹800 left  ║
║  ━━━━━━━━━━━━━━━━━━━━━━━━             ║
║                           80% used ›  ║
╚═══════════════════════════════════════╝
```

---

## 14. Dark ↔ Light Mode Rules

### What must change between modes

| Element | Dark | Light |
|---|---|---|
| Background base | `#080A10` deep black | `#EDF0FA` cool white-blue |
| Glow orb intensity | 22% / 16% / 16% | 13% / 9% / 9% |
| Glass fill opacity | **9%** (thin, shows glow) | **64%** (thick, iOS frosted) |
| Glass border | white 15% | black 9% |
| Glass shadow | `rgba(0,0,0, 0.30)` · 32px | `rgba(0,0,0, 0.08)` · 20px |
| Primary text | `#EEF0F8` (near-white) | `#0D0F1C` (near-black) |
| Primary brand | `#5B9FFF` (soft electric) | `#1A6FFF` (vivid) |
| Secondary | `#B0A0FF` (lavender) | `#7B57FF` (purple) |
| Tertiary / success | `#3FDDA0` (mint) | `#00B882` (teal-green) |
| Error | `#FF6B6B` (coral red) | `#D32F2F` (material red) |
| Input fill | white 6% | black 4% |
| Input border | white 12% | black 10% |
| Chip fill | white 8% | black 5% |
| System UI overlay | `SystemUiOverlayStyle.light` | `SystemUiOverlayStyle.dark` |
| Snack bar bg | `surfaceContainerHigh` | `onSurface` (inverted) |

### What stays the same

- Border radius scale (`SARadius`)
- Animation durations and curves (`SAAnimation`)
- Blur sigma (`SAGlass.blurSigma = 26`)
- Border width (0.8 px)
- Layout geometry (padding, spacing)
- Glow orb positions

### Mode detection in widgets

All widgets read brightness from the ambient theme:

```dart
final isDark = Theme.of(context).brightness == Brightness.dark;
```

**Do not** hard-code hex values in widgets — always derive from `Theme.of(context).colorScheme` or resolve via the `isDark` boolean against the relevant token class.

---

## 15. Do / Don't Guidelines

### Glass surfaces

| ✅ Do | ❌ Don't |
|---|---|
| Use `LiquidGlassSurface` for every card | Use `Card()` directly — it has no glass effect |
| Place `LiquidGlassBackground` once per screen | Nest backgrounds — only one per `Scaffold` |
| Let `fillOpacity: null` auto-resolve | Hard-code `0.34` for both modes |
| Keep blur at default (26) unless special-casing nav | Set blur below 12 — too much content shows through |

### Color usage

| ✅ Do | ❌ Don't |
|---|---|
| Use `scheme.primary` from the color scheme | Hard-code `Color(0xFF5B9FFF)` |
| Use `scheme.onSurfaceVariant` for secondary text | Use `Colors.grey` |
| Use semantic tokens (`SADark.warning`) for budget states | Use `Colors.orange` |
| Add `withValues(alpha: 0.14)` for tinted icon containers | Use full-opacity color fills on icons |

### Typography

| ✅ Do | ❌ Don't |
|---|---|
| Use `Theme.of(context).textTheme.*` | Define `TextStyle` inline without `fontWeight` token |
| Apply `fontWeight: FontWeight.w800` to all monetary values | Display amounts in a regular weight |
| Use `letterSpacing: -0.5` or lower for headings | Use default letter-spacing on display text |

### Animation

| ✅ Do | ❌ Don't |
|---|---|
| Use `AnimatedContainer` + `easeOutCubic` | Use `AnimatedContainer` + `linear` |
| Set tap feedback to `160 ms` | Use 400 ms for button press — too sluggish |
| Use `Transition.fadeIn` for route changes | Use `Transition.native` — inconsistent across OS |

---

*Design system maintained by the Spend Analytics team · May 2026*
