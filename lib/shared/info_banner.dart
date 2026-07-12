import 'package:flutter/material.dart';

/// Severity of an [InfoBanner], driving its color.
enum InfoBannerSeverity {
  /// Neutral, purely informational (brand teal).
  info,

  /// Something the user should double-check but that isn't an error
  /// (theme's `tertiary` color, kept visually distinct from [error] so a
  /// caution never reads as a hard failure).
  warning,
}

/// A rounded, inline banner for persistent contextual hints and warnings.
///
/// This app previously repurposed [MaterialBanner] for this (see git
/// history): that widget is designed for transient, dismissible, app-level
/// announcements, and it renders with hard square corners that clash with
/// the rounded/pill shape language used everywhere else (buttons, cards).
/// [InfoBanner] is a plain rounded [Container] instead, so it fits the rest
/// of the UI and can be embedded permanently inline without looking out of
/// place.
class InfoBanner extends StatelessWidget {
  final Widget content;
  final IconData icon;
  final InfoBannerSeverity severity;
  final Widget? action;

  const InfoBanner({
    super.key,
    required this.content,
    this.icon = Icons.info_outline_rounded,
    this.severity = InfoBannerSeverity.info,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isWarning = severity == InfoBannerSeverity.warning;
    final background = isWarning ? scheme.tertiaryContainer : scheme.primary;
    final foreground = isWarning ? scheme.onTertiaryContainer : Colors.black;
    final iconColor = isWarning ? scheme.tertiary : Colors.black;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: DefaultTextStyle.merge(
              style: TextStyle(color: foreground),
              child: content,
            ),
          ),
          if (action != null) ...[const SizedBox(width: 12), action!],
        ],
      ),
    );
  }
}
