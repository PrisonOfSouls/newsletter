import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newsletter/news_data.dart';
import 'package:newsletter/helpers.dart';
import 'package:newsletter/state.dart';
import 'package:provider/provider.dart';

class NewsNewTab extends StatelessWidget {
  final FutureOr<void> Function()? onClose;

  NewsNewTab({this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<ApplicationState>(builder: (context, appState, _) {
      return ListView.builder(
          itemCount: appState.newsData.length,
          itemBuilder: (BuildContext context, int index) {
            if (appState.newsData[index].isTopic) {
              return DayTopic(
                  header: appState.newsData[index].header ?? '',
                  onHide: () => appState.hideDayTopic());
            } else {
              return CardItem(
                data: appState.newsData[index],
                onSubscribe: (String id) =>
                    {appState.subscription(appState.newsData[index])},
              );
            }
          });
    }));
  }
}

class NewsPopularTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<ApplicationState>(builder: (context, appState, _) {
      return ListView.builder(
          itemCount: appState.pupularsData.length,
          itemBuilder: (BuildContext context, int index) {
            return CardItem(
              data: appState.pupularsData[index],
              onSubscribe: (String id) =>
                  {appState.subscription(appState.pupularsData[index])},
            );
          });
    }));
  }
}

class NewsSubscriptionsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Consumer<ApplicationState>(builder: (context, appState, _) {
      return ListView.builder(
          itemCount: appState.subscriptionsData.length,
          itemBuilder: (BuildContext context, int index) {
            return CardItem(
              data: appState.subscriptionsData[index],
              onSubscribe: (String id) =>
                  {appState.subscription(appState.subscriptionsData[index])},
            );
          });
    }));
  }
}

class CardItem extends StatelessWidget {
  final NewsData data;
  final FutureOr<void> Function(String id)? onSubscribe;

  CardItem({required this.data, this.onSubscribe});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(top: 10),
        shape: RoundedRectangleBorder(),
        elevation: 0,
        child: Column(
          children: [
            CardTop(data),
            CardContent(data),
            CardBottomBar(data,
                onSubscribe: () => {
                      if (this.onSubscribe != null) this.onSubscribe!(data.id!)
                    }),
          ],
        ));
  }
}

class CardTop extends StatelessWidget {
  final NewsData data;

  CardTop(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      child: Row(
        children: [
          CircleAvatar(
              radius: 12, child: Image.asset('assets/images/user.png')),
          VerticalDivider(width: 8),
          Text('${data.name}'),
          VerticalDivider(width: 8),
          Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.pink[400],
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                child: Text(
                  '1Г 2М ',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              )),
          VerticalDivider(width: 4),
          Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Center(
                child: Text(
                  '2H',
                  style: TextStyle(color: Colors.white, fontSize: 8),
                ),
              )),
        ],
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final NewsData data;

  CardContent(this.data);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 14),
        child: Column(
          children: [
            data.image != null
                ? Container(
                    color: Colors.white,
                    child: Image.asset('assets/images/${data.image}'))
                : Container(),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: (data.header != '')
                    ? Align(
                        alignment: Alignment.centerLeft,
                        child: Text('${data.header}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)))
                    : Container()),
            (data.text != '')
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                    child: (data.text != '')
                        ? Text('${data.text}', style: TextStyle(fontSize: 14))
                        : Container(),
                  )
                : Container(),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Helpers.formatDate(data.date!)}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Row(children: [
                      Icon(Icons.trending_flat, color: Colors.grey),
                      Text(
                        'От рождения до года',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ])
                  ],
                )),
            Divider(height: 1)
          ],
        ));
  }
}

class CardBottomBar extends StatelessWidget {
  final NewsData data;
  final void Function()? onSubscribe;
  final Color color;

  CardBottomBar(this.data, {this.color = Colors.grey, this.onSubscribe});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border, color: color)),
              Text('${data.likes}', style: TextStyle(color: color)),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.mode_comment_outlined),
                  color: color),
              Text('${data.comments}', style: TextStyle(color: color)),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share_outlined),
                  color: color)
            ],
          ),
          IconButton(
              onPressed: () {
                if (this.onSubscribe != null) this.onSubscribe!();
              },
              icon: (data.subscription!)
                  ? Icon(Icons.star, color: Colors.deepOrange)
                  : Icon(Icons.star_border))
        ],
      ),
    );
  }
}

class DayTopic extends StatelessWidget {
  final FutureOr<void> Function()? onHide;
  final String header;
  final String? text;

  DayTopic({this.header = '', this.text = '', this.onHide});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.cyan,
        shape: RoundedRectangleBorder(),
        margin: EdgeInsets.only(top: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.trending_flat, color: Colors.white70),
                            Text('Тема дня',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                        IconButton(
                            onPressed: onHide,
                            icon: Icon(Icons.close),
                            color: Colors.white70)
                      ])),
              Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: Text(this.header,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)))
            ]));
  }
}
