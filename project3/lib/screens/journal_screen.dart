import 'package:flutter/material.dart';

class JournalScreen extends StatelessWidget {
  final List<Article> articles = [
    Article(
      title: "10 Reliable Mental Health Institutes in Sri Lanka",
      image: "assets/article1.jpeg",
      content:
          "Mental health is essential for everyone, impacting how we think, act, and interact with others. Recognizing this, ten reputable organizations in Colombo offer mental health support tailored to various needs, from general emotional well-being to specialized help for addiction, trauma, and gender-based violence. Key organizations include Sri Lanka Sumithrayo, which provides non-judgmental emotional support, Alokaya Counselling Centre for psychological and relationship issues, and Mel Medura for addiction recovery. Other resources, like the National Council for Mental Health’s Sahanaya, Women in Need, and Shanthi Maargam, focus on rehabilitation, legal support for abuse survivors, and youth wellness, respectively, offering a range of services including phone consultations, counselling, and community programs. These organizations are committed to fostering resilience and supporting mental health across all ages and backgrounds in Colombo.",
    ),
    Article(
      title: "How to manage Anger at the moment",
      image: "assets/article2.jpeg",
      content:
          "Managing anger can feel challenging, especially in the heat of the moment, but there are effective techniques to help you regain control. First, try delaying your response by acknowledging your anger without justifying it, then step away from the situation if possible. Simple techniques like taking deep breaths, using grounding exercises (e.g., focusing on your surroundings or a grounding object), or practicing mindfulness can calm your mind and body. Distracting yourself with physical activities—such as exercise, tearing up paper, or doing something creative—can also release built-up tension safely. Sometimes, talking to a trusted person or expressing your feelings through journaling or art helps process anger. Experimenting with these strategies can help you discover what works best for you, so you can approach anger with greater control and self-awareness.",
    ),
    Article(
      title: "Don’t Let Mental Illness Bully You! Tips for Self-Compassion",
      image: "assets/article3.jpeg",
      content:
          "Mental illness can often feel like a bully, turning your thoughts against you and making daily life harder by amplifying self-doubt and self-criticism. Developing self-compassion can counteract this, though it may take practice. Start by catching and becoming aware of your inner critic, recognizing any self-critical thoughts that often go unnoticed. Next, identify and allow your emotions without judgment, validating them as normal human responses. Finally, shift your perspective by responding to self-criticism with self-kindness, acknowledging positive qualities or small actions you’ve done. Remember, self-compassion is a gradual journey, but with patience, you can cultivate a kinder, more supportive relationship with yourself.",
    ),
    // Article(
    //   title: "Article 02",
    //   image: "assets/Article2.jpg",
    //   content: "This is the content of Article 02...",
    // ),
    // Article(
    //   title: "Article 01",
    //   image: "assets/Article.jpg",
    //   content:
    //       "Supporting men’s mental health is crucial, and there are several impactful ways to raise awareness and encourage well-being. First, creating safe, non-judgmental spaces for open conversations can help men feel less isolated. Integrating physical activities, such as group sports or wellness events, can also promote mental resilience by connecting physical and mental wellness. ",
    // ),
    // Article(
    //   title: "Article 02",
    //   image: "assets/Article2.jpg",
    //   content: "This is the content of Article 02...",
    // ),
    // Article(
    //   title: "Article 01",
    //   image: "assets/Article.jpg",
    //   content:
    //       "Supporting men’s mental health is crucial, and there are several impactful ways to raise awareness and encourage well-being. First, creating safe, non-judgmental spaces for open conversations can help men feel less isolated. Integrating physical activities, such as group sports or wellness events, can also promote mental resilience by connecting physical and mental wellness. ",
    // ),
    // Article(
    //   title: "Article 02",
    //   image: "assets/Article2.jpg",
    //   content: "This is the content of Article 02...",
    // ),
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
