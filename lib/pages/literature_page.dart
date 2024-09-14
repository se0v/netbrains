import 'package:flutter/material.dart';

class LiteraturePage extends StatelessWidget {
  const LiteraturePage({super.key});

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // App Bar
      appBar: AppBar(
        title: const Text("Р Е К О М Е Н Д А Ц И И"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      // Body
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          LiteratureSection(
            title: "1. Анализ и математический анализ",
            books: [
              LiteratureItem(
                title: "Математический анализ. Теория и примеры",
                author: "Д. Письменный",
              ),
              LiteratureItem(
                title: "Курс математического анализа",
                author: "С. Л. Соболев",
              ),
              LiteratureItem(
                title: "Курс высшей математики (в 5 томах)",
                author: "В. И. Смирнов",
              ),
            ],
          ),
          LiteratureSection(
            title: "2. История",
            books: [
              LiteratureItem(
                title: "История России с древнейших времен",
                author: "С. М. Соловьев",
              ),
              LiteratureItem(
                title: "Краткая история времени",
                author: "Стивен Хокинг",
              ),
              LiteratureItem(
                title: "Государь",
                author: "Никколо Макиавелли",
              ),
            ],
          ),
          LiteratureSection(
            title: "3. Литература и искусство",
            books: [
              LiteratureItem(
                title: "Война и мир",
                author: "Лев Толстой",
              ),
              LiteratureItem(
                title: "Преступление и наказание",
                author: "Федор Достоевский",
              ),
              LiteratureItem(
                title: "История искусства",
                author: "Эрнст Гомбрих",
              ),
            ],
          ),
          LiteratureSection(
            title: "4. Линейная алгебра и аналитическая геометрия",
            books: [
              LiteratureItem(
                title: "Линейная алгебра и аналитическая геометрия",
                author: "Д. Письменный",
              ),
              LiteratureItem(
                title: "Справочник по математике",
                author: "И. Н. Бронштейн, К. А. Семендяев",
              ),
              LiteratureItem(
                title: "Линейная алгебра",
                author: "К. Хоффман, Р. Кунц",
              ),
            ],
          ),
          LiteratureSection(
            title: "5. Сопротивление материалов (Сопромат)",
            books: [
              LiteratureItem(
                title: "Сопротивление материалов",
                author: "С. П. Тимошенко",
              ),
              LiteratureItem(
                title: "Сопротивление материалов",
                author: "Г. С. Писаренко, А. П. Яковлев",
              ),
              LiteratureItem(
                title: "Теория упругости",
                author: "А. И. Лурье",
              ),
            ],
          ),
          LiteratureSection(
            title: "6. Химия",
            books: [
              LiteratureItem(
                title: "Общая химия",
                author: "Д. И. Менделеев",
              ),
              LiteratureItem(
                title: "Органическая химия",
                author: "А. Н. Несмеянов",
              ),
              LiteratureItem(
                title: "Физическая химия",
                author: "Гилберт Н. Льюис, Мерл Рэндалл",
              ),
            ],
          ),
          LiteratureSection(
            title: "7. Философия",
            books: [
              LiteratureItem(
                title: "История западной философии",
                author: "Бертран Рассел",
              ),
              LiteratureItem(
                title: "Бытие и время",
                author: "Мартин Хайдеггер",
              ),
              LiteratureItem(
                title: "Диалоги",
                author: "Платон",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Literature Section Widget
class LiteratureSection extends StatelessWidget {
  final String title;
  final List<LiteratureItem> books;

  const LiteratureSection({
    super.key,
    required this.title,
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8.0),
        ...books,
        const SizedBox(height: 16.0),
      ],
    );
  }
}

// Literature Item Widget
class LiteratureItem extends StatelessWidget {
  final String title;
  final String author;

  const LiteratureItem({
    super.key,
    required this.title,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.book, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  author,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
