import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/note.dart';
import '../services/notification/notification_service.dart';

class NotificationPage extends StatelessWidget {
  final Note note;
  const NotificationPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    DateTime? sendTime;
    final String? noteText =
        ModalRoute.of(context)?.settings.arguments as String?;

    final String? imageUrl =
        _extractImageUrl(note.note); // Получаем URL картинки

    return Scaffold(
      appBar: AppBar(title: const Text("Notification")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Текст с кликабельными ссылками
              SelectableText.rich(
                _parseTextWithLinks(note.note),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Отображение изображения, если есть URL
              if (imageUrl != null)
                Image.network(
                  imageUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Text("Ошибка загрузки изображения"),
                ),

              const SizedBox(height: 20),

              // Кнопка "Повторил(-а)"
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  sendTime = DateTime.now();
                  print('Время отправки: $sendTime');
                  await NotificationService().scheduleNotification(
                    id: 1,
                    title: 'Закрепи',
                    body: note.note,
                    noteText: note.note,
                  );
                },
                child: const Text("Повторил(-а)"),
              ),

              const SizedBox(height: 10),

              // Кнопка "Прекратить повторения"
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  NotificationService().cancelNotification();
                },
                child: const Text("Прекратить повторения"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Функция для извлечения URL-изображения из текста заметки
  String? _extractImageUrl(String text) {
    final RegExp imageRegex = RegExp(
      r'(https?:\/\/.*\.(?:png|jpg|jpeg|gif|bmp))', // Регулярка для поиска картинок
      caseSensitive: false,
    );

    final match = imageRegex.firstMatch(text);
    return match?.group(0); // Возвращаем найденный URL или null
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
