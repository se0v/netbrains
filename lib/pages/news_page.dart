import 'package:flutter/material.dart';

import '../components/my_drawer.dart';

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
        imageUrl:
            "https://mir-s3-cdn-cf.behance.net/project_modules/1400/8453ce41299745.57a0af4233c6f.jpg",
        content:
            "04.09.2024 Разработчики Fortnite Жестокий правитель Латверии — Доктор Дум из вселенной Marvel — намеревается установить своё господство в Fortnite! Выполняйте задания Доктора Дума в «Королевской битве» с сегодняшнего дня и получайте награды, которые определённо пришлись бы по вкусу неумолимому тирану: граффити «Доктор на месте», эмодзи «Мощь Дума» и не только. Обладатели боевого пропуска « ти «Доктор на месте», эмодзи «Мощь Дума» и не только. Обладатели боевого пропуска «Властитель Дум» смогут получить дополнительные награды за выполнение тех же заданий, например экипировку Дума и кирку «Клинок Дума». Путешествуя по острову «Королевской битвы», будьте осторожны: вам может встретиться сам Доктор Дум! Всё живое должно склониться перед тем, кого выберет Дум! Ничто не сможет устоять перед силой Дума. С сегодняшнего дня и до 5 октября, 20:30 по московскому времени, есть небольшая вероятность, что на месте острова с добычей появится остров Дума. В центре острова будет находиться котёл Дума: захватите его, и Виктор фон Дум наречёт вас либо одного из ваших товарищей по команде преемником своей силы. Став избранным Дума, вы освоите сразу несколько магических заклятий: Ваши запас здоровья и заряд щита увеличатся до 500 единиц! Заряд щита будет пополняться при устранениях. сможете уничтожать врагов, призывая сокрушительный магический шквал, пробивать постройки, используя выжигающий луч, и взрывать мистические мегабомбы, превращая в пепел всех непокорных. А ещё, овладев магией, вы сможете взмыть в небо, нанести урон врагам с высоты, а затем приземлиться, используя коронный приём Доктора Дума. не забудьте про неограниченный спринт, который не оставит вашим противникам ни единого шанса на побег!04.09.2024 Разработчики Fortnite Жестокий правитель Латверии — Доктор Дум из вселенной Marvel — намеревается установить своё господство в Fortnite! Выполняйте задания Доктора Дума в «Королевской битве» с сегодняшнего дня и получайте награды, которые определённо пришлись бы по вкусу неумолимому тирану: граффити «Доктор на месте», эмодзи «Мощь Дума» и не только. Обладатели боевого пропуска « ти «Доктор на месте», эмодзи «Мощь Дума» и не только. Обладатели боевого пропуска «Властитель Дум» смогут получить дополнительные награды за выполнение тех же заданий, например экипировку Дума и кирку «Клинок Дума». Путешествуя по острову «Королевской битвы», будьте осторожны: вам может встретиться сам Доктор Дум! Всё живое должно склониться перед тем, кого выберет Дум! Ничто не сможет устоять перед силой Дума. С сегодняшнего дня и до 5 октября, 20:30 по московскому времени, есть небольшая вероятность, что на месте острова с добычей появится остров Дума. В центре острова будет находиться котёл Дума: захватите его, и Виктор фон Дум наречёт вас либо одного из ваших товарищей по команде преемником своей силы. Став избранным Дума, вы освоите сразу несколько магических заклятий: Ваши запас здоровья и заряд щита увеличатся до 500 единиц! Заряд щита будет пополняться при устранениях. сможете уничтожать врагов, призывая сокрушительный магический шквал, пробивать постройки, используя выжигающий луч, и взрывать мистические мегабомбы, превращая в пепел всех непокорных. А ещё, овладев магией, вы сможете взмыть в небо, нанести урон врагам с высоты, а затем приземлиться, используя коронный приём Доктора Дума. не забудьте про неограниченный спринт, который не оставит вашим противникам ни единого шанса на побег!"),
    NewsItem(
      title: "Zonic со злости от проигранного раунда ударил себя проводом",
      imageUrl:
          "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/f34756205981729.66c4d52d5b3bb.gif",
      content:
          "Zonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводомZonic со злости от проигранного раунда ударил себя проводом",
    ),
    NewsItem(
      title: "NIGGA!",
      imageUrl:
          "https://images.unsplash.com/photo-1583361704605-304ebfcddea0?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      content:
          "Yeah 7:30 in the night I get those goosebumps every time, yeah, you come around, yeah You ease my mind, you make everything feel fine Worry about those comments I'm way too numb, yeah, it's way too dumb, yeah I get those goosebumps every time, I need the Heimlich Throw that to the side, yeah I get those goosebumps every time, yeah, when you're not around When you throw that to the side, yeah I get those goosebumps every time 7-1-3 to the 2-8-1, yeah I'm riding Why they on me? Why they on me? I'm flyin', sippin' lowkey I'm sipping lowkey and Onyx, rider, rider When I'm pullin' up right beside ya Popstar, lil' Mariah when I text a cute game Wildness, throw a stack on the Bible Never Snapchat or took molly She fall through plenty, her and all her ginnies We at the top floor, right there off the Henny Oh no, I can't fuck with y'all Yea, when I'm with my squad I cannot do no wrong Saucin' in the city, don't get misinformed, yea They gon' pull up on you (brr, brr, brr) Yea, we gon' do some things, some things you can't relate Yea, cause we from a place, a place you cannot stay Oh, you can't go, oh, I don't know Oh, back the fuck up off me (brr, brr, brr) I get those goosebumps every time, yeah, you come around, yeah You ease my mind, you make everything feel fine Worry about those comments I'm way too numb, yeah, it's way too dumb, yeah I get those goosebumps every time, I need the Heimlich Throw that to the side, yeah I get those goosebumps every time, yeah, when you're not around When you throw that to the side, yeah I get those goosebumps every time I want to press my like, yeah, I wanna press my I want a green light, I wanna be like I wanna press my line, yeah I want to take that ride, yeah I’m gonna press my lime I wanna green light, I wanna be like, I wanna press my Mama, dear, spare your feelings I'm reliving moments, peeling more residual (I can) buy the building, burn the building, take your bitch, rebuild the building just to fuck some more (I can) justify my love for you and touch the sky for God to stop, debating war Put the pussy on a pedestal Put the pussy on a high horse That pussy to die for That pussy to die for Peter, piper, picked a peppers I could pick your brain and put your heart together We depart the shady parts and party hard, the diamonds yours The coupe forever My best shots might shoot forever like (brr) I get those goosebumps every time, yeah, you come around, yeah You ease my mind, you make everything feel fine Worry about those comments I'm way too numb, yeah, it's way too dumb, yeah I get those goosebumps every time, I need the Heimlich Throw that to the side, yeah I get those goosebumps every time, yeah, when you're not around When you throw that to the side, yeah I get those goosebumps every time Yeah 7:30 in the night I get those goosebumps every time, yeah, you come around, yeah You ease my mind, you make everything feel fine Worry about those comments I'm way too numb, yeah, it's way too dumb, yeah I get those goosebumps every time, I need the Heimlich Throw that to the side, yeah I get those goosebumps every time, yeah, when you're not around When you throw that to the side, yeah I get those goosebumps every time 7-1-3 to the 2-8-1, yeah I'm riding Why they on me? Why they on me? I'm flyin', sippin' lowkey I'm sipping lowkey and Onyx, rider, rider When I'm pullin' up right beside ya Popstar, lil' Mariah when I text a cute game Wildness, throw a stack on the Bible Never Snapchat or took molly She fall through plenty, her and all her ginnies We at the top floor, right there off the Henny Oh no, I can't fuck with y'all Yea, when I'm with my squad I cannot do no wrong Saucin' in the city, don't get misinformed, yea They gon' pull up on you (brr, brr, brr) Yea, we gon' do some things, some things you can't relate Yea, cause we from a place, a place you cannot stay Oh, you can't go, oh, I don't know Oh, back the fuck up off me (brr, brr, brr) I get those goosebumps every time, yeah, you come around, yeah You ease my mind, you make everything feel fine Worry about those comments I'm way too numb, yeah, it's way too dumb, yeah I get those goosebumps every time, I need the Heimlich Throw that to the side, yeah I get those goosebumps every time, yeah, when you're not around When you throw that to the side, yeah I get those goosebumps every time I want to press my like, yeah, I wanna press my I want a green light, I wanna be like I wanna press my line, yeah I want to take that ride, yeah I’m gonna press my lime I wanna green light, I wanna be like, I wanna press my Mama, dear, spare your feelings I'm reliving moments, peeling more residual (I can) buy the building, burn the building, take your bitch, rebuild the building just to fuck some more (I can) justify my love for you and touch the sky for God to stop, debating war Put the pussy on a pedestal Put the pussy on a high horse That pussy to die for That pussy to die for Peter, piper, picked a peppers I could pick your brain and put your heart together We depart the shady parts and party hard, the diamonds yours The coupe forever My best shots might shoot forever like (brr) I get those goosebumps every time, yeah, you come around, yeah You ease my mind, you make everything feel fine Worry about those comments I'm way too numb, yeah, it's way too dumb, yeah I get those goosebumps every time, I need the Heimlich Throw that to the side, yeah I get those goosebumps every time, yeah, when you're not around When you throw that to the side, yeah I get those goosebumps every time",
    ),
  ];

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
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

  const NewsCard({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Переход на страницу с полным содержанием новости
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailPage(news: news),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Картинка
            Image.network(
              news.imageUrl,
              width: double.infinity,
              height: 200, // Можно настроить высоту по необходимости
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error); // Обработка ошибки загрузки
              },
            ),
            // Заголовок
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                news.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Страница с полным текстом новости и большой картинкой
class NewsDetailPage extends StatelessWidget {
  final NewsItem news;

  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar с эффектом уменьшения изображения при скролле
          SliverAppBar(
            expandedHeight: 300.0, // Высота изображения в раскрытом состоянии
            floating: true, // AppBar появляется при первом скролле
            snap: true, // Плавное появление AppBar при скролле
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                news.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error); // Ошибка при загрузке
                },
              ),
              // Параметр для отступа заголовка
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              collapseMode: CollapseMode.parallax, // Параллакс-эффект
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // Возвращение на предыдущую страницу
              },
            ),
          ),
          // Контент статьи
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    news.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    news.content,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
