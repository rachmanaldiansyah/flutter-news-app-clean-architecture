import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/components/news.component.dart';
import 'package:news_app_clean_architecture/pages/search.page.dart';
import 'package:news_app_clean_architecture/providers/news.provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getNews() {
    Provider.of<NewsProvider>(context, listen: false).getTopNews();
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
        builder: (BuildContext context, news, Widget? child) {
      return RefreshIndicator(
        onRefresh: () async {
          news.setLoading(true);
          return await getNews();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Latest news today'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  news.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Column(
                          children: [
                            ...news.resNews!.articles!.map(
                              (e) => News(
                                title: e.title ?? "",
                                image: e.urlToImage ?? "",
                              ),
                            )
                          ],
                        )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
