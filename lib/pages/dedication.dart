import 'package:flutter/material.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/app_drawer.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:money_app/widgets/sizable_text.dart';

class Dedication extends StatelessWidget {
  const Dedication({super.key});

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return Scaffold(
      appBar: AppBar(
        title: NormalText(t('Who we are', 'من نحن')),
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SizableText(
              t('Who we are', 'من نحن'),
              fontSize: 28,
            ),
            const SizedBox(height: 10),
            SizableText(
              t('Under supervision :-', 'تحت اشراف :-'),
              fontSize: 24,
            ),
            const SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/dr_yasmin.jpg'),
            ),
            const SizedBox(height: 20),
            SizableText(
              t('Prof. Dr. / Yasmine Ahmed Al-Kahli',
                  'أ.د / ياسمين احمد الكحلي'),
              fontSize: 20,
            ),
            const SizedBox(height: 10),
            GrayText(t(
                'Vice Dean for Education and Student Affairs and Head of the Education Technology Department',
                'وكيل الكلية لشئون التعليم والطلاب ورئيس قسم تكنولوجيا التعليم')),
            const SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/dr_fatma.jfif'),
            ),
            const SizedBox(height: 20),
            SizableText(
              t('Dr. Fatima Mustafa Ahmed Al-Zahdi',
                  'د / فاطمة مصطفى احمد الزهدي'),
              fontSize: 20,
            ),
            const SizedBox(height: 10),
            GrayText(t('Home management teacher and family economics',
                'مدرس إدارة المنزل واقتصاديات الاسرة')),
            const SizedBox(height: 30),
            SizableText(
              t('who are we :-', 'من نحن :-'),
              fontSize: 24,
            ),
            const SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/dr_nada.jfif'),
            ),
            const SizedBox(height: 20),
            SizableText(
              t('Prepared by researcher Nada Mahmoud Ibrahim',
                  'اعداد الباحثة ندى محمود إبراهيم'),
              fontSize: 20,
            ),
            const SizedBox(height: 10),
            GrayText(t(
                'Teaching assistant in the Department of Home Economics College education quality Assiut University',
                'المعيدة بقسم الاقتصاد المنزلي كلية التربية النوعية جامعة اسيوط')),
          ],
        ),
      ),
    );
  }
}
