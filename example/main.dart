// ignore_for_file: avoid_print

import 'package:any_ascii/any_ascii.dart';

void main() {
  print(anyAscii('άνθρωποι')); // anthropoi
  print(anyAscii('Борис')); // Boris
  print(anyAscii('深圳')); // ShenZhen
  print(anyAscii('Blöße')); // Blosse
  print(anyAscii('Trần Hưng Đạo')); // Tran Hung Dao
  print(anyAscii('👑 🌴')); // :crown: :palm_tree:
  print(anyAscii('さいたま')); // saitama
  print(anyAscii('دمنهور')); // dmnhwr
  print(anyAscii('Αθήνα')); // Athina
  print(anyAscii('에 가 힣 널')); // E Ga Hih Neol

  print(anyAsciiChar('æ')); // ae
  print(anyAsciiChar('ß')); // ss
  print(anyAsciiChar('深')); // Shen
  print(anyAsciiChar('👑')); // :crown:
  print(anyAsciiChar('ж')); // zh
  print(anyAsciiChar('λ')); // l
  print(anyAscii('Ελλάδα')); // Ellada
}
