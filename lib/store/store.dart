import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Store {
  // static BuildContext context;
  // static BuildContext widgetCtx;

  static init({context, child}) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => SearchModel()),
        // ChangeNotifierProvider(create: (_) => ColorModel()),
        // ChangeNotifierProvider(create: (_) => ShelfModel()),
        // ChangeNotifierProvider(create: (_) => ReadModel()),
      ],
      child: child,
    );
  }

  //  通过Provider.value<T>(context)获取状态数据
  static T value<T>(context) {
    return Provider.of(context, listen: false);
  }

  //  通过Consumer获取状态数据
  static Consumer connect<T>({builder, child}) {
    return Consumer<T>(builder: builder, child: child);
  }
}
