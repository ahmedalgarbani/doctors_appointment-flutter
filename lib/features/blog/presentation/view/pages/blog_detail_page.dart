import 'package:flutter/material.dart';
import 'package:doctors_appointment/features/blog/data/model/blog_model.dart';

class BlogDetailPage extends StatelessWidget {
  final BlogPost post;

  const BlogDetailPage({required this.post, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل المقال', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _sharePost(context),
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () => _bookmarkPost(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة المقال مع تأثير Hero
            Hero(
              tag: 'blog-image-${post.id}',
              child: Container(
                height: 280,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Image.network(
                    post.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 280,
                      color: Colors.grey[300],
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.broken_image, size: 60, color: Colors.grey[500]),
                          SizedBox(height: 8),
                          Text('تعذر تحميل الصورة', style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    loadingBuilder: (_, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 280,
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            
            // محتوى المقال
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان
                  Text(
                    post.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  
                  SizedBox(height: 16),
                  
                  // معلومات النشر
                  Row(
                    children: [
                      // CircleAvatar(
                      //   radius: 16,
                      //   backgroundImage: NetworkImage(post.authorImageUrl ?? ''),
                      //   child: post.authorImageUrl == null 
                      //       ? Icon(Icons.person, size: 16)
                      //       : null,
                      // ),
                      SizedBox(width: 8),
                     
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // child: Text(
                        //   post.category ?? 'عام',
                        //   style: TextStyle(
                        //     color: theme.primaryColor,
                        //     fontSize: 12,
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 24),
                  
                  // محتوى المقال
                  Text(
                    post.content,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      height: 1.8,
                      wordSpacing: 1,
                    ),
                  ),
                  
                  SizedBox(height: 32),
                  
                  // إحصائيات المقال
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(Icons.remove_red_eye, '${post.views} مشاهدة'),
                        // _buildStatItem(Icons.favorite_border, '${post.likes} إعجاب'),
                        // _buildStatItem(Icons.comment, '${post.comments} تعليق'),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 24),
                  
                  // وسوم المقال
                  // if (post.tags != null && post.tags!.isNotEmpty) ...[
                  //   Wrap(
                  //     spacing: 8,
                  //     runSpacing: 8,
                  //     children: post.tags!
                  //         .map((tag) => Chip(
                  //               label: Text('#$tag'),
                  //               visualDensity: VisualDensity.compact,
                  //             ))
                  //         .toList(),
                  //   ),
                  //   SizedBox(height: 24),
                  // ],
                  
                  // زر المشاركة
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.share),
                      label: Text('مشاركة المقال'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => _sharePost(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      
      // زر التعليقات العائم
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToComments(context),
        child: Icon(Icons.comment),
        tooltip: 'التعليقات',
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 14)),
      ],
    );
  }

  void _sharePost(BuildContext context) {
    // تنفيذ مشاركة المقال
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('جاري إعداد المقال للمشاركة...')),
    );
  }

  void _bookmarkPost() {
    // تنفيذ حفظ المقال
  }

  void _navigateToComments(BuildContext context) {
    // التنقل إلى قسم التعليقات
  }
}