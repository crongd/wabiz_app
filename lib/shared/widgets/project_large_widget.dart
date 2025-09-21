import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wabiz_app/model/category/category_model.dart';
import 'package:wabiz_app/model/project/project_model.dart';
import 'package:wabiz_app/theme.dart';
import 'package:wabiz_app/view_model/favorite/favorite_view_model.dart';

class ProjectLargeWidget extends ConsumerWidget {
  final String projectDataString;
  final bool showFavorite;

  const ProjectLargeWidget({
    super.key,
    required this.projectDataString,
    this.showFavorite = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    final numberFormatter = NumberFormat('###,###,###,###');
    ProjectItemModel project = ProjectItemModel.fromJson(jsonDecode(projectDataString));
    return InkWell(
      onTap: () {
        context.push('/detail', extra: project.toJson());
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 8,
          left: 16,
          right: 16,
          top: 20,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 8),
                color: Colors.black.withOpacity(.1),
                blurRadius: 30,
                spreadRadius: 4,
              ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(project.thumbnail ?? ''),
                  fit: BoxFit.cover
                )
              ),
              child: Stack(
                children: [
                  if (showFavorite)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text('구독을 취소할까요?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        ref.read(favoriteViewModelProvider.notifier).removeItem(
                                          CategoryItemModel(
                                            id: project.id,
                                          )
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: Text('취소')
                                  )
                                ],
                              );
                            }
                        );
                      },
                      icon: Icon(Icons.favorite),
                      color: Colors.red,
                    )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project.isOpen == 'close'
                      ? '${numberFormatter.format(project.waitlistCount)}명이 기다려요'
                      : '${numberFormatter.format(project.totalFundedCount)}명이 인증했어요',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.primary),),
                  Gap(8),
                  Text('${project.title}',),
                  Gap(16),
                  Text('${project.owner}', style: TextStyle(color: AppColors.wabizGray[500]),),
                  Gap(16),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    child: Text(project.isOpen == 'close'
                        ? '오픈예정'
                        : '바로구매',
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
