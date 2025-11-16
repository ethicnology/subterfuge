import 'package:bip39_mnemonic/bip39_mnemonic.dart' as bip39;
import 'package:flutter/material.dart';
import 'package:subterfuge/shared/errors.dart';

class MnemonicWidget extends StatefulWidget {
  final bip39.MnemonicLength length;
  final bip39.Language language;
  final Function(bip39.Mnemonic) onSubmit;
  final bool allowPassphrase;
  final bool allowLengthSelection;
  final bool allowLanguageSelection;
  final bool allowAutoFillWords;

  const MnemonicWidget({
    super.key,
    this.language = bip39.Language.english,
    this.length = bip39.MnemonicLength.words12,
    required this.onSubmit,
    this.allowPassphrase = true,
    this.allowLengthSelection = true,
    this.allowLanguageSelection = true,
    this.allowAutoFillWords = true,
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
    return SingleChildScrollView(
      child: Column(
        children: [
          if (widget.allowLanguageSelection || widget.allowLengthSelection) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              spacing: 16,
              children: [
                if (widget.allowLanguageSelection) ...[
                  MnemonicLanguageDropdown(
                    value: language,
                    onChanged: changeMnemonicLanguage,
                  ),
                ],
                if (widget.allowLengthSelection) ...[
                  MnemonicLengthDropdown(
                    value: length,
                    onChanged: changeMnemonicLength,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
          ],
          MnemonicSentenceWidget(
            words: words,
            language: language,
            onWordChanged: updateMnemonic,
            allowAutoFillWords: widget.allowAutoFillWords,
          ),
          if (widget.allowPassphrase) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.teal),
                color: Colors.white,
              ),
              height: 45,
              child: TextField(
                style: const TextStyle(color: Colors.black),
                cursorColor: Colors.teal,
                decoration: const InputDecoration(
                  labelText: 'Passphrase (optional)',
                  labelStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.only(right: 8),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
                onChanged: updatePassphrase,
                maxLines: 1,
              ),
            ),
          ],
          if (_error != null) ...[
            const SizedBox(height: 16),
            Text(_error!.toString(), style: const TextStyle(color: Colors.red)),
          ],
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onSubmit, child: Text('Submit')),
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

  const MnemonicWord({
    super.key,
    this.language = bip39.Language.english,
    required this.index,
    required this.word,
    required this.onWordChanged,
    required this.focusNode,
    required this.onComplete,
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

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.teal),
        color: Colors.white,
      ),
      height: 45,
      child: Row(
        children: [
          Container(
            height: 35,
            width: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:
                  widget.word.isEmpty
                      ? Colors.black
                      : isValidWord
                      ? Colors.green
                      : Colors.red,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(displayIndex),
          ),
          Expanded(
            child: TextField(
              enableSuggestions: false,
              autocorrect: false,
              controller: _controller,
              onChanged: (value) {
                widget.onWordChanged((
                  index: widget.index,
                  word: _controller.text,
                ));
              },
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.teal,
              focusNode: widget.focusNode,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              onEditingComplete: widget.onComplete,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(right: 8),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          if (_controller.text.isNotEmpty || isValidWord)
            IconButton(
              onPressed: () {
                _controller.clear();
                widget.onWordChanged((index: widget.index, word: ''));
              },
              icon: const Icon(Icons.close, size: 24, color: Colors.black),
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

  const MnemonicSentenceWidget({
    super.key,
    required this.words,
    required this.language,
    required this.onWordChanged,
    this.allowAutoFillWords = true,
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
      (index) =>
          FocusNode()..addListener(() {
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
    const height = 45.0;
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
      return const SizedBox(height: height);
    }

    return SizedBox(
      key: key,
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: hints.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final hint = hints.elementAt(index);
          return _HintChip(word: hint, onTap: () => _onHintTap(hint));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final splitIndex =
        (widget.words.length / MnemonicSentenceWidget.columns).floor();
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
          spacing: 16,
          children: [
            Expanded(
              child: Column(
                spacing: 16,
                children:
                    leftWords
                        .map(
                          (entry) => MnemonicWord(
                            index: entry.index,
                            word: entry.word,
                            onWordChanged: widget.onWordChanged,
                            focusNode: focusNodes[entry.index],
                            onComplete: () => _focusNext(entry.index + 1),
                          ),
                        )
                        .toList(),
              ),
            ),
            Expanded(
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    rightWords
                        .map(
                          (entry) => MnemonicWord(
                            index: entry.index,
                            word: entry.word,
                            onWordChanged: widget.onWordChanged,
                            focusNode: focusNodes[entry.index],
                            onComplete: () => _focusNext(entry.index + 1),
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildHintsList(key: ValueKey(_focusedDisplayIndex)),
      ],
    );
  }
}

class MnemonicLengthDropdown extends StatelessWidget {
  final bip39.MnemonicLength value;
  final Function(bip39.MnemonicLength) onChanged;

  const MnemonicLengthDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.teal),
        color: Colors.white,
      ),
      child: DropdownButton<bip39.MnemonicLength>(
        value: value,
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(4),
        isExpanded: true,
        iconEnabledColor: Colors.black,
        focusColor: Colors.teal,
        dropdownColor: Colors.white,
        items:
            bip39.MnemonicLength.values
                .map(
                  (length) => DropdownMenuItem(
                    value: length,
                    child: Text(
                      '${length.words} words',
                      style: const TextStyle(color: Colors.black),
                    ),
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

  const MnemonicLanguageDropdown({
    super.key,
    required this.value,
    required this.onChanged,
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
      width: 130,
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.teal),
        color: Colors.white,
      ),
      child: DropdownButton<bip39.Language>(
        dropdownColor: Colors.white,
        iconEnabledColor: Colors.black,
        focusColor: Colors.teal,
        value: value,
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(4),
        isExpanded: true,
        items:
            bip39.Language.values
                .map(
                  (language) => DropdownMenuItem(
                    value: language,
                    child: Text(
                      _getLanguageDisplayName(language),
                      style: const TextStyle(color: Colors.black),
                    ),
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

  const _HintChip({required this.word, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.teal),
          color: Colors.white,
        ),
        child: Center(
          child: Text(word, style: const TextStyle(color: Colors.black)),
        ),
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
