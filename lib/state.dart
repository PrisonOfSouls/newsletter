import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsletter/news_data.dart';
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';

class ApplicationState extends ChangeNotifier {
  List<NewsData> _newsData = [];
  List<NewsData> _pupularsData = [];
  List<NewsData> _subscriptionsData = [];

  List<NewsData> get newsData => _newsData;
  List<NewsData> get pupularsData => _pupularsData;
  List<NewsData> get subscriptionsData => _subscriptionsData;

  bool _isViewDayTopic = true;

  bool get isViewDayTopic => _isViewDayTopic;

  ApplicationState() {
    initializeDateFormatting();
    loadData();
  }

  void hideDayTopic() {
    _isViewDayTopic = false;
    _newsData = _newsData.where((e) => e.isTopic != true).toList();
    notifyListeners();
  }

  void subscription(NewsData data) {
    (data.subscription == true)
        ? data.subscription = false
        : data.subscription = true;
    _subscriptionsData = _newsData
        .where((e) => (e.isTopic == false && e.subscription == true))
        .toList();
    notifyListeners();
  }

  loadData() async {
    try {
      String data = await rootBundle.loadString('assets/json/news.json');
      var newsJsonList = json.decode(data)['news'] as List;
      List<NewsData> newsList =
          newsJsonList.map((newsJson) => NewsData.fromJson(newsJson)).toList();

      _newsData = newsList;
      _pupularsData = newsList.where((e) => (e.isTopic == false && (e.likes ?? 0) > 10)).toList();
      _subscriptionsData = newsList
          .where((e) => (e.isTopic == false && e.subscription == true))
          .toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
