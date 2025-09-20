
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wabiz_app/view_model/login/login_view_model.dart';

class WabizAppShell extends ConsumerStatefulWidget {
  final Widget child;
  final int currentIndex;

  const WabizAppShell({
    super.key,
    required this.child,
    required this.currentIndex,
  });

  @override
  ConsumerState<WabizAppShell> createState() => _WabizAppShellState();
}

class _WabizAppShellState extends ConsumerState<WabizAppShell> {

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0: {
        GoRouter.of(context).go('/home');
        break;
      }
      case 1: {
        if (!ref.read(loginViewModelProvider).isLogin) {
          showDialog(context: context, builder: (context) => AlertDialog(
            content: Text('로그인이 필요한 서비스 입니다.'),
          ));
          return;
        }

        GoRouter.of(context).push('/add');
        break;
      }
      case 2: {
        // GoRouter.of(context).go('/favorite');
        context.go('/favorite');
        break;
      }
      case 3: {
        GoRouter.of(context).go('/my');
        break;
      }
      default: break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentIndex,
        onTap: (int index) => _onItemTapped(index, context),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: '프로젝트'),
          BottomNavigationBarItem(icon: Icon(widget.currentIndex == 2 ? Icons.favorite : Icons.favorite_border), label: '구독'),
          BottomNavigationBarItem(icon: Icon(widget.currentIndex == 3 ? Icons.person : Icons.person_2_outlined), label: '마이페이지'),
        ]
      ),
    );
  }
}
