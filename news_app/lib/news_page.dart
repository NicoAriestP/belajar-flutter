import 'package:flutter/material.dart';
import 'package:news_app/client.dart';
import 'package:news_app/detail_news_page.dart';
import 'package:news_app/response_articles.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late List<Article> listArticles;
  bool isLoading = false;

  Future getListArticles() async {
    setState(() {
      isLoading = true;
    });

    listArticles = await Client.fetchArticles();
    print(listArticles);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getListArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : listArticles.isEmpty
              ? const Text("Tidak ada data")
              : ListView.builder(
                  itemCount: listArticles.length,
                  itemBuilder: (context, index) {
                    final article = listArticles[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailNewsPage(article: article)));
                      },
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 5,
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(30),
                              ),
                              child: Image.network(
                                article.urlToImage,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  article.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Text(
                                    article.author,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  Text(
                                    article.publishedAt.toIso8601String(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[600],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
