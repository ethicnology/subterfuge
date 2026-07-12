import 'dart:ui';

import 'package:flutter/material.dart';

/// Wraps sensitive content (a mnemonic, a share, an extended public key…) so
/// it starts blurred and only becomes visible after the user explicitly
/// taps to reveal it.
///
/// This is a pure UX/privacy mitigation, not a security boundary — the
/// underlying text is still selectable/copyable once revealed, exactly as
/// before. Combined with the screen-capture protections already in place
/// (FLAG_SECURE on Android, a privacy overlay on iOS, `NSWindowSharingType
/// .none` on macOS), it narrows the window during which a secret is
/// legible on screen, e.g. while transcribing it in a semi-public place.
class RevealableSecret extends StatefulWidget {
  final Widget child;
  final BorderRadius borderRadius;

  /// Starts revealed. Useful for content the user is actively typing
  /// (inputs), as opposed to content being displayed back to them.
  final bool initiallyRevealed;

  const RevealableSecret({
    super.key,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.initiallyRevealed = false,
  });

  @override
  State<RevealableSecret> createState() => _RevealableSecretState();
}

class _RevealableSecretState extends State<RevealableSecret> {
  late bool _revealed = widget.initiallyRevealed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (!_revealed)
          Positioned.fill(
            child: ClipRRect(
              borderRadius: widget.borderRadius,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => setState(() => _revealed = true),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: Container(
                    color: Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.35),
                    alignment: Alignment.center,
                    child: _RevealHint(),
                  ),
                ),
              ),
            ),
          ),
        if (_revealed)
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              tooltip: 'Hide',
              onPressed: () => setState(() => _revealed = false),
              icon: const Icon(Icons.visibility_off_rounded, size: 20),
            ),
          ),
      ],
    );
  }
}

class _RevealHint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.visibility_rounded,
            size: 18,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          const Text('Tap to reveal'),
        ],
      ),
    );
  }
}
