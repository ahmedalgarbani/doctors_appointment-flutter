import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

import 'package:doctors_appointment/core/network/end_points.dart';
import 'package:doctors_appointment/features/blog/data/model/blog_model.dart';

part 'blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(BlogInitial()) {
    fetchBlogPosts();
  }

  Future<void> fetchBlogPosts() async {
    emit(BlogLoading());

    try {
      final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.blogPosts}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        final blogPosts = results
            .map((json) => BlogPost.fromJson(json))
            .toList();

        emit(BlogLoaded(blogPosts));
      } else {
        emit(BlogError('فشل تحميل البيانات. رمز الحالة: ${response.statusCode}'));
      }
    } catch (e) {
      emit(BlogError('حدث خطأ أثناء تحميل المقالات: $e'));
    }
  }
}
