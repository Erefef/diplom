import 'package:flutter/material.dart';
import 'package:pregnancy_calendar/data/models/article.dart';
import 'article_detail_screen.dart';

class InterestingScreen extends StatelessWidget {
  final List<Article> articles = [
    Article(
      id: '1',
      title: 'Важность скринингового исследования беременных на каждом триместре нормальной беременности',
      contentPath: 'assets/articles/content/1.txt',
      imagePath: 'assets/articles/images/1.jpg',
      excerpt: 'Скрининг – метод исследования, позволяющий выявить возможные заболевания на ранних стадиях...',
    ),
    Article(
      id: '2',
      title: 'Материнский капитал и ежемесячные выплаты – размер, кому положены?',
      contentPath: 'assets/articles/content/2.txt',
      imagePath: 'assets/articles/images/2.jpg',
      excerpt: 'Материнский (семейный) капитал Размер маткапитала в 2025 году:...',
    ),
    Article(
      id: '3',
      title: 'Скрининговое исследование первого триместра',
      contentPath: 'assets/articles/content/3.txt',
      imagePath: 'assets/articles/images/3.jpg',
      excerpt: 'При  задержке менструации важно убедиться, что причина...',
    ),
    Article(
      id: '4',
      title: 'Срок беременности и дата рождения ',
      contentPath: 'assets/articles/content/4.txt',
      imagePath: 'assets/articles/images/4.jpg',
      excerpt: 'Срок беременности и дату родов определяют:...',
    ),
    Article(
      id: '5',
      title: 'Подготовка к грудному вскармливанию во время беременности.',
      contentPath: 'assets/articles/content/5.txt',
      imagePath: 'assets/articles/images/5.jpg',
      excerpt: 'Лактация (производство молока) - это естественное...',
    ),
    Article(
      id: '6',
      title: 'Пора ехать в роддом? Признаки начала родов',
      contentPath: 'assets/articles/content/6.txt',
      imagePath: 'assets/articles/images/6.jpg',
      excerpt: 'Шейку матки и цервикальный канал при наступлении...',
    ),
    Article(
      id: '7',
      title: 'Единовременные пособия при беременности',
      contentPath: 'assets/articles/content/7.txt',
      imagePath: 'assets/articles/images/7.jpg',
      excerpt: 'Женщинам, вставшим на учет в медицинских учреждениях в ранние ...',
    ),
    Article(
      id: '8',
      title: 'Как понять, что скоро рожать? Предвестники родов',
      contentPath: 'assets/articles/content/8.txt',
      imagePath: 'assets/articles/images/8.jpg',
      excerpt: 'Они могут появиться после 38-й недели...',
    ),
    Article(
      id: '9',
      title: 'Преэкламсия как грозное осложнение беременности',
      contentPath: 'assets/articles/content/9.txt',
      imagePath: 'assets/articles/images/9.jpg',
      excerpt: 'Преэклампсия – это осложнение второй половины...',
    ),
    Article(
      id: '10',
      title: 'Можно ли заниматься спортом при беременности?',
      contentPath: 'assets/articles/content/10.txt',
      imagePath: 'assets/articles/images/10.jpg',
      excerpt: 'Всем известно, что спортивные занятия благоприятно влияют...',
    ),
    Article(
      id: '11',
      title: 'С чем можно столкнуться во время нормальной беременности?',
      contentPath: 'assets/articles/content/11.txt',
      imagePath: 'assets/articles/images/11.jpg',
      excerpt: 'Всем известно, что спортивные занятия благоприятно влияют...',
    ),
    Article(
      id: '12',
      title: 'Значение скрининга на втором триместре. Что делать при плохих результатах обследования?',
      contentPath: 'assets/articles/content/12.txt',
      imagePath: 'assets/articles/images/12.jpg',
      excerpt: 'Скрининг второго триместра проводится методом УЗИ на...',
    ),
    Article(
      id: '13',
      title: 'Беременность и высокое давление – в чем опасность?',
      contentPath: 'assets/articles/content/13.txt',
      imagePath: 'assets/articles/images/13.jpg',
      excerpt: 'Артериальная гипертензия/гипертония (АГ) – состояние, которое...',
    ),
    Article(
      id: '14',
      title: 'Беременность и музыка',
      contentPath: 'assets/articles/content/14.txt',
      imagePath: 'assets/articles/images/14.jpg',
      excerpt: 'Основным вопросом на форумах по беременности является...',
    ),
    Article(
      id: '15',
      title: 'Гестационный дибет и причины его возникновения',
      contentPath: 'assets/articles/content/15.txt',
      imagePath: 'assets/articles/images/15.jpg',
      excerpt: 'Диабет беременных (гестационный диабет) – это повышение...',
    ),
    Article(
      id: '16',
      title: 'Что такое декрет?',
      contentPath: 'assets/articles/content/16.txt',
      imagePath: 'assets/articles/images/16.jpg',
      excerpt: 'Декретом называют период, который дается...',
    ),
    Article(
      id: '17',
      title: 'Диета для беременных в первом триместре беременности',
      contentPath: 'assets/articles/content/17.txt',
      imagePath: 'assets/articles/images/17.jpg',
      excerpt: 'В это период организм адаптируется к новому для него...',
    ),
    Article(
      id: '18',
      title: 'Диета в третьем триместре беременности',
      contentPath: 'assets/articles/content/18.txt',
      imagePath: 'assets/articles/images/18.jpg',
      excerpt: 'На седьмом – девятом месяцах беременности, женщины полнеют...',
    ),
    Article(
      id: '19',
      title: 'Запрещенные и не рекомендуемые продукты во время беременности',
      contentPath: 'assets/articles/content/19.txt',
      imagePath: 'assets/articles/images/19.jpg',
      excerpt: 'Рыба и мясо, которые используются при приготовлении тартара...',
    ),
    Article(
      id: '20',
      title: 'Запрещенный спорт во время беременности и рекомендации по триместрам',
      contentPath: 'assets/articles/content/20.txt',
      imagePath: 'assets/articles/images/20.jpg',
      excerpt: 'Запрещенные виды спорта во время беременности: верховая езда...',
    ),
    Article(
      id: '21',
      title: 'Чек-лист: что положить в сумку в роддом',
      contentPath: 'assets/articles/content/21.txt',
      imagePath: 'assets/articles/images/21.jpg',
      excerpt: 'Документы. С собой нужен паспорт, полис ОМС...',
    ),
    Article(
      id: '22',
      title: 'Правила сбора сумки в роддом',
      contentPath: 'assets/articles/content/22.txt',
      imagePath: 'assets/articles/images/22.jpg',
      excerpt: 'Когда нужно собирать сумку в роддом...',
    ),
    Article(
      id: '23',
      title: 'Беременность с гестационным диабетом: последствия для детей и общие рекомендации.',
      contentPath: 'assets/articles/content/23.txt',
      imagePath: 'assets/articles/images/23.jpg',
      excerpt: 'Диабет беременных (гестационный диабет) – это повышение уровня глюкозы...',
    ),
    Article(
      id: '24',
      title: 'Плюсы грудного вскармливания',
      contentPath: 'assets/articles/content/24.txt',
      imagePath: 'assets/articles/images/24.jpg',
      excerpt: 'Преимущества грудного вскармливания для ребенка:...',
    ),
    Article(
      id: '25',
      title: 'Партнерские роды – за или против?',
      contentPath: 'assets/articles/content/25.txt',
      imagePath: 'assets/articles/images/25.jpg',
      excerpt: 'Партнерские роды - это роды с помощником, когда помимо...',
    ),
    Article(
      id: '26',
      title: 'Когда есть повод обратиться к врачу?',
      contentPath: 'assets/articles/content/26.txt',
      imagePath: 'assets/articles/images/26.jpg',
      excerpt: '«Красные флаги» беременности...',
    ),
    Article(
      id: '27',
      title: 'Как понять, что беременна?',
      contentPath: 'assets/articles/content/27.txt',
      imagePath: 'assets/articles/images/27.jpg',
      excerpt: '«Предположительные (сомнительные) признаки...',
    ),
    Article(
      id: '28',
      title: 'Диета во втором триместре беременности',
      contentPath: 'assets/articles/content/28.txt',
      imagePath: 'assets/articles/images/28.jpg',
      excerpt: '«В этот период происходит активный рост плода. Поэтому организму беременной требуется дополнительная...',
    ),
    Article(
      id: '29',
      title: 'Витамины и беременность',
      contentPath: 'assets/articles/content/29.txt',
      imagePath: 'assets/articles/images/29.jpg',
      excerpt: '«Одна из ключевых причин, по которой приём витаминов во время беременности так важен, заключается в том, что они снижают...',
    ),
    Article(
      id: '30',
      title: 'Значение скрининга в 3 триместре беременности. Что делать при плохих результатах?',
      contentPath: 'assets/articles/content/30.txt',
      imagePath: 'assets/articles/images/30.jpg',
      excerpt: '«Третий триместр — финишная прямая беременности. К этому времени внутренние органы...',
    ),
    Article(
      id: '31',
      title: 'Почему важна подготовка к родам?',
      contentPath: 'assets/articles/content/31.txt',
      imagePath: 'assets/articles/images/31.jpg',
      excerpt: '«Несмотря на всю естественность процесса, положительное влияние предварительной психофизической подготовки...',
    ),
    Article(
      id: '32',
      title: 'Как отличить истинные схватки от ложных?',
      contentPath: 'assets/articles/content/32.txt',
      imagePath: 'assets/articles/images/32.jpg',
      excerpt: '«Ложные, или тренировочные, схватки могут возникать на любом сроке, а в третьем триместре иногда...',
    ),
  ];

InterestingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Интересное')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: articles.length,
        itemBuilder: (context, index) => _buildArticleCard(articles[index], context),
      ),
    );
  }

  Widget _buildArticleCard(Article article, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _openArticleDetail(context, article),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                article.imagePath,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.excerpt,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openArticleDetail(BuildContext context, Article article) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ArticleDetailScreen(article: article),
      ),
    );
  }
}