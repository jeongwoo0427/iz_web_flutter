import 'package:flutter/material.dart';

abstract class FutureStatus {

  Widget buildLoader();

  Widget buildError();

  Widget buildNoData();

  Widget buildSuccess();
}

