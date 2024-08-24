import 'dart:io';

import 'package:blog_supabase/core/error/failure.dart';
import 'package:blog_supabase/core/usecases/usecase.dart';
import 'package:blog_supabase/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_supabase/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class UploadBlogUsecase
    implements UseCase<BlogEntity, UploadBlogUsecaseParams> {
  final BlogRepository blogRepository;

  UploadBlogUsecase({required this.blogRepository});
  @override
  Future<Either<Failure, BlogEntity>> call(
      UploadBlogUsecaseParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      topics: params.topics,
      posterId: params.posterId,
    );
  }
}

class UploadBlogUsecaseParams {
  final File image;
  final String title;
  final String content;
  final List<String> topics;
  final String posterId;

  UploadBlogUsecaseParams({
    required this.image,
    required this.title,
    required this.content,
    required this.topics,
    required this.posterId,
  });
}
