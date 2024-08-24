part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogFailure extends BlogState {
  final String message;

  const BlogFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class BlogSuccess extends BlogState {
  final BlogEntity blogEntity;

  const BlogSuccess({required this.blogEntity});

  @override
  List<Object> get props => [blogEntity];
}
