import 'package:flutter/material.dart';
// import 'dart:developer' as developer;

class MnemonicInput extends StatefulWidget {
  final ValueNotifier<bool> tapNotifier;
  const MnemonicInput({super.key, required this.tapNotifier});

  @override
  State<MnemonicInput> createState() => _MnemonicInputState();
}

class _MnemonicInputState extends State<MnemonicInput> {
  // Edit mnemonic phrase
  int? _editingPhraseIndex;
  final TextEditingController _controllerInputEditPhrase =
      TextEditingController();
  final FocusNode _focusNodeInputEditPhrase = FocusNode();

  // Enter mnemonic phrase
  final TextEditingController _controllerInputEnterPhrase =
      TextEditingController();
  final FocusNode _focusNodeInputEnterPhrase = FocusNode();

  // Dropdown with Suggestions
  final ScrollController _scrollControllerDropdownSuggestions =
      ScrollController();
  List<String> _suggestions = [];

  // Storage
  final List<String> _phrases = [];

  final List<String> _bip39Words = [
    "apple",
    "banana",
    "cat",
    "dog",
    "elephant",
    "fish",
    "grape",
    "hat",
    "hat2",
    "ice",
    "ice1",
    "ice2",
    "ice3",
    "ice4",
    "ice5",
    "ice6",
    "ice7",
    "juice",
    "juice",
    "kite",
    "lion",
    "monkey",
    "nose",
    "orange",
    "pig",
    "queen",
    "rabbit",
    "sun",
    "top",
    "top1",
    "top2",
    "top3",
    "top3a",
    "top3b",
    "top3c",
    "tree",
    "umbrella",
    "violin",
    "wolf",
    "xylophone",
    "yoyo",
    "zebra",
  ];

  void _onTapOutsideHandler() {
    if (!widget.tapNotifier.value) {
      return;
    }

    widget.tapNotifier.value = false;

    _commitPendingEdit();
    _setFocusOnEnterPhraseInput();
  }

  void _updateAutocomplete([String? phrase]) {
    final trimmed = phrase?.trim();
    if (trimmed?.isNotEmpty ?? false) {
      _showAutocomplete(trimmed!);
    } else {
      _hideAutocomplete();
    }
  }

  void _showAutocomplete(String phrase) {
    if (phrase.isNotEmpty) {
      final filteredSuggestions =
          _bip39Words.where((word) => word.startsWith(phrase)).take(5).toList();
      setState(() {
        _suggestions = filteredSuggestions;
      });
    }
  }

  void _hideAutocomplete() {
    setState(() {
      _suggestions = [];
    });
  }

  void _onTapAutocompleteHandler(String suggestion) {
    if (_editingPhraseIndex != null) {
      _updateText(suggestion);
    } else {
      _submitText(suggestion);
    }

    _setFocusOnEnterPhraseInput();
  }

  void _onInputChangeEnterPhraseHandler(String value) {
    // ' ' space triggers "submit"
    if (value.endsWith(' ')) {
      _submitText(value);
    } else {
      _updateAutocomplete(value.trim());
    }
  }

  void _onInputChangeEditPhraseHandler(String value) {
    // ' ' space triggers "submit"
    if (value.endsWith(' ')) {
      _updateText(value);
      _setFocusOnEnterPhraseInput();
    } else {
      _updateAutocomplete(value.trim());
    }
  }

  void _onCommitEnterPhraseHandler(String value) {
    _submitText(value);
    _setFocusOnEnterPhraseInput();
  }

  void _submitText(String chunk) {
    final newWords =
        chunk.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();

    setState(() {
      _phrases.addAll(newWords);
    });

    _controllerInputEnterPhrase.clear();
  }

  void _updateText(String updated) {
    setState(() {
      _phrases[_editingPhraseIndex!] = updated.trim();
      _editingPhraseIndex = null;
    });

    _controllerInputEditPhrase.clear();
  }

  void _setFocusOnEnterPhraseInput() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodeInputEnterPhrase.requestFocus();
    });
  }

  void _setFocusOnEditPhraseInput() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodeInputEditPhrase.requestFocus();
    });
  }

  void _commitPendingEdit() {
    if (_editingPhraseIndex != null) {
      final phrase = _controllerInputEditPhrase.text.trim().toLowerCase();

      if (phrase.isNotEmpty) {
        _updateText(phrase);
      } else {
        setState(() {
          _editingPhraseIndex = null;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    widget.tapNotifier.addListener(_onTapOutsideHandler);

    // Edit phrase on focus handler
    _focusNodeInputEditPhrase.addListener(() {
      if (_focusNodeInputEditPhrase.hasFocus) {
        _updateAutocomplete(_controllerInputEditPhrase.text.trim());
      }
    });

    // Enter phrase on focus handler
    _focusNodeInputEnterPhrase.addListener(() {
      if (_focusNodeInputEnterPhrase.hasFocus) {
        _commitPendingEdit();
        _updateAutocomplete(_controllerInputEnterPhrase.text.trim());
      }
    });

    _focusNodeInputEnterPhrase.requestFocus();
  }

  @override
  void dispose() {
    _controllerInputEnterPhrase.dispose();
    _focusNodeInputEnterPhrase.dispose();

    _controllerInputEditPhrase.dispose();
    _focusNodeInputEditPhrase.dispose();

    _scrollControllerDropdownSuggestions.dispose();

    widget.tapNotifier.removeListener(_onTapOutsideHandler);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var phrase in _phrases.asMap().entries)
              _editingPhraseIndex == phrase.key
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      constraints:
                          const BoxConstraints(minWidth: 40, maxWidth: 120),
                      child: IntrinsicWidth(
                        child: TextField(
                          autofocus: true,
                          controller: _controllerInputEditPhrase,
                          focusNode: _focusNodeInputEditPhrase,
                          onChanged: _onInputChangeEditPhraseHandler,
                          onSubmitted: (_) {
                            _commitPendingEdit();
                          },
                          style: const TextStyle(fontSize: 14),
                          decoration: const InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: "Edit phrase...",
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          _editingPhraseIndex = phrase.key;
                          _controllerInputEditPhrase.text = phrase.value;
                        });

                        _setFocusOnEditPhraseInput();
                      },
                      child: Chip(
                        label: Text(phrase.value),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () {
                          setState(() {
                            _phrases.remove(phrase.value);
                          });

                          _setFocusOnEnterPhraseInput();
                        },
                        backgroundColor:
                            _bip39Words.contains(phrase.value.toLowerCase())
                                ? null
                                : Colors.red.shade100,
                        labelStyle: TextStyle(
                          color:
                              _bip39Words.contains(phrase.value.toLowerCase())
                                  ? null
                                  : Colors.red.shade900,
                        ),
                      ),
                    ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 40,
                maxWidth: 120,
              ),
              child: IntrinsicWidth(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _controllerInputEnterPhrase,
                    focusNode: _focusNodeInputEnterPhrase,
                    onChanged: _onInputChangeEnterPhraseHandler,
                    onSubmitted: _onCommitEnterPhraseHandler,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      isCollapsed: true,
                      border: InputBorder.none,
                      hintText: "Add phrase...",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        if (_suggestions.isNotEmpty)
          AutocompleteDropdown(
            suggestions: _suggestions,
            onTapHandler: _onTapAutocompleteHandler,
          )
      ],
    );
  }
}

class AutocompleteDropdown extends StatelessWidget {
  final List<String> suggestions;
  final void Function(String suggestion) onTapHandler;

  const AutocompleteDropdown({
    super.key,
    required this.suggestions,
    required this.onTapHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      constraints: const BoxConstraints(maxHeight: 160),
      child: Scrollbar(
        controller: ScrollController(),
        thumbVisibility: true,
        child: ListView.builder(
          controller: ScrollController(),
          shrinkWrap: true,
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return ListTile(
              dense: true,
              title: Text(suggestion),
              onTap: () {
                onTapHandler(suggestion);
              },
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
            );
          },
        ),
      ),
    );
  }
}
