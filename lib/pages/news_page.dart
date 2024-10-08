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
        title: "Автобусные экскурсии по ключевым историческим местам Москвы",
        imageUrl:
            "https://images.unsplash.com/photo-1598972394040-20cf1ec1efd3?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        content:
            "16.09-01.10.2024\n Погрузись в атмосферу героической истории столицы и узнай больше интересных фактов о городе на автобусных экскурсия проекта «Город Героев Москва» На автобусной экскурсии ты сможешь познакомиться с историей знаменитых мест Москвы - среди них улицы Тверская, Арбат, Кремлевская набережная, Кутузовский проспект и попасть в один из 5 исторических музеев Москвы: Государственный музей обороны Москвы, Музей истории ГУЛАГа, Музей-панорама «Бородинская битва», Музей Холодной войны «Бункер-42» на Таганке и Центральный музей Вооруженных сил Российской Федерации. Экскурсии пройдут 17, 19, 24, 26 сентября и 1 октября. \nmosmolodezh.ru"),
    NewsItem(
      title:
          "Открыт конкурс на определение города-соорганизатора Международного молодёжного форума — 2025",
      imageUrl:
          "https://images.unsplash.com/photo-1521574778337-d962ef81733d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      content:
          "16 сентября открылась регистрация на конкурс по определению города-соорганизатора Международного молодёжного форума 2025 года. Заявки от регионов России принимаются до 1 ноября на официальном сайте Дирекции Всемирного фестиваля молодёжи: \nhttps://wyffest.com/contests/2025-iyf-contest. \n«Согласно Поручениям Президента России Владимира Путина Всемирный фестиваль молодёжи будет проходить в нашей стране на регулярной основе. Одним из реализуемых форматов в рамках сохранения постфестивального наследия стал Международный молодёжный форум. Ежегодно на этой площадке будут собираться 2 тысячи талантливых представителей российской и зарубежной молодёжи. Участники смогут обсудить вызовы и возможности современности, предложить идеи для решения глобальных и региональных проблем, разработать совместные проекты по созданию нового многополярного мира, в авангарде которого будет именно молодёжь. Форум пройдёт уже в следующем году, поэтому мы приглашаем все регионы России принять участие в конкурсе и стать площадкой для развития международного молодёжного диалога», — рассказал советник руководителя Росмолодёжи по международным вопросам, генеральный директор Дирекции Всемирного фестиваля молодёжи Даниил Бисслингер. Конкурс будет проводиться по двум номинациям — «Город-соорганизатор» и «Региональная программа». По итогам первой номинации будет определён город, который станет основной площадкой проведения ММФ–2025. В ходе конкурсного отбора будут учитываться инфраструктура региона, опыт проведения крупных мероприятий, а также культурный код — культурное наследие, программа гостеприимства и природно-культурные объекты. Во второй номинации будут выбраны 10 субъектов России, в которых пройдёт региональная программа форума. Кандидатам также необходимо будет разработать концепцию региональной программы, включающей образовательный, содержательный, культурный, полезный и спортивный блоки. Принять участие в конкурсе могут все регионы России — вне зависимости от численности населения и местоположения. Конкурс будет проходить в два этапа: в рамках заочной оценки заявок Молодёжным экспертным советом будут определены 10 субъектов проведения региональной программы и 3 финалиста в номинации «Город-соорганизатор». Победитель конкурса будет выбран на Конгрессе выпускников Всемирного фестиваля молодёжи в ноябре 2024 года. В голосовании примут участие иностранные гости и Президиум Молодёжного экспертного совета. Проведение Международного молодёжного форума запланировано в сентябре 2025 года.",
    ),
    NewsItem(
      title: "Дни «Молодёжи Москвы» в столичных вузах",
      imageUrl:
          "https://media.istockphoto.com/id/949503640/photo/higher-school-of-economics-inmoscow-russia.jpg?s=612x612&w=0&k=20&c=uzh6spxt4OdhfNETkI60NOt2oLYti9Agk7DTcG198DA=",
      content:
          "В вузах и колледжах города снова проходят дни «Молодёжи Москвы». Студенты могут узнать больше о городских проектах, конкурсах и мероприятиях и всегда быть в курсе событий для молодёжи в столице. Также у них есть возможность присоединиться к команде «Молодёжи Москвы» в качестве амбассадоров проекта. На площадках вузов и колледжей представители проекта «Молодёжь Москвы» рассказывают о ключевых проектах, мероприятиях, студенческих конкурсах, в которых может участвовать каждый. После этого студенты приглашаются на ярмарку проектов, где у ребят есть возможность пообщаться с их командами, принять участие в различных активностях и войти в состав их активистов. Каждый может найти понравившееся сообщество для реализации своих интересов, среди которых карьерное продвижение, стендап-комедия, ораторское искусство, уличный спорт, КВН и многое другое. \nРасписание: \n13 сентября — ВШЭ \n16 сентября — МГРИ \n17 сентября — ММУ \n18 сентября — ИГА \n19 сентября — МФЮА \n19 сентября — МГТУ-МАСИ \n20 сентября — РГСУ",
    ),
    NewsItem(
      title:
          "Объединяя голоса и продвигая ценности: в «Сенеже» открылся Слёт студенческих медиа «Наши ценности»",
      imageUrl:
          "https://images.unsplash.com/photo-1565689157206-0fddef7589a2?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      content:
          "14 сентября в Мастерской управления «Сенеж» Минобрнауки России и Росмолодёжь запустили Слёт студенческих медиа «Наши ценности». Площадка станет местом для объединения более 150 представителей студенческих медиа из разных регионов России. Участники Слёта пройдут специальную образовательную программу, разработают собственные продукты и создадут единое сообщество, которое будет продвигать традиционные российские ценности в молодёжной среде. «Слёт студенческих медиа “Наши ценности” является точкой опоры, где молодые творческие люди смогут создать уникальные медиапродукты, задающие правильный вектор в обществе. Ведь сегодня именно молодёжь создаёт контент, формирует тренды и влияет на общественное мнение. И важно, чтобы этот вектор был направлен на любовь к Родине, стремление к созданию семьи и уверенности в будущем нашей страны», — отметил врио руководителя Росмолодёжи Денис Аширов. Программа Слёта сочетает 3 формата: интерактивный (для работы в команде), лекции и мастер-классы (для развития профессиональных навыков) и атмосферную досуговую программу. В числе спикеров — врио руководителя Росмолодёжи Денис Аширов, заместитель министра науки и высшего образования РФ Константин Могилевский, директор Департамента информации и печати МИД РФ Мария Захарова,  специальный корреспондент телеканала RT Константин Придыбайло, российская журналистка, медиа-технолог, член Общественной палаты РФ Екатерина Агранович, а также автор и ведущий передачи «Лабиринт Карнаухова» на «Соловьев LIVE» Сергей Карнаухов. Практическая часть программы форума поделит его участников на 17 редакций, каждой из которых будет необходимо подготовить плакат и ролик. Темой социальной рекламы выступит название одной из 17 традиционных ценностей, закреплённых Указом Президента России «Об утверждении Основ государственной политики по сохранению и укреплению традиционных российских духовно-нравственных ценностей». Проекты, созданные на форуме, позволят привлечь иностранных студентов в российские вузы. Это стало одной из ключевых задач, определённых Президентом России в новом нацпроекте «Молодёжь и дети». Проекты также поспособствуют продвижению России на международной арене в сфере молодёжной политики и формированию Международных клубов дружбы в российских субъектах.",
    ),
    NewsItem(
      title:
          "«Больше, чем команда»: отправиться в путешествие мечты по стране с новым конкурсом от программы Росмолодёжи",
      imageUrl:
          "https://media.istockphoto.com/id/1090097680/nl/foto/een-man-met-een-schoenen-en-vlag-van-rusland.jpg?s=612x612&w=0&k=20&c=0_j2BCxaR0T6OojKowIKvlariX5DGvFrnYPo6VQ-zQU=",
      content:
          "Запущен новый проект «Больше, чем команда» от программы Росмолодёжи «Больше, чем путешествие». Это шанс для молодых и активных людей от 18 лет отправиться в тур вместе со своей командой, узнать об уникальных возможностях внутреннего туризма России и получить новые знания. Для участия в проекте необходимо подать заявку по ссылке \nhttps://morethantrip.ru/puteshestvie\n и выполнить творческое задание. Шанс отправиться исследовать историю, природу и традиции разных уголков нашей страны вместе с программой «Больше, чем путешествие» смогут молодые люди из всех 89 регионов России. Подать заявку можно на тургруппу общей численностью не менее 10 человек. В команду могут входить родные, близкие, однокурсники и коллеги, единомышленники из разных сфер жизни – при этом вы можете проживать в разных субъектах страны. Участвовать могут и иностранные граждане, проживающие на территории РФ. Участие в проекте позволит молодым людям, влюблённым в путешествия, проявить себя, узнать об уникальных возможностях внутреннего туризма России, развить навыки командной работы, лидерские качества и раскрыть свой творческий потенциал. В случае победы на конкурсе «Больше, чем команда» каждый участник из команды получит персональный сертификат на поездку. Использовать его смогут только те, кто ещё не реализовал полученный ранее сертификат от программы «Больше, чем путешествие» в течение 2024 года. Если у участника есть другой сертификат, но он ещё не использован, к реализации будет необходимо выбрать один из них: полученный ранее или за победу в конкурсе «Больше, чем команда». Команды сами выбирают поездку, в которую хотят отправиться – доступные туры представлены на сайте конкурса. Это путешествия, в которых можно ближе узнать Россию и ещё больше полюбить её культурное и природное достояние. Они включают образовательную и полезную программы, позволяют освоить новые навыки, проявить себя и внести вклад в развитие посещаемой территории. Цель творческого задания конкурса – создать «путешествие мечты» и рассказать, почему именно ваша команда достойна отправиться в тур вместе с программой «Больше, чем путешествие». Ссылка на выполненное задание прикладывается к командной заявке на участие в конкурсе. Требования к заданию зависят от категории тура, в который смогут поехать победители. Для желающих отправиться в поездку по региону, в котором они проживают, необходимо написать тематическое эссе. Чтобы команда получила шанс поехать в тур по регионам федерального округа, к которому относится регион проживания, потребуется написать эссе и прислать сопроводительную презентацию. Для тех, кто хочет отправиться в многодневный тур по разным субъектам страны за пределами родного федерального округа, к эссе, презентации необходимо приложить также видеовизитку. Подробные требования к творческим заданиям и правила конкурса приведены в Положении о проекте «Больше, чем команда». Работы участников будут рассмотрены независимыми экспертами – критерии оценки также приведены в Положении о проекте на сайте. Победители получат приглашение отправиться в тур от программы «Больше, чем путешествие» по электронной почте, указанной при подаче заявки на конкурс. В случае победы можно реализовать сертификат на путешествие в любом доступном регионе. Если категория сертификата не предполагает обеспечиваемый организатором трансфер до места старта тура, участники берут соответствующие транспортные расходы на себя. Например, если выигран сертификат первой категории (тур по родному региону), но есть желание отправиться в такое путешествие в другом субъекте, можно воспользоваться такой возможностью, взяв расходы на проезд до этого субъекта на себя.",
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
            Padding(
              padding: const EdgeInsets.all(8.0), // Отступы вокруг изображения
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(12.0), // Радиус закругления углов
                child: Image.network(
                  news.imageUrl,
                  width: double.infinity,
                  height: 200, // Высота изображения
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error); // Обработка ошибки загрузки
                  },
                ),
              ),
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
                  SelectableText(
                    news.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 16.0),
                  SelectableText(
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
