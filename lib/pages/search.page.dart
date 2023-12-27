import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/components/news.component.dart';
import 'package:news_app_clean_architecture/providers/news.provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
        builder: (BuildContext context, news, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Berita yang Anda cari'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Cari berita...',
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        news.getSearch(searchController.text);
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                news.isDataEmpty
                    ? const SizedBox()
                    : news.isLoadingSearch
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              ...news.resSearch!.articles!.map(
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
      );
    });
  }
}
