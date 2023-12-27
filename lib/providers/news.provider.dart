import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/helpers/api.client.dart';
import 'package:news_app_clean_architecture/models/topNews.model.dart';

import '../utils/const.dart';

class NewsProvider with ChangeNotifier {
  bool isLoading = true;
  TopNewsModel? resNews;

  setLoading(data) {
    isLoading = data;
    notifyListeners();
  }

  getTopNews() async {
    final res = await api('${baseUrl}top-headlines?country=us&apiKey=$apiKey');

    if (res.statusCode == 200) {
      resNews = TopNewsModel.fromJson(res.data);
    } else {
      resNews = TopNewsModel();
    }
    isLoading = false;
    notifyListeners();
  }
}
