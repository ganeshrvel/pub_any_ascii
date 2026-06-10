#![deny(clippy::all)]
#![warn(
    clippy::all,
    clippy::restriction,
    clippy::pedantic,
    clippy::nursery,
    clippy::cargo,
    clippy::expect_used,
    clippy::unused_async,
    clippy::match_wildcard_for_single_variants,
    clippy::never_loop
)]
#![allow(
    clippy::allow_attributes_without_reason,
    clippy::missing_docs_in_private_items,
    clippy::field_scoped_visibility_modifiers,
    clippy::future_not_send,
    clippy::unwrap_used,
    clippy::print_stdout,
    clippy::implicit_return,
    clippy::similar_names,
    clippy::blanket_clippy_restriction_lints,
    clippy::module_name_repetitions,
    clippy::single_call_fn,
    clippy::single_char_lifetime_names,
    clippy::must_use_candidate,
    clippy::question_mark_used,
    clippy::unnecessary_safety_doc,
    clippy::missing_errors_doc,
    clippy::partial_pub_fields,
    clippy::as_conversions,
    clippy::mod_module_files,
    clippy::exhaustive_enums,
    clippy::exhaustive_structs,
    clippy::absolute_paths,
    clippy::uninlined_format_args,
    clippy::pattern_type_mismatch,
    clippy::min_ident_chars,
    clippy::std_instead_of_core,
    clippy::std_instead_of_alloc,
    clippy::pub_with_shorthand,
    clippy::unused_self,
    clippy::separated_literal_suffix,
    clippy::redundant_pub_crate,
    clippy::integer_division_remainder_used,
    clippy::float_arithmetic,
    clippy::struct_excessive_bools,
    clippy::decimal_literal_representation,
    clippy::let_underscore_untyped,
    clippy::let_underscore_must_use,
    clippy::too_many_arguments,
    clippy::arbitrary_source_item_ordering,
    clippy::redundant_test_prefix,
    clippy::too_many_lines,
    clippy::cognitive_complexity,
    clippy::doc_markdown,
    clippy::pub_use,
    unused_doc_comments,
    clippy::indexing_slicing,
    clippy::shadow_reuse,
    clippy::unwrap_in_result,
    clippy::doc_paragraphs_missing_punctuation,
    clippy::unnecessary_safety_comment,
    clippy::return_and_then,
    clippy::derivable_impls,
    clippy::duration_suboptimal_units,
    clippy::doc_lazy_continuation,
    clippy::print_stderr,
    clippy::unnecessary_trailing_comma
)]
#![forbid(
    unconditional_panic,
    clippy::unimplemented,
    clippy::todo,
    unsafe_op_in_unsafe_fn,
    clippy::large_stack_arrays,
    clippy::wildcard_imports,
    clippy::string_add,
    clippy::string_add_assign,
    unsafe_code,
    unused_unsafe
)]

use std::fmt::Write as _;
use std::fs::File;
use std::io::{BufWriter, Write as _};
use std::path::PathBuf;

fn main() {
    let args: Vec<String> = std::env::args().collect();

    if args.len() != 2 {
        eprintln!("usage: any-ascii-generate <absolute-output-path>");
        eprintln!("example: any-ascii-generate /your/project/lib/src/_data.dart");
        std::process::exit(1);
    }

    let output_path = PathBuf::from(&args[1]);

    if !output_path.is_absolute() {
        eprintln!(
            "error: output path must be absolute, got: {}",
            output_path.display()
        );
        std::process::exit(1);
    }

    if let Some(parent) = output_path.parent() {
        std::fs::create_dir_all(parent).unwrap_or_else(|e| {
            eprintln!(
                "error: failed to create output directory {}: {}",
                parent.display(),
                e
            );
            std::process::exit(1);
        });
    }

    let file = File::create(&output_path).unwrap_or_else(|e| {
        eprintln!("error: failed to create {}: {}", output_path.display(), e);
        std::process::exit(1);
    });

    let mut writer = BufWriter::new(file);

    writeln!(writer, "// generated \u{2014} do not edit").unwrap();
    writeln!(
        writer,
        "// ignore_for_file: prefer_single_quotes, use_raw_strings, avoid_escaping_inner_quotes"
    )
    .unwrap();
    writeln!(writer).unwrap();
    writeln!(writer, "const Map<int, String> blocks = {{").unwrap();

    let codepoints = (0x0080_u32..=0xD7FF_u32).chain(0xE000_u32..=0x0010_FFFF_u32);

    for c in codepoints.filter_map(char::from_u32) {
        let result = any_ascii::any_ascii_char(c);
        if result.is_empty() {
            continue;
        }

        writeln!(
            writer,
            "  0x{:04x}: \"{}\",",
            c as u32,
            escape_dart_string(result),
        )
        .unwrap();
    }

    writeln!(writer, "}};").unwrap();

    writer.flush().unwrap_or_else(|e| {
        eprintln!("error: failed to flush {}: {}", output_path.display(), e);
        std::process::exit(1);
    });

    println!("written to {}", output_path.display());
}

fn escape_dart_string(s: &str) -> String {
    let mut buf = String::new();
    for b in s.bytes() {
        match b {
            b'"' => buf.push_str("\\\""),
            b'\\' => buf.push_str("\\\\"),
            b'$' => buf.push_str("\\$"),
            0x20..=0x7e => buf.push(b as char),
            _ => write!(buf, "\\x{:02x}", b).unwrap(),
        }
    }
    buf
}
