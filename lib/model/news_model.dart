class SourceModel {
  int? id;
  String? name;
  SourceModel({required this.id, required this.name});
  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ArticalModel {
  String? author;
  String? content;
  String? description;
  String? publishedAt;
  String? title;
  String? url;
  String? urlToImage;
  SourceModel? source;
  ArticalModel(
      {required this.author,
      required this.content,
      required this.description,
      required this.publishedAt,
      required this.title,
      required this.url,
      required this.urlToImage,
      required this.source});
  factory ArticalModel.fromJson(Map<String, dynamic> articaljson) {
    return ArticalModel(
        author: articaljson['author'],
        content: articaljson['content'],
        description: articaljson['description'],
        publishedAt: articaljson['publishedAt'],
        title: articaljson['title'],
        url: articaljson['url'],
        urlToImage: articaljson['urlToImage'],
        source: articaljson['source'] != null
            ? SourceModel.fromJson(articaljson['source'])
            : null);
  }
}

class NewsModel {
  String? status;
  int? totalResults;
  List<ArticalModel>? articles;
  NewsModel(
      {required this.status,
      required this.totalResults,
      required this.articles});
  factory NewsModel.fromJson(Map<String, dynamic> newsjson) {
    // List<ArticalModel> articalList = (newsjson['articles'] as List)
    //     .map((index) => ArticalModel.fromJson(index))
    //     .toList();
    // // for (Map<String, dynamic> eachMap in newsjson['articles']) {
    // //   articalList.add(ArticalModel.fromJson(eachMap));
    // // }
    List<ArticalModel> mNews = [];
    for (Map<String, dynamic> eachNews in newsjson['articles']) {
      mNews.add(ArticalModel.fromJson(eachNews));
    }

    return NewsModel(
      status: newsjson['status'],
      totalResults: newsjson['totalResults'],
      articles: mNews,
    );
  }
}
