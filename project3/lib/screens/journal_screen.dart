import 'package:flutter/material.dart';

class JournalScreen extends StatelessWidget {
  final List<Article> articles = [
    Article(
      title: "Article 01",
      image: "assets/Article.jpg",
      content:
          "Supporting men’s mental health is crucial, and there are several impactful ways to raise awareness and encourage well-being. First, creating safe, non-judgmental spaces for open conversations can help men feel less isolated. Integrating physical activities, such as group sports or wellness events, can also promote mental resilience by connecting physical and mental wellness. ",
    ),
    Article(
      title: "Article 02",
      image: "assets/Article2.jpg",
      content: "This is the content of Article 02...",
    ),
    Article(
      title: "Article 01",
      image: "assets/Article.jpg",
      content:
          "Supporting men’s mental health is crucial, and there are several impactful ways to raise awareness and encourage well-being. First, creating safe, non-judgmental spaces for open conversations can help men feel less isolated. Integrating physical activities, such as group sports or wellness events, can also promote mental resilience by connecting physical and mental wellness. ",
    ),
    Article(
      title: "Article 02",
      image: "assets/Article2.jpg",
      content: "This is the content of Article 02...",
    ),
    Article(
      title: "Article 01",
      image: "assets/Article.jpg",
      content:
          "Supporting men’s mental health is crucial, and there are several impactful ways to raise awareness and encourage well-being. First, creating safe, non-judgmental spaces for open conversations can help men feel less isolated. Integrating physical activities, such as group sports or wellness events, can also promote mental resilience by connecting physical and mental wellness. ",
    ),
    Article(
      title: "Article 02",
      image: "assets/Article2.jpg",
      content: "This is the content of Article 02...",
    ),
    Article(
      title: "Article 01",
      image: "assets/Article.jpg",
      content:
          "Supporting men’s mental health is crucial, and there are several impactful ways to raise awareness and encourage well-being. First, creating safe, non-judgmental spaces for open conversations can help men feel less isolated. Integrating physical activities, such as group sports or wellness events, can also promote mental resilience by connecting physical and mental wellness. ",
    ),
    Article(
      title: "Article 02",
      image: "assets/Article2.jpg",
      content: "This is the content of Article 02...",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources"),
        backgroundColor: Colors.greenAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: articles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return ArticleCard(
              article: articles[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ArticleDetailScreen(article: articles[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String image;
  final String content;

  Article({required this.title, required this.image, required this.content});
}

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({Key? key, required this.article, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  article.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                article.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({Key? key, required this.article})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          article.content,
          style: TextStyle(fontSize: 18, height: 1.5),
        ),
      ),
    );
  }
}
