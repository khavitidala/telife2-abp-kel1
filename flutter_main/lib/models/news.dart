class News {
  final String title;
  final String description;
  final String author;
  final String publishedAt;
  final String url;
  final String urlToImage;


  News({
    required this.title,
    required this.description,
    required this.author,
    required this.publishedAt,
    required this.url,
    required this.urlToImage
  });

  factory News.fromJson(Map<String, dynamic> json){
    return News(
      author: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
      publishedAt: json['publishedAt'] as String,
    );
  }
}