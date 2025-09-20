import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../model/project/project_model.dart';
import '../../../theme.dart';

class ProjectWidget extends StatelessWidget {
  final ProjectItemModel projectItemModel;

  const ProjectWidget({
    super.key,
    required this.projectItemModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(projectItemModel.type ?? ''),
                  const Icon(Icons.keyboard_arrow_right),
                ],
              ),
              const Gap(12),
              Text(
                '${projectItemModel.title}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const Gap(12),
              Row(
                children: [
                  Text(
                    '${NumberFormat('###,###,###').format(
                        (((projectItemModel.totalFunded ?? 0) / (projectItemModel.price ?? 1)) * 100)
                    )} % 달성',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  const Gap(12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadiusGeometry.circular(3),
                    ),
                    child: Text(
                      '${DateTime.parse(projectItemModel.deadline ?? '').difference(DateTime.now()).inDays}일 남음',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                ],
              ),
              const Gap(12),
              Row(
                children: [
                  Text('${NumberFormat.currency(
                    locale: 'ko_KR',
                    symbol: '',
                  ).format(projectItemModel.totalFunded)}원 달성',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Gap(12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadiusGeometry.circular(3),
                    ),
                    child: Text(
                      '${projectItemModel.totalFundedCount} 명 참여',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        const Divider(
          color: AppColors.newBg,
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '프로젝트 스토리',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const Gap(12),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.newBg,
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                padding: const EdgeInsets.all(12),
                child: const Text('도서산간에 해당하는 서포터님은 배송 가능 여부를 반드시 메이커에게 문의 후 참여해 주세요.'),
              ),
              const Gap(12),
              Image.asset(
                width: double.infinity,
                'assets/image/advertising_image.png',
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
      ],
    );
  }
}