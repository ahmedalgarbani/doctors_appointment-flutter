class BlogPost {
  final int id;
  final String title;
  final String imageUrl;
  final String author;
  final String excerpt;
  final String content; 
  final int views;

  BlogPost({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.author,
    required this.excerpt,
    required this.content, 
    required this.views,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'],
      title: json['title'] ?? '',
      imageUrl: json['image'] ?? '',
      author: json['author'] ?? 'غير معروف',
      excerpt: json['excerpt'] ?? '',
      content: json['content'] ?? '',
      views: json['views_count'] ?? 0,
    );
  }
}
