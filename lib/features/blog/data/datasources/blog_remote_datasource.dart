import 'dart:io';

import 'package:blog_supabase/core/error/exception.dart';
import 'package:blog_supabase/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDatasource {
  Future<BlogModel> uploadBlog({required BlogModel blog});
  Future<String> uploadBlogImage({
    required File image,
    required BlogModel blog,
  });
}

class BlogRemoteDatasourceImpl implements BlogRemoteDatasource {
  final SupabaseClient client;

  BlogRemoteDatasourceImpl({required this.client});
  @override
  Future<BlogModel> uploadBlog({required BlogModel blog}) async {
    try {
      final response =
          await client.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(response.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File image, required BlogModel blog}) async {
    try {
      await client.storage.from('blog_images').upload(blog.id, image);
      return client.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
