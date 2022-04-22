import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:thespot/store/query/query_store.dart';

class QueryScreen extends StatelessWidget {
  const QueryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        var state = context.watch<QueryStore>().state;
        debugPrint('QueryScreen state => $state');
        return Container();
      },
    );
  }
}
