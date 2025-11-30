import 'package:bip39_mnemonic/bip39_mnemonic.dart' as bip39;
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    length = widget.length;
    language = widget.language;
    words = List<String>.filled(length.words, '');
  }

  void onSubmit() {
    setState(() => _error = null);

    if (words.every((word) => word.isNotEmpty)) {
      try {
        final mnemonic = bip39.Mnemonic.fromWords(
          words: words,
          language: widget.language,
          passphrase: passphrase,
        );
        widget.onSubmit(mnemonic);
      } catch (e) {
        // if checksum is invalid, clear the last word
        if (e is bip39.MnemonicInvalidChecksumException) words.last = '';
        setState(() => _error = MnemonicException(e.toString()));
        return;
      }
    } else {
      setState(() => _error = EmptyMnemonicWordsError());
    }
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
    setState(() => _error = null);
  }

  void changeMnemonicLanguage(bip39.Language language) {
    this.language = language;
    words = List<String>.filled(length.words, '');
    setState(() => _error = null);
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? const MnemonicWidgetStyle();

    return SingleChildScrollView(
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
            allowAutoFillWords: widget.allowAutoFillWords,
            style: style,
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
  }
}

class MnemonicWord extends StatefulWidget {
  final bip39.Language language;
  final int index;
  final Function(({int index, String word})) onWordChanged;
  final FocusNode focusNode;
  final VoidCallback onComplete;
  final String word;
  final MnemonicWidgetStyle style;

  const MnemonicWord({
    super.key,
    this.language = bip39.Language.english,
    required this.index,
    required this.word,
    required this.onWordChanged,
    required this.focusNode,
    required this.onComplete,
    required this.style,
  });

  @override
  State<MnemonicWord> createState() => MnemonicWordState();
}

class MnemonicWordState extends State<MnemonicWord> {
  final _controller = TextEditingController();

  String get displayIndex {
    final displayIndex = widget.index + 1;
    return displayIndex < 10 ? '0$displayIndex' : '$displayIndex';
  }

  @override
  Widget build(BuildContext context) {
    final isValidWord = widget.language.isValid(widget.word);
    _controller.text = widget.word;
    final style = widget.style;

    return Container(
      padding: EdgeInsets.all(style.smallPadding),
      decoration: style.standardDecoration(context),
      height: style.inputHeight,
      child: Row(
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
                  style.indexTextStyle ?? const TextStyle(color: Colors.black),
            ),
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
  final bool allowAutoFillWords;
  final MnemonicWidgetStyle style;

  const MnemonicSentenceWidget({
    super.key,
    required this.words,
    required this.language,
    required this.onWordChanged,
    this.allowAutoFillWords = true,
    required this.style,
  });

  @override
  State<MnemonicSentenceWidget> createState() => _MnemonicSentenceWidgetState();
}

class _MnemonicSentenceWidgetState extends State<MnemonicSentenceWidget> {
  List<FocusNode> focusNodes = [];
  int _focusedDisplayIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeFocusNodes();
  }

  @override
  void didUpdateWidget(MnemonicSentenceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.words.length != widget.words.length) {
      _disposeFocusNodes();
      _initializeFocusNodes();
      _focusedDisplayIndex = 0;
    }
  }

  @override
  void dispose() {
    _disposeFocusNodes();
    super.dispose();
  }

  void _initializeFocusNodes() {
    focusNodes = List.generate(
      widget.words.length,
      (index) => FocusNode()
        ..addListener(() {
          final focusedIndex = focusNodes.indexWhere((node) => node.hasFocus);
          if (focusedIndex != -1 && _focusedDisplayIndex != focusedIndex) {
            setState(() => _focusedDisplayIndex = focusedIndex);
          }
        }),
    );
  }

  void _disposeFocusNodes() {
    for (final node in focusNodes) {
      node.dispose();
    }
    focusNodes.clear();
  }

  void _focusNext(int nextIndex) {
    if (nextIndex < widget.words.length) {
      if (nextIndex >= 0 && nextIndex < focusNodes.length) {
        FocusScope.of(context).requestFocus(focusNodes[nextIndex]);
      }
    }
  }

  void _onHintTap(String word) {
    widget.onWordChanged((index: _focusedDisplayIndex, word: word));
    _focusNext(_focusedDisplayIndex + 1);
  }

  Widget _buildHintsList({Key? key}) {
    final style = widget.style;

    final hints = widget.language.list.where(
      (word) => word.startsWith(widget.words[_focusedDisplayIndex]),
    );

    if (widget.allowAutoFillWords && hints.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _onHintTap(hints.first),
      );
    }

    if (hints.length == 1 &&
        hints.first == widget.words[_focusedDisplayIndex]) {
      return SizedBox(height: style.inputHeight);
    }

    return SizedBox(
      key: key,
      height: style.inputHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: hints.length,
        separatorBuilder: (_, _) => SizedBox(width: style.standardSpacing),
        itemBuilder: (context, index) {
          final hint = hints.elementAt(index);
          return _HintChip(
            word: hint,
            onTap: () => _onHintTap(hint),
            style: style,
          );
        },
      ),
    );
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

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: style.standardSpacing,
          children: [
            Expanded(
              child: Column(
                spacing: style.standardSpacing,
                children: leftWords
                    .map(
                      (entry) => MnemonicWord(
                        index: entry.index,
                        word: entry.word,
                        onWordChanged: widget.onWordChanged,
                        focusNode: focusNodes[entry.index],
                        onComplete: () => _focusNext(entry.index + 1),
                        style: style,
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: Column(
                spacing: style.standardSpacing,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: rightWords
                    .map(
                      (entry) => MnemonicWord(
                        index: entry.index,
                        word: entry.word,
                        onWordChanged: widget.onWordChanged,
                        focusNode: focusNodes[entry.index],
                        onComplete: () => _focusNext(entry.index + 1),
                        style: style,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
        SizedBox(height: style.standardSpacing),
        _buildHintsList(key: ValueKey(_focusedDisplayIndex)),
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
