import 'package:flutter/material.dart';
import 'package:money_app/notifiers/app_state.dart';
import 'package:provider/provider.dart';

Function(dynamic, dynamic) translate(BuildContext context) {
  return (en, ar) {
    return Provider.of<AppState>(context).isAR ? ar : en;
  };
}
