import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/note.dart';

class NotePage extends StatelessWidget {
  final Note note;

  const NotePage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    String? imageUrl =
        _extractImageUrl(note.note); // Ищем URL картинки в тексте

    return Scaffold(
      appBar: AppBar(
        title: const Text("Просмотр заметки"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Текст заметки с кликабельными ссылками
            SelectableText.rich(
              _parseTextWithLinks(note.note),
            ),
            const SizedBox(height: 16),

            // Отображение изображения, если найден URL
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
      ),
    );
  }

  /// Извлекаем URL изображения из текста заметки
  String? _extractImageUrl(String text) {
    final RegExp imageRegex = RegExp(
      r'https?:\/\/.*\.(?:png|jpg|jpeg|gif)', // Поиск ссылок на изображения
      caseSensitive: false,
    );

    final match = imageRegex.firstMatch(text);
    return match?.group(0); // Возвращаем найденный URL
  }

  /// Разбираем текст и делаем ссылки кликабельными
  TextSpan _parseTextWithLinks(String text) {
    final RegExp linkRegex = RegExp(
      r'(https?:\/\/[^\s]+)', // Регулярное выражение для поиска ссылок
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

  // Открываем ссылку в браузере
  void _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Не удалось открыть ссылку: $url");
    }
  }
}
