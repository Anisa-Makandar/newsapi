import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as webClient;
import 'package:news_api_integration/model/news_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: FutureBuilder(
            future: getNews(),
            builder: (_, snapshots) {
              if (snapshots.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshots.hasError) {
                return Center(
                  child: Text('Error : ${snapshots.error}'),
                );
              }
              if (snapshots.hasData) {
                return snapshots.data != null
                    ? snapshots.data!.articles!.isNotEmpty
                        ? ListView.builder(
                            itemCount: snapshots.data!.articles!.length,
                            itemBuilder: (_, index) {
                              return ListTile(
                                title: Text(
                                    '${snapshots.data!.articles![index].content}'),
                                subtitle:
                                    Text('${snapshots.data!.totalResults}'),
                              );
                            })
                        : Center(
                            child: Text('No News Found...!!!'),
                          )
                    : Center(
                        child: Text('Data Not Recevied !!!'),
                      );
              }
              return Container();
            }));
  }

  Future<NewsModel?> getNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=tesla&from=2024-09-25&sortBy=publishedAt&apiKey=e42cf34c53c449e6b2bca74fc1e987d4";
    var response = await webClient.get(Uri.parse(url));
    print(response);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return NewsModel.fromJson(data);
    }
  }
}
