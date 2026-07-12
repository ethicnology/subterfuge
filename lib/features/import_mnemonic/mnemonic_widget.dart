import 'package:bip39_mnemonic/bip39_mnemonic.dart' as bip39;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subterfuge/shared/errors.dart';

/// Style configuration for [MnemonicWidget].
///
/// Allows customization of dimensions, colors, text styles, and decorations.
class MnemonicWidgetStyle {
  /// Height of input fields (passphrase, word inputs) and dropdowns.
  final double inputHeight;

  /// Width of the dropdowns (Language, Length).
  final double dropdownWidth;

  /// Size of the square box displaying the word index.
  final double indexBoxSize;

  /// Border radius for all inputs and containers.
  final double borderRadius;

  /// Spacing between rows and elements.
  final double standardSpacing;

  /// Padding inside input containers.
  final double smallPadding;

  /// Horizontal padding for dropdowns and hint chips.
  final double horizontalPadding;

  /// Color used for the index box when the word is valid.
  final Color statusValidColor;

  /// Color used for the index box when the word is invalid.
  final Color statusErrorColor;

  /// Default border color.
  final Color borderColor;

  /// Text style for the number inside the index box.
  final TextStyle? indexTextStyle;

  /// Text style for the user input inside the word fields.
  final TextStyle? wordTextStyle;

  /// Text style for the auto-complete hint chips.
  final TextStyle? hintTextStyle;

  /// Text style for the error message displayed at the bottom.
  final TextStyle? errorTextStyle;

  /// Builder to completely replace the submit button.
  final Widget Function(VoidCallback onPressed)? buttonBuilder;

  /// Custom builder for standard containers (borders).
  /// Overrides [borderColor] and [borderRadius] if provided.
  final BoxDecoration Function(BuildContext, MnemonicWidgetStyle)?
  decorationBuilder;

  /// Custom builder for the status box decoration.
  /// Overrides [statusValidColor] and [statusErrorColor] if provided.
  final BoxDecoration Function(Color, MnemonicWidgetStyle)?
  statusDecorationBuilder;

  /// Custom builder for input decoration (TextFields).
  final InputDecoration Function({
    String? labelText,
    required MnemonicWidgetStyle style,
  })?
  inputDecorationBuilder;

  const MnemonicWidgetStyle({
    this.inputHeight = 45.0,
    this.dropdownWidth = 130.0,
    this.indexBoxSize = 35.0,
    this.borderRadius = 4.0,
    this.standardSpacing = 16.0,
    this.smallPadding = 4.0,
    this.horizontalPadding = 16.0,
    this.statusValidColor = Colors.green,
    this.statusErrorColor = Colors.red,
    this.borderColor = Colors.tealAccent,
    this.indexTextStyle,
    this.wordTextStyle,
    this.hintTextStyle,
    this.errorTextStyle,
    this.buttonBuilder,
    this.decorationBuilder,
    this.statusDecorationBuilder,
    this.inputDecorationBuilder,
  });

  /// Creates a copy of this style with the given fields replaced with the new values.
  MnemonicWidgetStyle copyWith({
    double? inputHeight,
    double? dropdownWidth,
    double? indexBoxSize,
    double? borderRadius,
    double? standardSpacing,
    double? smallPadding,
    double? horizontalPadding,
    Color? statusValidColor,
    Color? statusErrorColor,
    Color? borderColor,
    TextStyle? indexTextStyle,
    TextStyle? wordTextStyle,
    TextStyle? hintTextStyle,
    TextStyle? errorTextStyle,
    Widget Function(VoidCallback onPressed)? buttonBuilder,
    BoxDecoration Function(BuildContext, MnemonicWidgetStyle)?
    decorationBuilder,
    BoxDecoration Function(Color, MnemonicWidgetStyle)? statusDecorationBuilder,
    InputDecoration Function({
      String? labelText,
      required MnemonicWidgetStyle style,
    })?
    inputDecorationBuilder,
  }) {
    return MnemonicWidgetStyle(
      inputHeight: inputHeight ?? this.inputHeight,
      dropdownWidth: dropdownWidth ?? this.dropdownWidth,
      indexBoxSize: indexBoxSize ?? this.indexBoxSize,
      borderRadius: borderRadius ?? this.borderRadius,
      standardSpacing: standardSpacing ?? this.standardSpacing,
      smallPadding: smallPadding ?? this.smallPadding,
      horizontalPadding: horizontalPadding ?? this.horizontalPadding,
      statusValidColor: statusValidColor ?? this.statusValidColor,
      statusErrorColor: statusErrorColor ?? this.statusErrorColor,
      borderColor: borderColor ?? this.borderColor,
      indexTextStyle: indexTextStyle ?? this.indexTextStyle,
      wordTextStyle: wordTextStyle ?? this.wordTextStyle,
      hintTextStyle: hintTextStyle ?? this.hintTextStyle,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      buttonBuilder: buttonBuilder ?? this.buttonBuilder,
      decorationBuilder: decorationBuilder ?? this.decorationBuilder,
      statusDecorationBuilder:
          statusDecorationBuilder ?? this.statusDecorationBuilder,
      inputDecorationBuilder:
          inputDecorationBuilder ?? this.inputDecorationBuilder,
    );
  }

  BoxDecoration standardDecoration(BuildContext context) {
    if (decorationBuilder != null) return decorationBuilder!(context, this);
    return BoxDecoration(
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor),
    );
  }

  BoxDecoration statusDecoration({required Color color}) {
    if (statusDecorationBuilder != null) {
      return statusDecorationBuilder!(color, this);
    }
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
    );
  }

  InputDecoration standardInputDecoration({String? labelText}) {
    if (inputDecorationBuilder != null) {
      return inputDecorationBuilder!(labelText: labelText, style: this);
    }
    return InputDecoration(
      labelText: labelText,
      contentPadding: const EdgeInsets.only(right: 8),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
    );
  }
}

/// A full BIP-39 mnemonic entry form: per-word inputs, optional length/
/// language pickers, an optional passphrase field, and a Submit button.
///
/// Shows a suggestion bar for whichever word is currently ambiguous
/// (multiple dictionary words still match the typed prefix) — docked right
/// above the system keyboard while it's visible (phone/tablet), or floating
/// under the focused field otherwise (desktop, or a physical keyboard with
/// no on-screen one to dock against). See [_MnemonicWidgetState.build].
///
/// IMPORTANT: this reads the raw, unconsumed [MediaQueryData.viewInsets] to
/// tell whether the system keyboard is currently shown, which requires the
/// host `Scaffold` to set `resizeToAvoidBottomInset: false` — otherwise the
/// default `true` makes the Scaffold consume that inset for its own body
/// resizing and this widget always sees zero, permanently choosing the
/// floating presentation even with the keyboard up.
class MnemonicWidget extends StatefulWidget {
  final bip39.MnemonicLength length;
  final bip39.Language language;
  final Function(bip39.Mnemonic) onSubmit;
  final bool allowPassphrase;
  final bool allowLengthSelection;
  final bool allowLanguageSelection;
  final bool allowAutoFillWords;
  final MnemonicWidgetStyle? style;

  const MnemonicWidget({
    super.key,
    this.language = bip39.Language.english,
    this.length = bip39.MnemonicLength.words12,
    required this.onSubmit,
    this.allowPassphrase = true,
    this.allowLengthSelection = true,
    this.allowLanguageSelection = true,
    this.allowAutoFillWords = true,
    this.style,
  });

  @override
  State<MnemonicWidget> createState() => _MnemonicWidgetState();
}

class _MnemonicWidgetState extends State<MnemonicWidget> {
  Exception? _error;
  late bip39.MnemonicLength length;
  late bip39.Language language;
  late List<String> words;
  String passphrase = '';
  String label = '';

  // One FocusNode/LayerLink per word, owned here (rather than by
  // MnemonicSentenceWidget) because the shared suggestion bar below needs
  // both: which field is currently focused (to know what to suggest), and
  // that field's LayerLink (to anchor the floating variant under it via
  // CompositedTransformFollower).
  List<FocusNode> _focusNodes = [];
  List<LayerLink> _layerLinks = [];
  int? _focusedIndex;
  final _suggestionsController = OverlayPortalController();

  @override
  void initState() {
    super.initState();
    length = widget.length;
    language = widget.language;
    words = List<String>.filled(length.words, '');
    _initializeFocusNodes();
    _suggestionsController.show();
  }

  @override
  void dispose() {
    _disposeFocusNodes();
    super.dispose();
  }

  void _initializeFocusNodes() {
    _focusNodes = List.generate(words.length, (index) {
      final node = FocusNode();
      node.addListener(() => _handleFocusChange(index, node));
      return node;
    });
    _layerLinks = List.generate(words.length, (_) => LayerLink());
  }

  void _disposeFocusNodes() {
    for (final node in _focusNodes) {
      node.dispose();
    }
    _focusNodes = [];
    _layerLinks = [];
  }

  void _handleFocusChange(int index, FocusNode node) {
    if (node.hasFocus) {
      setState(() => _focusedIndex = index);
    } else if (_focusedIndex == index) {
      setState(() => _focusedIndex = null);
    }
  }

  /// Advances to the next field, or — for the last word — dismisses the
  /// keyboard and submits the whole form, since there's no next field to
  /// advance to. Called both for the keyboard's Next/Done action and for
  /// auto-fill/tapped-suggestion completions (see [_selectSuggestion]).
  void _completeWord(int index) {
    if (index == words.length - 1) {
      FocusScope.of(context).unfocus();
      onSubmit();
    } else if (index + 1 < _focusNodes.length) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
  }

  void _selectSuggestion(int index, String word) {
    setState(() => words[index] = word);
    _completeWord(index);
  }

  /// Schedules auto-fill for [index] for next frame, only when its typed
  /// prefix uniquely matches one dictionary word it doesn't already equal.
  ///
  /// The equality check is what stops this from rescheduling on every
  /// rebuild forever once resolved — omitting it previously caused an
  /// infinite frame-scheduling loop that pinned the UI thread at 100% CPU
  /// (see git history on this file).
  void _maybeScheduleAutoFill(int index, List<String> hints) {
    if (!widget.allowAutoFillWords || hints.length != 1) return;
    final word = words[index];
    final resolved = hints.first;
    if (word.isEmpty || resolved == word) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _focusedIndex != index || words[index] != word) {
        return; // Stale: focus or text changed since this was scheduled.
      }
      _selectSuggestion(index, resolved);
    });
  }

  List<String> _hintsFor(int? index) {
    if (index == null) return const [];
    final word = words[index];
    if (word.isEmpty) return const [];
    return language.list.where((candidate) => candidate.startsWith(word)).toList();
  }

  void onSubmit() {
    setState(() => _error = null);

    if (words.every((word) => word.isNotEmpty)) {
      try {
        final mnemonic = bip39.Mnemonic.fromWords(
          words: words,
          language: language,
          passphrase: passphrase,
        );
        widget.onSubmit(mnemonic);
      } catch (e) {
        // if checksum is invalid, clear the last word
        if (e is bip39.MnemonicInvalidChecksumException) words.last = '';
        // Note: bip39_mnemonic's own exceptions embed the offending word(s)
        // in their message. We deliberately do not forward that text
        // (see MnemonicException docs) and show a fixed, safe message instead.
        setState(() => _error = _mapMnemonicException(e));
        return;
      }
    } else {
      setState(() => _error = EmptyMnemonicWordsError());
    }
  }

  /// Maps an exception thrown while validating/building the mnemonic to a
  /// fixed, safe [MnemonicException]. Never forwards `e.toString()` for
  /// bip39_mnemonic exceptions: they embed the actual word(s) the user typed
  /// (see [bip39.MnemonicWordNotFoundException] and
  /// [bip39.MnemonicInvalidChecksumException]).
  MnemonicException _mapMnemonicException(Object e) {
    if (e is bip39.MnemonicInvalidChecksumException) {
      return MnemonicException('Invalid checksum. Please review your words.');
    }
    if (e is bip39.MnemonicWordNotFoundException) {
      return MnemonicException('One or more words are not valid BIP-39 words.');
    }
    if (e is bip39.MnemonicException) {
      return MnemonicException('Invalid mnemonic. Please check your words.');
    }
    return MnemonicException('Unexpected error. Please check your words.');
  }

  void updateMnemonic(({int index, String word}) value) {
    words[value.index] = value.word;
    setState(() {});
  }

  void updatePassphrase(String value) {
    passphrase = value;
    setState(() {});
  }

  void changeMnemonicLength(bip39.MnemonicLength length) {
    this.length = length;
    words = List<String>.filled(length.words, '');
    _disposeFocusNodes();
    _initializeFocusNodes();
    setState(() {
      _error = null;
      _focusedIndex = null;
    });
  }

  void changeMnemonicLanguage(bip39.Language language) {
    this.language = language;
    words = List<String>.filled(length.words, '');
    _disposeFocusNodes();
    _initializeFocusNodes();
    setState(() {
      _error = null;
      _focusedIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? const MnemonicWidgetStyle();
    final focusedIndex = _focusedIndex;
    final hints = _hintsFor(focusedIndex);
    if (focusedIndex != null) _maybeScheduleAutoFill(focusedIndex, hints);

    // A field's suggestions are worth showing whenever its typed prefix is
    // ambiguous (multiple dictionary words still match): an unambiguous
    // single match is handled by auto-fill instead (see
    // _maybeScheduleAutoFill) and never reaches here.
    final hasSuggestions = focusedIndex != null && hints.length > 1;

    // `viewInsets.bottom` is the system keyboard's height while it's shown
    // — see MnemonicWidget's class doc for why the host must disable
    // Scaffold's own keyboard avoidance for this to be meaningful here.
    // While it's up (typically a phone/tablet's on-screen keyboard),
    // suggestions dock in the same place a predictive-text bar normally
    // sits: right above it, full width. Otherwise (desktop, or a physical
    // keyboard with no on-screen one to dock against) they float in a small
    // card anchored directly under the focused field instead.
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final dockedVisible = hasSuggestions && keyboardHeight > 0;
    final floatingVisible = hasSuggestions && keyboardHeight == 0;
    final dockedBarHeight = style.inputHeight + style.standardSpacing;

    final content = SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: keyboardHeight + (dockedVisible ? dockedBarHeight : 0),
      ),
      child: Column(
        children: [
          if (widget.allowLanguageSelection || widget.allowLengthSelection) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: style.standardSpacing,
              children: [
                if (widget.allowLanguageSelection) ...[
                  MnemonicLanguageDropdown(
                    value: language,
                    onChanged: changeMnemonicLanguage,
                    style: style,
                  ),
                ],
                if (widget.allowLengthSelection) ...[
                  MnemonicLengthDropdown(
                    value: length,
                    onChanged: changeMnemonicLength,
                    style: style,
                  ),
                ],
              ],
            ),
            SizedBox(height: style.standardSpacing),
          ],
          MnemonicSentenceWidget(
            words: words,
            language: language,
            onWordChanged: updateMnemonic,
            style: style,
            focusNodes: _focusNodes,
            layerLinks: _layerLinks,
            onWordComplete: _completeWord,
          ),
          if (widget.allowPassphrase) ...[
            SizedBox(height: style.standardSpacing),
            Container(
              padding: EdgeInsets.all(style.smallPadding),
              decoration: style.standardDecoration(context),
              height: style.inputHeight,
              child: TextField(
                decoration: style.standardInputDecoration(
                  labelText: 'Passphrase (optional)',
                ),
                onChanged: updatePassphrase,
                maxLines: 1,
              ),
            ),
          ],
          if (_error != null) ...[
            SizedBox(height: style.standardSpacing),
            Text(
              _error!.toString(),
              style:
                  style.errorTextStyle ??
                  TextStyle(color: style.statusErrorColor),
            ),
          ],
          SizedBox(height: style.standardSpacing),
          style.buttonBuilder != null
              ? style.buttonBuilder!(onSubmit)
              : FilledButton(onPressed: onSubmit, child: Text('Submit')),
        ],
      ),
    );

    return Stack(
      children: [
        Positioned.fill(child: content),
        // Wrapped in Positioned.fill (rather than left bare) so this
        // doesn't count as Stack's one "non-positioned" child: a bare,
        // non-Positioned OverlayPortal has ~zero intrinsic size in its own
        // normal-flow slot (its actual content renders elsewhere, in the
        // Overlay), which would make the whole Stack collapse to that size
        // instead of filling the available space.
        Positioned.fill(
          child: OverlayPortal(
            controller: _suggestionsController,
            overlayChildBuilder: (context) {
              if (!floatingVisible) return const SizedBox.shrink();
              return CompositedTransformFollower(
                link: _layerLinks[focusedIndex],
                targetAnchor: Alignment.bottomLeft,
                followerAnchor: Alignment.topLeft,
                offset: const Offset(0, 4),
                // The Overlay gives its entries tight, full-size
                // constraints (the same way a Stack does for a
                // non-Positioned child) — without this Align, that would
                // force _SuggestionsCard to expand to fill the entire
                // window instead of respecting its own explicit width/
                // height, since Align (unlike most widgets) always passes
                // loose constraints down to its child regardless of what
                // it itself receives.
                // The Overlay gives its entries tight, full-size
                // constraints (the same way a Stack does for a
                // non-Positioned child) — without this Align, that would
                // force _SuggestionsCard to expand to fill the entire
                // window instead of respecting its own explicit width/
                // height, since Align (unlike most widgets) always passes
                // loose constraints down to its child regardless of what
                // it itself receives.
                child: Align(
                  alignment: Alignment.topLeft,
                  child: _SuggestionsCard(
                    hints: hints,
                    style: style,
                    width: 220,
                    onSelect: (word) => _selectSuggestion(focusedIndex, word),
                  ),
                ),
              );
            },
          ),
        ),
        if (dockedVisible)
          Positioned(
            left: 0,
            right: 0,
            bottom: keyboardHeight,
            child: _SuggestionsCard(
              hints: hints,
              style: style,
              onSelect: (word) => _selectSuggestion(focusedIndex, word),
            ),
          ),
      ],
    );
  }
}

/// A horizontally-scrollable row of candidate words, shared by both the
/// "docked above the keyboard" and "floating under the field" presentations
/// of [MnemonicWidget]'s suggestion bar.
class _SuggestionsCard extends StatelessWidget {
  final List<String> hints;
  final MnemonicWidgetStyle style;
  final ValueChanged<String> onSelect;

  /// Constrains the card to a fixed width for the floating (anchored)
  /// presentation. `null` (the default) makes it stretch full-width, for
  /// the bar docked above the keyboard.
  final double? width;

  const _SuggestionsCard({
    required this.hints,
    required this.style,
    required this.onSelect,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    // Without this, a mouse click (desktop) on a chip first unfocuses the
    // word field this card belongs to — EditableText's default "tap
    // outside" handling, which only exempts *touch* events, not mouse
    // clicks — which tears this whole card down before the click actually
    // reaches _HintChip's onTap. TextFieldTapRegion tells that machinery
    // this card counts as part of the field, not "outside" it.
    return TextFieldTapRegion(
      child: Material(
        child: Container(
          width: width,
          height: style.inputHeight,
          padding: EdgeInsets.all(style.smallPadding),
          decoration: style.standardDecoration(context),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: hints.length,
            separatorBuilder: (_, _) => SizedBox(width: style.standardSpacing),
            itemBuilder: (context, index) {
              final hint = hints[index];
              return _HintChip(
                word: hint,
                onTap: () => onSelect(hint),
                style: style,
              );
            },
          ),
        ),
      ),
    );
  }
}

class MnemonicWord extends StatefulWidget {
  final bip39.Language language;
  final int index;
  final Function(({int index, String word})) onWordChanged;
  final FocusNode focusNode;

  /// Called both when the keyboard's action button (Next/Done) is pressed,
  /// and when [word] is auto-filled/selected from a single/tapped
  /// suggestion — in both cases the "this field is done" semantics are the
  /// same: move on (to the next field, or to submitting the form for the
  /// last one).
  final VoidCallback onComplete;

  /// Called when Backspace is pressed while this field is already empty —
  /// moves focus to the previous field, mirroring the common "OTP input"
  /// pattern, so correcting an earlier word doesn't require reaching up to
  /// tap it.
  final VoidCallback onBackspaceEmpty;
  final String word;
  final MnemonicWidgetStyle style;
  final TextInputAction textInputAction;

  const MnemonicWord({
    super.key,
    this.language = bip39.Language.english,
    required this.index,
    required this.word,
    required this.onWordChanged,
    required this.focusNode,
    required this.onComplete,
    required this.onBackspaceEmpty,
    required this.style,
    this.textInputAction = TextInputAction.next,
  });

  @override
  State<MnemonicWord> createState() => MnemonicWordState();
}

class MnemonicWordState extends State<MnemonicWord> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.word;
    HardwareKeyboard.instance.addHandler(_handleKeyEvent);
  }

  @override
  void didUpdateWidget(MnemonicWord oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.word != oldWidget.word && widget.word != _controller.text) {
      _controller.text = widget.word;
    }
  }

  @override
  void dispose() {
    HardwareKeyboard.instance.removeHandler(_handleKeyEvent);
    _controller.dispose();
    super.dispose();
  }

  // Backspace produces no text-change event at all when the field is
  // already empty (there's nothing to delete), so `onChanged` never fires
  // for it — this is why it must be observed as a raw hardware key event
  // instead. Registered globally (rather than via a wrapping
  // `KeyboardListener`/`Focus.onKeyEvent`) to avoid re-parenting
  // [widget.focusNode], which is already attached to this field's
  // [TextField] and shouldn't be attached to two `Focus` nodes at once.
  //
  // NOTE: this only fires for a *physical* keyboard (desktop, or one
  // attached to a phone/tablet) — most on-screen software keyboards don't
  // synthesize a raw backspace key event when the field is already empty,
  // only their own text-editing protocol, which produces nothing to
  // observe here. There's no reliable, cross-IME way to detect that case;
  // this is a best-effort enhancement for physical keyboards, not a
  // substitute for the pointer-based recovery already offered by the
  // "clear" (X) button.
  bool _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace &&
        widget.focusNode.hasFocus &&
        _controller.text.isEmpty) {
      widget.onBackspaceEmpty();
    }
    return false; // Never claims the event: normal editing must still work.
  }

  String get displayIndex {
    final displayIndex = widget.index + 1;
    return displayIndex < 10 ? '0$displayIndex' : '$displayIndex';
  }

  @override
  Widget build(BuildContext context) {
    final isValidWord = widget.language.isValid(widget.word);
    final style = widget.style;

    return Container(
      padding: EdgeInsets.all(style.smallPadding),
      decoration: style.standardDecoration(context),
      height: style.inputHeight,
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: style.indexBoxSize,
                width: style.indexBoxSize,
                alignment: Alignment.center,
                decoration: style.statusDecoration(
                  color: widget.word.isEmpty
                      ? style.borderColor
                      : isValidWord
                      ? style.statusValidColor
                      : style.statusErrorColor,
                ),
                child: Text(
                  displayIndex,
                  style:
                      style.indexTextStyle ??
                      const TextStyle(color: Colors.black),
                ),
              ),
              // Redundant non-color cue for word validity (checkmark vs.
              // cross), so status doesn't rely on the green/red hue alone —
              // ~8% of men have red/green color vision deficiency.
              if (widget.word.isNotEmpty)
                Positioned(
                  right: -4,
                  bottom: -4,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isValidWord
                          ? Icons.check_rounded
                          : Icons.priority_high_rounded,
                      size: 10,
                      color: isValidWord
                          ? style.statusValidColor
                          : style.statusErrorColor,
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
            child: TextField(
              enableSuggestions: false,
              autocorrect: false,
              controller: _controller,
              style: style.wordTextStyle,
              onChanged: (value) {
                widget.onWordChanged((
                  index: widget.index,
                  word: _controller.text,
                ));
              },
              focusNode: widget.focusNode,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              textInputAction: widget.textInputAction,
              onEditingComplete: widget.onComplete,
              decoration: style.standardInputDecoration(),
            ),
          ),
          if (_controller.text.isNotEmpty || isValidWord)
            IconButton(
              onPressed: () {
                _controller.clear();
                widget.onWordChanged((index: widget.index, word: ''));
              },
              icon: const Icon(Icons.close, size: 24),
              padding: EdgeInsets.zero,
            ),
        ],
      ),
    );
  }
}

class MnemonicSentenceWidget extends StatefulWidget {
  static const int columns = 2;
  final List<String> words;
  final bip39.Language language;
  final Function(({int index, String word})) onWordChanged;
  final MnemonicWidgetStyle style;

  /// One per word, owned by the parent [MnemonicWidget] (which also needs
  /// them to track which field is currently focused, for the shared
  /// suggestion bar — see [MnemonicWidget]).
  final List<FocusNode> focusNodes;

  /// One per word, likewise owned by the parent: each word is wrapped in a
  /// [CompositedTransformTarget] using its link, so the parent's floating
  /// suggestion overlay can anchor itself under whichever field currently
  /// has focus via [CompositedTransformFollower].
  final List<LayerLink> layerLinks;

  /// Called when a field is "done": either its keyboard action (Next/Done)
  /// was pressed, or it was auto-filled to an unambiguous word. Takes the
  /// completed field's index; advancing to the next field or submitting the
  /// whole form (for the last word) is entirely up to the parent.
  final ValueChanged<int> onWordComplete;

  const MnemonicSentenceWidget({
    super.key,
    required this.words,
    required this.language,
    required this.onWordChanged,
    required this.style,
    required this.focusNodes,
    required this.layerLinks,
    required this.onWordComplete,
  });

  @override
  State<MnemonicSentenceWidget> createState() => _MnemonicSentenceWidgetState();
}

class _MnemonicSentenceWidgetState extends State<MnemonicSentenceWidget> {
  void _focusPrevious(int index) {
    final previousIndex = index - 1;
    if (previousIndex >= 0 && previousIndex < widget.focusNodes.length) {
      FocusScope.of(context).requestFocus(widget.focusNodes[previousIndex]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style;
    final splitIndex = (widget.words.length / MnemonicSentenceWidget.columns)
        .floor();
    final leftWords = List.generate(
      splitIndex,
      (i) => (index: i, word: widget.words[i]),
    );
    final rightWords = List.generate(
      widget.words.length - splitIndex,
      (i) => (index: i + splitIndex, word: widget.words[i + splitIndex]),
    );

    Widget buildWord(({int index, String word}) entry) {
      return CompositedTransformTarget(
        link: widget.layerLinks[entry.index],
        child: MnemonicWord(
          index: entry.index,
          word: entry.word,
          language: widget.language,
          onWordChanged: widget.onWordChanged,
          focusNode: widget.focusNodes[entry.index],
          onComplete: () => widget.onWordComplete(entry.index),
          onBackspaceEmpty: () => _focusPrevious(entry.index),
          textInputAction: entry.index == widget.words.length - 1
              ? TextInputAction.done
              : TextInputAction.next,
          style: style,
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: style.standardSpacing,
      children: [
        Expanded(
          child: Column(
            spacing: style.standardSpacing,
            children: leftWords.map(buildWord).toList(),
          ),
        ),
        Expanded(
          child: Column(
            spacing: style.standardSpacing,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rightWords.map(buildWord).toList(),
          ),
        ),
      ],
    );
  }
}

class MnemonicLengthDropdown extends StatelessWidget {
  final bip39.MnemonicLength value;
  final Function(bip39.MnemonicLength) onChanged;
  final MnemonicWidgetStyle style;

  const MnemonicLengthDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: style.dropdownWidth,
      height: style.inputHeight,
      padding: EdgeInsets.symmetric(horizontal: style.horizontalPadding),
      decoration: style.standardDecoration(context),
      child: DropdownButton<bip39.MnemonicLength>(
        value: value,
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(4),
        isExpanded: true,
        items: bip39.MnemonicLength.values
            .map(
              (length) => DropdownMenuItem(
                value: length,
                child: Text('${length.words} words'),
              ),
            )
            .toList(),
        onChanged: (v) => onChanged(v ?? bip39.MnemonicLength.words12),
      ),
    );
  }
}

class MnemonicLanguageDropdown extends StatelessWidget {
  final bip39.Language value;
  final Function(bip39.Language) onChanged;
  final MnemonicWidgetStyle style;

  const MnemonicLanguageDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.style,
  });

  String _getLanguageDisplayName(bip39.Language language) {
    switch (language) {
      case bip39.Language.english:
        return 'English';
      case bip39.Language.french:
        return 'Français';
      case bip39.Language.spanish:
        return 'Español';
      case bip39.Language.italian:
        return 'Italiano';
      case bip39.Language.portuguese:
        return 'Português';
      case bip39.Language.czech:
        return 'Čeština';
      case bip39.Language.korean:
        return '한국어';
      case bip39.Language.simplifiedChinese:
        return '简体中文';
      case bip39.Language.traditionalChinese:
        return '繁體中文';
      case bip39.Language.japanese:
        return '日本語';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: style.dropdownWidth,
      height: style.inputHeight,
      padding: EdgeInsets.symmetric(horizontal: style.horizontalPadding),
      decoration: style.standardDecoration(context),
      child: DropdownButton<bip39.Language>(
        value: value,
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(4),
        isExpanded: true,
        items: bip39.Language.values
            .map(
              (language) => DropdownMenuItem(
                value: language,
                child: Text(_getLanguageDisplayName(language)),
              ),
            )
            .toList(),
        onChanged: (v) => onChanged(v ?? bip39.Language.english),
      ),
    );
  }
}

class _HintChip extends StatelessWidget {
  final String word;
  final VoidCallback onTap;
  final MnemonicWidgetStyle style;

  const _HintChip({
    required this.word,
    required this.onTap,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: style.horizontalPadding),
        decoration: style.standardDecoration(context),
        child: Center(child: Text(word, style: style.hintTextStyle)),
      ),
    );
  }
}

class MnemonicException extends AppError {
  MnemonicException(super.message);
}

class EmptyMnemonicWordsError extends MnemonicException {
  EmptyMnemonicWordsError() : super('Enter all words of your mnemonic');
}
