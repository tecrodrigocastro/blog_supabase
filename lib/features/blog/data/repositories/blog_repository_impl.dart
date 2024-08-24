import 'dart:io';

import 'package:blog_supabase/core/error/exception.dart';
import 'package:blog_supabase/core/error/failure.dart';
import 'package:blog_supabase/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:blog_supabase/features/blog/data/models/blog_model.dart';
import 'package:blog_supabase/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_supabase/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDatasource blogRemoteDatasource;

  BlogRepositoryImpl({required this.blogRemoteDatasource});

  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required List<String> topics,
    required String posterId,
  }) async {
    try {
      BlogModel blog = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl =
          await blogRemoteDatasource.uploadBlogImage(image: image, blog: blog);

      blog = blog.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDatasource.uploadBlog(blog: blog);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
