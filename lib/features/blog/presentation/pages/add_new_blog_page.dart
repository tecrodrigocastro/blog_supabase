import 'dart:io';

import 'package:blog_supabase/core/theme/app_pallete.dart';
import 'package:blog_supabase/core/utils/pick_image.dart';
import 'package:blog_supabase/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();

    if (pickedImage != null) {
      image = pickedImage;
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Blog'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.check_mark_circled),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (image != null) ...[
                Image.file(
                  image!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
              ],
              GestureDetector(
                onTap: selectImage,
                child: DottedBorder(
                  color: Colors.grey,
                  dashPattern: const [10, 5],
                  radius: const Radius.circular(10),
                  borderType: BorderType.RRect,
                  strokeCap: StrokeCap.round,
                  child: const SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder_open,
                          size: 40,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Add Image',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    'Technology',
                    'Business',
                    'Programming',
                    'Entertainment',
                  ]
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (selectedTopics.contains(e)) {
                                selectedTopics.remove(e);
                              } else {
                                selectedTopics.add(e);
                              }
                              setState(() {});
                            },
                            child: Chip(
                              label: Text(e),
                              color: selectedTopics.contains(e)
                                  ? const WidgetStatePropertyAll(
                                      AppPallete.gradient1,
                                    )
                                  : null,
                              side: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 10),
              BlogEditor(controller: titleController, hintText: 'Blog Title'),
              const SizedBox(height: 10),
              BlogEditor(
                  controller: contentController, hintText: 'Blog Content'),
            ],
          ),
        ),
      ),
    );
  }
}
