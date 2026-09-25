import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';

/// macOS-style editor window that types out syntax-highlighted Dart code.
class CodeWindow extends StatefulWidget {
  const CodeWindow({
    super.key,
    required this.code,
    this.fileName = 'main.dart',
    this.typing = true,
    this.fontSize = 13,
    this.width,
  });
  final String code;
  final String fileName;
  final bool typing;
  final double fontSize;
  final double? width;

  @override
  State<CodeWindow> createState() => _CodeWindowState();
}

class _CodeWindowState extends State<CodeWindow> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.typing ? widget.code.length * 9 : 0),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mono = GoogleFonts.jetBrainsMono(fontSize: widget.fontSize, height: 1.6);
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: const Color(0xFF0B1020),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderStrong),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withValues(alpha: .18), blurRadius: 60, offset: const Offset(0, 24)),
          const BoxShadow(color: Colors.black54, blurRadius: 30, offset: Offset(0, 12)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _TitleBar(fileName: widget.fileName),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                final shown = widget.typing
                    ? widget.code.substring(0, (_controller.value * widget.code.length).round())
                    : widget.code;
                final lines = shown.split('\n');
                final totalLines = widget.code.split('\n').length;
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (var i = 1; i <= totalLines; i++)
                          Text('$i', style: mono.copyWith(color: AppColors.textMuted.withValues(alpha: .6))),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0; i < totalLines; i++)
                            i < lines.length
                                ? _highlight(lines[i], mono, cursor: i == lines.length - 1 && _controller.isAnimating)
                                : Text(' ', style: mono),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static final _keywords = RegExp(
      r'\b(class|extends|final|const|return|void|async|await|import|super|this|new|if|else|override|static|late|var|Future|get|set|with|required)\b');
  static final _types = RegExp(r'\b([A-Z][A-Za-z0-9_]*)\b');
  static final _strings = RegExp(r"'[^']*'");
  static final _comments = RegExp(r'//.*');
  static final _numbers = RegExp(r'\b\d+(\.\d+)?\b');
  static final _annotations = RegExp(r'@\w+');
  static final _functions = RegExp(r'\b([a-z_][A-Za-z0-9_]*)(?=\()');

  Widget _highlight(String line, TextStyle base, {bool cursor = false}) {
    final spans = <TextSpan>[];
    final commentMatch = _comments.firstMatch(line);
    var code = line;
    String? comment;
    if (commentMatch != null) {
      comment = line.substring(commentMatch.start);
      code = line.substring(0, commentMatch.start);
    }

    final ranges = <(int, int, Color)>[];
    void add(RegExp re, Color c) {
      for (final m in re.allMatches(code)) {
        if (ranges.any((r) => m.start < r.$2 && m.end > r.$1)) continue;
        ranges.add((m.start, m.end, c));
      }
    }

    add(_strings, AppColors.codeString);
    add(_annotations, AppColors.codeType);
    add(_keywords, AppColors.codeKeyword);
    add(_types, AppColors.codeType);
    add(_functions, AppColors.codeFunction);
    add(_numbers, AppColors.codeNumber);
    ranges.sort((a, b) => a.$1.compareTo(b.$1));

    var idx = 0;
    for (final r in ranges) {
      if (r.$1 > idx) spans.add(TextSpan(text: code.substring(idx, r.$1)));
      spans.add(TextSpan(text: code.substring(r.$1, r.$2), style: TextStyle(color: r.$3)));
      idx = r.$2;
    }
    if (idx < code.length) spans.add(TextSpan(text: code.substring(idx)));
    if (comment != null) {
      spans.add(TextSpan(text: comment, style: const TextStyle(color: AppColors.codeComment, fontStyle: FontStyle.italic)));
    }
    if (cursor) {
      spans.add(const TextSpan(text: '▍', style: TextStyle(color: AppColors.primary)));
    }
    return Text.rich(TextSpan(children: spans), style: base.copyWith(color: AppColors.codeText), softWrap: false, overflow: TextOverflow.clip);
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({required this.fileName});
  final String fileName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        color: Color(0xFF111830),
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          _dot(const Color(0xFFFF5F57)),
          _dot(const Color(0xFFFEBC2E)),
          _dot(const Color(0xFF28C840)),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF0B1020),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 8, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(fileName, style: GoogleFonts.jetBrainsMono(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Icon(Icons.bolt_rounded, size: 12, color: AppColors.warning),
                const SizedBox(width: 4),
                Text('Hot reload', style: GoogleFonts.jetBrainsMono(fontSize: 10.5, color: AppColors.warning)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color c) => Container(
        width: 11,
        height: 11,
        margin: const EdgeInsets.only(right: 7),
        decoration: BoxDecoration(color: c, shape: BoxShape.circle),
      );
}
