part of 'blog_cubit.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  const BlogLoaded(this.posts);

  final List<BlogPost> posts;

  @override
  List<Object> get props => [posts];
}

class BlogError extends BlogState {
  const BlogError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
