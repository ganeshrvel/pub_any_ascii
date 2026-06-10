// ignore_for_file: prefer_single_quotes

import 'package:any_ascii/any_ascii.dart';
import 'package:test/test.dart';

void main() {
  void check(String input, String expected) {
    expect(anyAscii(input), equals(expected));
  }

  void checkChar(String input, String expected) {
    expect(anyAsciiChar(input), equals(expected));
  }

  test('anyAscii', () {
    check("", "");
    check("\x00\x01\t\n\x1f ~\x7f", "\x00\x01\t\n\x1f ~\x7f");
    check("sample", "sample");

    check("\u0080", "");
    check("\u00ff", "y");
    check("\ue000", "");
    check("\uffff", "");
    check("\u{e0020}", " ");
    check("\u{e007e}", "~");
    check("\u{f0000}", "");
    check("\u{f0001}", "");
    check("\u{10ffff}", "");

    check("René François Lacôte", "Rene Francois Lacote");
    check("Blöße", "Blosse");
    check("Trần Hưng Đạo", "Tran Hung Dao");
    check("Nærøy", "Naeroy");
    check("Φειδιππίδης", "Feidippidis");
    check("Δημήτρης Φωτόπουλος", "Dimitris Fotopoylos");
    check("Борис Николаевич Ельцин", "Boris Nikolaevich El'tsin");
    check("Володимир Горбулін", "Volodimir Gorbulin");
    check("Търговище", "T'rgovishche");
    check("深圳", "ShenZhen");
    check("深水埗", "ShenShuiBu");
    check("화성시", "HwaSeongSi");
    check("華城市", "HuaChengShi");
    check("さいたま", "saitama");
    check("埼玉県", "QiYuXian");
    check("ደብረ ዘይት", "debre zeyt");
    check("ደቀምሓረ", "dek'emhare");
    check("دمنهور", "dmnhwr");
    check("Աբովյան", "Abovyan");
    check("სამტრედია", "samt'redia");
    check("אברהם הלוי פרנקל", "'vrhm hlvy frnkl");
    check("⠠⠎⠁⠽⠀⠭⠀⠁⠛", "+say x ag");
    check("ময়মনসিংহ", "mymnsimh");
    check("ထန်တလန်", "thntln");
    check("પોરબંદર", "porbmdr");
    check("महासमुंद", "mhasmumd");
    check("ಬೆಂಗಳೂರು", "bemgluru");
    check("សៀមរាប", "siemrab");
    check("ສະຫວັນນະເຂດ", "sahvannaekhd");
    check("കളമശ്ശേരി", "klmsseri");
    check("ଗଜପତି", "gjpti");
    check("ਜਲੰਧਰ", "jlmdhr");
    check("රත්නපුර", "rtnpur");
    check("கன்னியாகுமரி", "knniyakumri");
    check("శ్రీకాకుళం", "srikakulm");
    check("สงขลา", "sngkhla");
    check("👑 🌴", ":crown: :palm_tree:");
    check("☆ ♯ ♰ ⚄ ⛌", "* # + 5 X");
    check("№ ℳ ⅋ ⅍", "No M & A/S");

    check("トヨタ", "toyota");
    check("ߞߐߣߊߞߙߌ߫", "konakri");
    check("𐬰𐬀𐬭𐬀𐬚𐬎𐬱𐬙𐬭𐬀", "zarathushtra");
    check("ⵜⵉⴼⵉⵏⴰⵖ", "tifinagh");
    check("𐍅𐌿𐌻𐍆𐌹𐌻𐌰", "wulfila");
    check("ދިވެހި", "dhivehi");
    check("ᨅᨔ ᨕᨘᨁᨗ", "bs ugi");
    check("ϯⲙⲓⲛϩⲱⲣ", "timinhor");
    check("𐐜 𐐢𐐮𐐻𐑊 𐐝𐐻𐐪𐑉", "Dh Litl Star");
    check("ꁌꐭꑤ", "pujjytxiep");
    check("ⰳⰾⰰⰳⱁⰾⰹⱌⰰ", "glagolica");
    check("ᏎᏉᏯ", "SeQuoYa");
    check("ㄓㄨㄤ ㄅㄥ ㄒㄧㄠ", "zhuang beng xiao");
    check("ꚩꚫꛑꚩꚳ ꚳ꛰ꛀꚧꚩꛂ", "ipareim m'shuoiya");
    check("ᓀᐦᐃᔭᐍᐏᐣ", "nehiyawewin");
    check("ᠤᠯᠠᠭᠠᠨᠴᠠᠪ", "ulaganqab");
    check("𐑨𐑯𐑛𐑮𐑩𐑒𐑤𐑰𐑟 𐑯 𐑞 𐑤𐑲𐑩𐑯", "andr'kliiz n dh lai'n");

    check(
      "🐂 🦉 🦆 🦓 ☕ 🍿 ✈ 🎷 🎤 🌡 🦹",
      ":ox: :owl: :duck: :zebra: :coffee: :popcorn: :airplane: :saxophone: :microphone: :thermometer: :supervillain:",
    );
    check("에 가 힣 널 뢌 땚 꺵", "E Ga Hih Neol Lwass Ttaelp Kkyaeng");
  });

  test('anyAsciiChar', () {
    checkChar("æ", "ae");
    checkChar("é", "e");
    checkChar("ß", "ss");
    checkChar("深", "Shen");
    checkChar("ç", "c");
    checkChar("λ", "l");
    checkChar("ж", "zh");
    checkChar("👑", ":crown:");
    checkChar("♯", "#");
  });
}
