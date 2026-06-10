/// Unicode to ASCII transliteration for Dart, ported from the anyascii project.
///
/// Converts Unicode characters to their best ASCII representation.
/// Text is converted character-by-character without considering context.
/// All ASCII characters are left unchanged. Unknown characters are removed.
library;

import 'package:any_ascii/src/_data.dart';

/// Transliterates a single Unicode character to its best ASCII representation.
///
/// Returns the original character unchanged if it is ASCII.
/// Returns an empty string if no mapping exists.
String anyAsciiChar(String c) {
  final codepoint = c.runes.first;
  if (codepoint <= 0x7f) {
    return c;
  }
  return blocks[codepoint] ?? '';
}

/// Transliterates a Unicode string to its best ASCII representation.
///
/// ASCII characters are left unchanged. Characters with no mapping are removed.
String anyAscii(String s) {
  final buf = StringBuffer();
  for (final rune in s.runes) {
    if (rune <= 0x7f) {
      buf.writeCharCode(rune);
    } else {
      buf.write(blocks[rune] ?? '');
    }
  }
  return buf.toString();
}
