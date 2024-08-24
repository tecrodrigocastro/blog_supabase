part of 'blog_bloc.dart';

abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class UploadBlog extends BlogEvent {
  final File image;
  final String title;
  final String content;
  final List<String> topics;
  final String posterId;

  const UploadBlog({
    required this.image,
    required this.title,
    required this.content,
    required this.topics,
    required this.posterId,
  });

  @override
  List<Object> get props => [image, title, content, topics, posterId];
}
