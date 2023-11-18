import 'package:flutter/material.dart';

import '../../widget/error_action_widget.dart';



mixin  FutureMixin{

  Widget buildLoader(){
    return const Center(
      child: Padding(padding: EdgeInsets.symmetric(vertical: 100), child: CircularProgressIndicator()),
    );
  }

  Widget buildError(){
    return Center(
        child: Text('오류가 발생했습니다.')
    );
  }

  Widget buildNoData(){
    return Center(
      child: Text('데이터가 없습니다.')
    );
  }

  @override
  Widget buildSuccess(data);
}
