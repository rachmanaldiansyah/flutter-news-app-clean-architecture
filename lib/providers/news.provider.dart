import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/helpers/api.client.dart';
import 'package:news_app_clean_architecture/models/news.model.dart';

import '../utils/const.dart';

class NewsProvider with ChangeNotifier {
  bool isDataEmpty = true;
  bool isLoading = true;
  bool isLoadingSearch = true;

  NewsModel? resNews;
  NewsModel? resSearch;

  setLoading(data) {
    isLoading = data;
    notifyListeners();
  }

  getTopNews() async {
    final res = await api('${baseUrl}top-headlines?country=us&apiKey=$apiKey');

    if (res.statusCode == 200) {
      resNews = NewsModel.fromJson(res.data);
    } else {
      resNews = NewsModel();
    }
    isLoading = false;
    notifyListeners();
  }

  getSearch(String search) async {
    isDataEmpty = false;
    isLoadingSearch = true;
    notifyListeners();

    final res = await api(
        '${baseUrl}everything?q=$search&language=en&sortBy=popularity&apiKey=$apiKey');

    if (res.statusCode == 200) {
      resSearch = NewsModel.fromJson(res.data);
    } else {
      resSearch = NewsModel();
    }
    isLoadingSearch = false;
    notifyListeners();
  }
}
