// ==================================================================================================================================
// https://flutter.dev/docs/cookbook/animation/page-route-animation
// ==================================================================================================================================


import 'package:flutter/material.dart';

const FIRST_PAGE = '/';
const SECOND_PAGE = '/secound';

Route<dynamic> generateRoute(RouteSettings settings) {
  // RouteSettingsをMaterialPageRouteのコンストラクタに渡さないと、画面間の引数の受け渡しができない。

  switch (settings.name) {
    case FIRST_PAGE:
      return MaterialPageRoute(
        builder: (context) => FirstPage(),
        settings: settings,
      );
    case SECOND_PAGE:

      // アニメーションを変更するにはPageRouteBuilderを使用する。
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => SecondPage(),
        settings: settings,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    default:
      throw Exception('無効なNamed Routeが指定されました。: ${settings.name}');
  }
}

class ChangeNavigationAnimation extends StatelessWidget {
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: generateRoute,
    );
  }
}

class FirstPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('ページ遷移のアニメーションを変更する。'),
            RaisedButton(
              child: Text('Go!'),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(SECOND_PAGE, arguments: 'これはあーぎゅめんと！');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  Widget build(BuildContext context) {
    String arg = ModalRoute?.of(context)?.settings?.arguments ?? 'でふぉち';
    assert(arg is String || arg == null);

    return Scaffold(
      appBar: AppBar(
        title: Text('second Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(arg),
            Text('Page 2'),
          ],
        ),
      ),
    );
  }
}
