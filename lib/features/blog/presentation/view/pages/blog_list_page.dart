import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/blog_cubit.dart';
import '../widgets/blog_card.dart';
import 'blog_detail_page.dart';

class BlogListPage extends StatelessWidget {
  const BlogListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('المقالات')),
      body: BlocBuilder<BlogCubit, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BlogError) {
            return Center(child: Text(state.message));
          } else if (state is BlogLoaded) {
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return BlogCard(
                  post: post,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlogDetailPage(post: post),
                      ),
                    );
                  },
                );
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
