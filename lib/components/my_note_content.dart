import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyNoteContent extends StatelessWidget {
  final String text; // text note
  final bool isCentered;

  const MyNoteContent({super.key, required this.text, this.isCentered = false});

  @override
  Widget build(BuildContext context) {
    String? imageUrl = _extractImageUrl(text); // search URL pic

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment:
            isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          // text with clickable links
          SelectableText.rich(
            _parseTextWithLinks(text),
            textAlign: isCentered ? TextAlign.center : TextAlign.start,
          ),
          const SizedBox(height: 16),

          // showing pic, if searched URL
          if (imageUrl != null)
            Image.network(
              imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Text("Ошибка загрузки изображения"),
            ),
        ],
      ),
    );
  }

  /// extract image url
  String? _extractImageUrl(String text) {
    final RegExp imageRegex = RegExp(
      r'https?:\/\/.*\.(?:png|jpg|jpeg|gif)', // searching pic-links
      caseSensitive: false,
    );

    final match = imageRegex.firstMatch(text);
    return match?.group(0); // return url
  }

  /// parsing text
  TextSpan _parseTextWithLinks(String text) {
    final RegExp linkRegex = RegExp(
      r'(https?:\/\/[^\s]+)', // for searching links
      caseSensitive: false,
    );

    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    final matches = linkRegex.allMatches(text);
    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: text.substring(lastMatchEnd, match.start)));
      }

      final String url = match.group(0)!;
      spans.add(
        TextSpan(
          text: url,
          style: const TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
          recognizer: TapGestureRecognizer()..onTap = () => _openUrl(url),
        ),
      );

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < text.length) {
      spans.add(TextSpan(text: text.substring(lastMatchEnd)));
    }

    return TextSpan(
        style: const TextStyle(color: Colors.white), children: spans);
  }

  // openingg link in browser
  void _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Не удалось открыть ссылку: $url");
    }
  }
}
