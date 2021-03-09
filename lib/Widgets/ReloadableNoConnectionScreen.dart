import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReloadableNoConnectionScreen extends StatelessWidget {
  final Future<void> Function() func;

  const ReloadableNoConnectionScreen({Key key, this.func}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        kBottomNavigationBarHeight -
        kTextTabBarHeight;
    return RefreshIndicator(
        child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return true;
            },
            child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                    alignment: Alignment.center,
                    color: Colors.grey[50],
                    height: bodyHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.signal_wifi_off,
                          size: 50,
                        ),
                        Text('No connection, reload to try again'),
                      ],
                    )))),
        onRefresh: func);
  }
}
