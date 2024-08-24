import 'dart:io';

import 'package:blog_supabase/core/error/failure.dart';
import 'package:blog_supabase/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required List<String> topics,
    required String posterId,
  });
}
