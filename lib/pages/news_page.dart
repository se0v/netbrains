import 'package:flutter/material.dart';

// Модель данных для новостей
class NewsItem {
  final String title;
  final String imageUrl;
  final String content;

  NewsItem(
      {required this.title, required this.imageUrl, required this.content});
}

// Главная страница с новостями
class NewsPage extends StatelessWidget {
  NewsPage({super.key});

  // Пример данных для новостей
  final List<NewsItem> newsItems = [
    NewsItem(
        title:
            "Доктор Дум из вселенной Marvel захватывает боевой пропуск Fortnite: овладейте его силой в «Королевской битве»!",
        imageUrl: "assets/draweric3.jpg",
        content:
            "04.09.2024 Разработчики Fortnite Жестокий правитель Латверии — Доктор Дум из вселенной Marvel — намеревается установить своё господство в Fortnite! Выполняйте задания Доктора Дума в «Королевской битве» с сегодняшнего дня и получайте награды, которые определённо пришлись бы по вкусу неумолимому тирану: граффити «Доктор на месте», эмодзи «Мощь Дума» и не только. Обладатели боевого пропуска « ти «Доктор на месте», эмодзи «Мощь Дума» и не только. Обладатели боевого пропуска «Властитель Дум» смогут получить дополнительные награды за выполнение тех же заданий, например экипировку Дума и кирку «Клинок Дума». Путешествуя по острову «Королевской битвы», будьте осторожны: вам может встретиться сам Доктор Дум! Всё живое должно склониться перед тем, кого выберет Дум! Ничто не сможет устоять перед силой Дума. С сегодняшнего дня и до 5 октября, 20:30 по московскому времени, есть небольшая вероятность, что на месте острова с добычей появится остров Дума. В центре острова будет находиться котёл Дума: захватите его, и Виктор фон Дум наречёт вас либо одного из ваших товарищей по команде преемником своей силы. Став избранным Дума, вы освоите сразу несколько магических заклятий: Ваши запас здоровья и заряд щита увеличатся до 500 единиц! Заряд щита будет пополняться при устранениях. сможете уничтожать врагов, призывая сокрушительный магический шквал, пробивать постройки, используя выжигающий луч, и взрывать мистические мегабомбы, превращая в пепел всех непокорных. А ещё, овладев магией, вы сможете взмыть в небо, нанести урон врагам с высоты, а затем приземлиться, используя коронный приём Доктора Дума. не забудьте про неограниченный спринт, который не оставит вашим противникам ни единого шанса на побег!"),
    NewsItem(
      title: "Новость 2",
      imageUrl:
          "https://images.unsplash.com/photo-1583361704605-304ebfcddea0?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      content: "Полный текст новости 2.",
    ),
    NewsItem(
      title: "Новость 3",
      imageUrl:
          "https://plus.unsplash.com/premium_photo-1723826751660-717811d0fbc6?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      content: "Полный текст новости 3.",
    ),
  ];

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      // App Bar
      appBar: AppBar(
        title: const Text("Н О В О С Т И"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      // Body: Лента новостей
      body: ListView.builder(
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          final news = newsItems[index];
          return NewsCard(news: news);
        },
      ),
    );
  }
}

// Виджет карточки новости
class NewsCard extends StatelessWidget {
  final NewsItem news;

  const NewsCard({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8.0),
        leading: Image.network(
          news.imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
                Icons.error); // Показывает ошибку, если картинка не загрузилась
          },
        ),
        title: Text(news.title),
        onTap: () {
          // Переход на страницу с полным содержанием новости
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailPage(news: news),
            ),
          );
        },
      ),
    );
  }
}

// Страница с полным текстом новости и большой картинкой
class NewsDetailPage extends StatelessWidget {
  final NewsItem news;

  const NewsDetailPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                news.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error); // Ошибка при загрузке
                },
              ),
              const SizedBox(height: 16.0),
              Text(
                news.content,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
