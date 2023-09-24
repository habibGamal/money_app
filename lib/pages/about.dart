import 'package:flutter/material.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/app_drawer.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return Scaffold(
      appBar: AppBar(
        title: NormalText(t('About', 'حول التطبيق')),
      ),
      drawer: const AppDrawer(),
      body: SfPdfViewer.asset('assets/about.pdf'),
    );
  }
}
