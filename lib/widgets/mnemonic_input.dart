import 'package:flutter/material.dart';
import 'dart:math';

class MnemonicInput extends StatefulWidget {
  final ValueNotifier<bool> tapNotifier;
  final void Function(bool) mnemonicPhraseStateHandler;
  final List<String> wordList;
  const MnemonicInput(
      {super.key,
      required this.tapNotifier,
      required this.wordList,
      required this.mnemonicPhraseStateHandler});

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
  bool _hasReachedLimit(int numberOfWords) {
    return _phrases.length >= numberOfWords;
  }

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
      final filteredSuggestions = widget.wordList
          .where((word) => word.startsWith(phrase))
          .take(5)
          .toList();
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

    _updateAutocomplete();
    _setFocusOnEnterPhraseInput();
  }

  void _onInputChangeEnterPhraseHandler(String value) {
    // ' ' space triggers "submit"
    if (value.endsWith(' ')) {
      _submitText(value);
      _updateAutocomplete();
      _setFocusOnEnterPhraseInput();
    } else {
      final newWords = value
          .trim()
          .split(RegExp(r'\s+'))
          .where((w) => w.isNotEmpty)
          .toList();
      // user pasted multiple words
      if (newWords.length > 1) {
        _submitText(value);
        _updateAutocomplete();
        _setFocusOnEnterPhraseInput();
      } else {
        _updateAutocomplete(value.trim());
      }
    }
  }

  void _onInputChangeEditPhraseHandler(String value) {
    // ' ' space triggers "submit"
    if (value.endsWith(' ')) {
      _updateText(value);
      _updateAutocomplete();
      _setFocusOnEnterPhraseInput();
    } else {
      _updateAutocomplete(value.trim());
    }
  }

  void _onCommitEnterPhraseHandler(String value) {
    _submitText(value);
    _updateAutocomplete();
    _setFocusOnEnterPhraseInput();
  }

  void _submitText(String chunk) {
    final newWords =
        chunk.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();

    setState(() {
      final remainingSlots = 24 - _phrases.length;
      if (remainingSlots > 0) {
        _phrases.addAll(newWords.take(remainingSlots));
      }
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

    _updateAutocomplete();
    _setFocusOnEnterPhraseInput();
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
        _focusNodeInputEditPhrase.requestFocus();
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

  int _computeNumberOfChips(double widgetWidth) {
    if (widgetWidth >= 800) {
      return 4;
    } else if (widgetWidth >= 600) {
      return 3;
    } else if (widgetWidth >= 400) {
      return 2;
    }

    return 1;
  }

  /*
    Input:
         1  2  3
        [4] 5  6
         7  8  9

        position = 4
        columnsPerRow = 3

        position + columnsPerRow - (position % columnsPerRow) = last cell position in row
        4 + 3 - (4 % 3) = 6
        
        last position in row is 6 so index is 2
        
         1  2  3    <---- row index 1
        [4] 5 >6<   <---- row index 2
         7  8  9    <---- row index 3
    */
  double _getRowIndexForPosition(int position, int columnsPerRow) {
    return (columnsPerRow + position - (position % columnsPerRow)) /
        columnsPerRow;
  }

  bool _isItemInLastRow(int position, int tableSize, int columnsPerRow) {
    int totalRows = (tableSize / columnsPerRow).ceil();
    int itemRow = (position / columnsPerRow).floor();
    return itemRow == totalRows - 1;
  }

  bool shouldDrawEditPhraseAutocompleteHere(int position, int drawPosition) {
    return position == drawPosition;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double widgetsLeftRightPadding = 13.0 + 13.0; // [<-13->widget<-13->]
      int numberOfChips = _computeNumberOfChips(constraints.maxWidth);
      int chipsPadding = 6;
      int spacingBetweenChips = (numberOfChips - 1) *
          chipsPadding; // sum: chip <-6-> chip <-6-> chip <-6-> chip

      double singleChipWidth = max(
        (constraints.maxWidth - widgetsLeftRightPadding - spacingBetweenChips) /
            numberOfChips,
        50,
      );

      int editPhraseAutocompleteCellIndex = -1;
      bool drawEditPhraseAutocompleteAfterEnterPhraseInput = false;
      bool showEditPhraseAutocomplete =
          _editingPhraseIndex != null && _suggestions.isNotEmpty;

      bool showEnterPhraseAutocomplete =
          _editingPhraseIndex == null && _suggestions.isNotEmpty;

      // calculations for autocomplete box for editing
      if (showEditPhraseAutocomplete) {
        int rowIndex = showEditPhraseAutocomplete
            ? _getRowIndexForPosition(_editingPhraseIndex!, numberOfChips)
                .toInt()
            : 0;

        int lastCellPositionInRow = rowIndex * numberOfChips;
        bool lastCellElementExists = lastCellPositionInRow <= _phrases.length;

        editPhraseAutocompleteCellIndex =
            lastCellElementExists ? lastCellPositionInRow : _phrases.length;

        editPhraseAutocompleteCellIndex =
            editPhraseAutocompleteCellIndex - 1; // zero indexed

        drawEditPhraseAutocompleteAfterEnterPhraseInput = _isItemInLastRow(
                _editingPhraseIndex!, _phrases.length, numberOfChips) &&
            _phrases.length > lastCellPositionInRow - numberOfChips &&
            _phrases.length != lastCellPositionInRow;
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_phrases.length == 24) {
          bool ok = _phrases.every(
            (p) => widget.wordList.contains(p.toLowerCase()),
          );

          widget.mnemonicPhraseStateHandler(ok);
        } else {
          widget.mnemonicPhraseStateHandler(false);
        }
      });

      return Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 16, bottom: 16, left: 13, right: 13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                blurRadius: 6,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 0,
                runSpacing: 16,
                children: [
                  for (var phrase in _phrases.asMap().entries) ...[
                    if (_editingPhraseIndex == phrase.key)
                      Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                right: (phrase.key + 1) % numberOfChips == 0
                                    ? 0
                                    : chipsPadding.toDouble(),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 2),
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(16),
                                    border:
                                        Border.all(style: BorderStyle.none)),
                                constraints: BoxConstraints(
                                  minWidth: singleChipWidth,
                                  maxWidth: singleChipWidth,
                                  minHeight: 34,
                                  maxHeight: 34,
                                ),
                                child: IntrinsicWidth(
                                  child: TextField(
                                    autofocus: true,
                                    controller: _controllerInputEditPhrase,
                                    focusNode: _focusNodeInputEditPhrase,
                                    onChanged: _onInputChangeEditPhraseHandler,
                                    onSubmitted: (_) {
                                      _commitPendingEdit();
                                    },
                                    textAlign: TextAlign.center,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: const TextStyle(fontSize: 14),
                                    decoration: const InputDecoration(
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                      hintText: "Edit phrase...",
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    if (_editingPhraseIndex != phrase.key)
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _editingPhraseIndex = phrase.key;
                              _controllerInputEditPhrase.text = phrase.value;
                            });
                            _setFocusOnEditPhraseInput();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: (phrase.key + 1) % numberOfChips == 0
                                  ? 0
                                  : chipsPadding.toDouble(),
                            ),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: 34,
                                maxHeight: 34,
                                minWidth: singleChipWidth,
                                maxWidth: singleChipWidth,
                              ),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: widget.wordList
                                          .contains(phrase.value.toLowerCase())
                                      ? Colors.grey.shade200
                                      : Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${phrase.key + 1}. ${phrase.value}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: widget.wordList.contains(
                                                  phrase.value.toLowerCase())
                                              ? null
                                              : Colors.red.shade900,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _phrases.remove(phrase.value);
                                        });
                                        _setFocusOnEnterPhraseInput();
                                      },
                                      child: const Icon(Icons.close, size: 20),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    if (showEditPhraseAutocomplete &&
                        !drawEditPhraseAutocompleteAfterEnterPhraseInput &&
                        shouldDrawEditPhraseAutocompleteHere(
                            phrase.key, editPhraseAutocompleteCellIndex))
                      AutocompleteDropdown(
                        suggestions: _suggestions,
                        onTapHandler: _onTapAutocompleteHandler,
                      ),
                  ],
                  if (!_hasReachedLimit(24))
                    ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 34,
                          maxHeight: 34,
                          minWidth: singleChipWidth,
                          maxWidth: singleChipWidth,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: IntrinsicWidth(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
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
                                textAlign:
                                    _controllerInputEnterPhrase.text.isEmpty
                                        ? TextAlign.left
                                        : TextAlign.center,
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                  hintText: "Add phrase...",
                                ),
                              ),
                            ),
                          ),
                        )),
                  if (showEditPhraseAutocomplete &&
                      drawEditPhraseAutocompleteAfterEnterPhraseInput)
                    AutocompleteDropdown(
                      suggestions: _suggestions,
                      onTapHandler: _onTapAutocompleteHandler,
                    )
                ],
              ),
              if (showEnterPhraseAutocomplete)
                AutocompleteDropdown(
                  suggestions: _suggestions,
                  onTapHandler: _onTapAutocompleteHandler,
                )
            ],
          ));
    });
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
    final ScrollController scrollController = ScrollController();
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      constraints: const BoxConstraints(maxHeight: 160),
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        child: ListView.builder(
          controller: scrollController,
          shrinkWrap: true,
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final suggestion = suggestions[index];
            return ListTile(
              dense: true,
              title: Text(
                suggestion,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 1,
              ),
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
