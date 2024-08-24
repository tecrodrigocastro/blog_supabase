import 'dart:io';

import 'package:blog_supabase/features/blog/domain/entities/blog_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogBloc() : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
