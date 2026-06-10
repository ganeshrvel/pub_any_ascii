# any_ascii - Unicode to ASCII transliteration for Dart

### Introduction

**any_ascii** is a Unicode to ASCII transliteration library for Dart, ported from
the [anyascii](https://github.com/anyascii/anyascii) project.

It converts Unicode characters to their best ASCII representation. Text is converted
character-by-character. The mappings for each script are based on popular existing romanization
systems. Symbolic characters are converted based on their meaning or appearance. All ASCII
characters in the input are left unchanged. Unknown characters are removed.

The translation was done using Claude. If you find any bugs or incomplete behavior, feel free to
open an issue or raise a PR.

### Description

Unicode to ASCII transliteration for Dart, ported from the anyascii project.

Converts Unicode characters to their closest ASCII equivalent without considering context. Supports
scripts from across the Unicode standard including Latin, Cyrillic, Greek, CJK, Arabic, Hebrew, and
many more.

### Installation

Go to [https://pub.dev/packages/any_ascii](https://pub.dev/packages/any_ascii) for the latest
version of **any_ascii**

### Usage

```dart
import 'package:any_ascii/any_ascii.dart';

void main() {
  print(anyAscii('άνθρωποι')); // anthropoi
  print(anyAscii('Борис')); // Boris
  print(anyAscii('深圳')); // ShenZhen
  print(anyAsciiChar('æ')); // ae
  print(anyAsciiChar('👑')); // :crown:
}
```

### Development

#### Requirements

- [Dart SDK](https://dart.dev/get-dart) `>=3.10.0`
- [Rust](https://www.rust-lang.org/tools/install) (required only for regenerating the data file)

#### Installing Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Verify the installation:

```bash
rustc --version
cargo --version
```

#### Regenerating the data file

The file `lib/src/_data.dart` is generated from the [anyascii](https://github.com/anyascii/anyascii)
Rust crate. It is committed to the repository and does not need to be regenerated unless you want to
update to a newer version of the anyascii data.

To regenerate:

```bash
./scripts/generate.sh
```

This runs the Rust generator at `any-ascii-generate/src/main.rs` which iterates all Unicode
codepoints, calls the anyascii Rust crate for each, and writes the resulting `Map<int, String>` to
`lib/src/_data.dart`.

To update the anyascii data version, change the version in `any-ascii-generate/Cargo.toml`:

```toml
[dependencies]
any_ascii = "x.y.z"
```

Then run `./scripts/generate.sh` again.

#### Running tests

```bash
dart test
```

### Contacts

Please feel free to reach out via the repository.

### About

- Package URL: [https://pub.dev/packages/any_ascii](https://pub.dev/packages/any_ascii)
- Repo
  URL: [https://github.com/ganeshrvel/pub_any_ascii](https://github.com/ganeshrvel/pub_any_ascii)

### License

any_ascii | Unicode to ASCII transliteration for Dart. MIT License.
