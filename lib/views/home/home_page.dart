import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wabiz_app/model/project/project_model.dart';
import 'package:wabiz_app/service/home/home_api_service.dart';
import 'package:wabiz_app/shared/widgets/project_large_widget.dart';
import 'package:wabiz_app/theme.dart';
import 'package:wabiz_app/view_model/home/home_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 324,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              onTap: () {

                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: AppColors.wabizGray[100]!,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: AppColors.wabizGray[100]!,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: AppColors.primary,
                                  ),
                                ),
                                hintText: '새로운 일상이 필요하신가요?',
                                suffixIcon: Icon(Icons.search),
                                suffixIconColor: AppColors.wabizGray[400],
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.notifications_none),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        bottom: 16
                      ),
                      child: Consumer(
                        builder: (context, ref, child) {
                          final categories = ref.watch(fetchHomeCategoriesProvider);
                          return switch(categories) {
                            AsyncData(:final value) => GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12,
                                  mainAxisSpacing: 0,
                                ),
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  final data = value[index];
                                  return InkWell(
                                    onTap: () {
                                      context.push('/home/category/${data.id}');
                                    },
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 38,
                                          backgroundColor: AppColors.bg,
                                          child: Image.asset(
                                            data.iconPath ?? '',
                                            height: 42,
                                          ),
                                        ),
                                        Gap(4),
                                        Text('${data.title}'),
                                      ],
                                    ),
                                  );
                                }
                            ),
                            AsyncError(:final error) => Text('${error.toString()}'),
                            _ => Center(
                              child: CircularProgressIndicator(),
                            )
                          };
                        }
                      ),
                    )
                  ),
                  Container(
                    width: 48,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Gap(12),
                ],
              ),
            ),
            Gap(12),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  // final project = ref.watch(homeViewModelProvider.notifier).fetchHomeData();
                  // final homeData = ref.watch(homeApiServiceProvider).getHomeProjects();
                  final homeData = ref.watch(fetchHomeProjectProvider);
                  return homeData.when(
                    data: (data) {
                      if (data.projects.isEmpty ?? true) {
                        return Column(
                          children: [
                            Text('정보가 없습니다'),
                            TextButton(
                                onPressed: () {},
                                child: Text('새로고침')
                            ),
                          ],
                        );
                      } else {
                        return Container(
                          color: Colors.white,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              final project = data.projects[index];
                              return ProjectLargeWidget(projectDataString: jsonEncode(project.toJson()));
                            }
                          ),
                        );
                      }
                    },
                    error: (error, trace) {
                      switch (error) {
                        case ConnectionTimeoutError():
                          return Center(
                            child: Text('${error.toString()}'),
                          );
                        case ConnectionError():
                          return Center(
                            child: Text('${error.toString()}'),
                          );
                        case UnsupportedError():
                          return Center(
                            child: Text('${error.toString()}'),
                          );
                      }

                      return globalErrorHandler(
                        error as ErrorHandler,
                        error as DioException,
                        ref,
                        fetchHomeProjectProvider,
                      );
                    },
                    loading: () => Center(child: CircularProgressIndicator(),)
                  );
                  // return FutureBuilder(
                  //   future: project,
                  //   builder: (context, snapshop) {
                  //     if (snapshop.hasData) {
                  //       final data = snapshop.data;
                  //       if (data?.projects.isEmpty ?? true) {
                  //         return Column(
                  //           children: [
                  //             Text('정보가 없습니다'),
                  //             TextButton(
                  //               onPressed: () {},
                  //               child: Text('새로고침')
                  //             ),
                  //           ],
                  //         );
                  //       } else {
                  //         return Container(
                  //           color: Colors.white,
                  //           child: ListView.builder(
                  //             itemCount: 10,
                  //             itemBuilder: (context, index) {
                  //               final project = data?.projects[index];
                  //               return InkWell(
                  //                 child: Container(
                  //                   margin: EdgeInsets.only(
                  //                     bottom: 8,
                  //                     left: 16,
                  //                     right: 16,
                  //                     top: 20,
                  //                   ),
                  //                   decoration: BoxDecoration(
                  //                     color: Colors.white,
                  //                     borderRadius: BorderRadius.circular(10),
                  //                     boxShadow: [
                  //                       BoxShadow(
                  //                         offset: Offset(0, 8),
                  //                         color: Colors.black.withOpacity(.1),
                  //                         blurRadius: 30,
                  //                         spreadRadius: 4,
                  //                       ),
                  //                     ]
                  //                   ),
                  //                   child: Column(
                  //                     crossAxisAlignment: CrossAxisAlignment.start,
                  //                     children: [
                  //                       Container(
                  //                         height: 220,
                  //                         decoration: BoxDecoration(
                  //                           color: Colors.grey,
                  //                           borderRadius: BorderRadius.only(
                  //                             topLeft: Radius.circular(10),
                  //                             topRight: Radius.circular(10),
                  //                           ),
                  //                           image: DecorationImage(
                  //                             image: CachedNetworkImageProvider(project?.thumbnail ?? ''),
                  //                             fit: BoxFit.cover
                  //                           )
                  //                         ),
                  //                       ),
                  //                       Padding(
                  //                         padding: const EdgeInsets.all(16.0),
                  //                         child: Column(
                  //                           crossAxisAlignment: CrossAxisAlignment.start,
                  //                           children: [
                  //                             Text(project?.isOpen == 'close'
                  //                               ? '${numberFormatter.format(project?.waitlistCount)}명이 기다려요'
                  //                               : '${numberFormatter.format(project?.waitlistCount)}명이 인증했어요',
                  //                               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.primary),),
                  //                             Gap(8),
                  //                             Text('${project?.title}',),
                  //                             Gap(16),
                  //                             Text('${project?.owner}', style: TextStyle(color: AppColors.wabizGray[500]),),
                  //                             Gap(16),
                  //                             Container(
                  //                               decoration: BoxDecoration(
                  //                                 color: AppColors.bg,
                  //                                 borderRadius: BorderRadius.circular(3),
                  //                               ),
                  //                               padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  //                               child: Text(project?.isOpen == 'close'
                  //                                 ? '오픈예정'
                  //                                 : '바로구매',
                  //                                 style: TextStyle(fontSize: 10),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               );
                  //             }
                  //           ),
                  //         );
                  //       }
                  //     }
                  //     return Center(
                  //       child: CircularProgressIndicator(),
                  //     );
                  //   }
                  // );
                }
              )
            )
          ],
        )
      ),
    );
  }
}

sealed class ErrorHandler {}

class ConnectionTimeoutError extends ErrorHandler {
  DioException exception;

  ConnectionTimeoutError(this.exception);
}

class ConnectionError extends ErrorHandler {
  DioException exception;

  ConnectionError(this.exception);
}

Widget globalErrorHandler(
  ErrorHandler? errorHandler,
  DioException? exception,
  WidgetRef? ref,
  ProviderOrFamily? provider,
) {
  return Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('${exception?.message}'),
        if (ref != null) 
          TextButton(
            onPressed: () {
              if (provider != null) {
                ref.invalidate(provider);
              }
            },
            child: Text('새로고침')
          ),
        TextButton(
          onPressed: () {
            Clipboard.setData(
              ClipboardData(text: exception?.stackTrace.toString() ?? '')
            );
          },
          child: Text('에러 보고')
        )
      ],
    ),
  );
}
