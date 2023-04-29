import 'package:flutter/material.dart';
import 'package:money_app/app_colors.dart';
import 'package:money_app/model_util/saving_targets_util.dart';
import 'package:money_app/notifiers/money_saving_state.dart';
import 'package:money_app/tools/translate.dart';
import 'package:money_app/widgets/app_card.dart';
import 'package:money_app/widgets/app_drawer.dart';
import 'package:money_app/widgets/bold_text.dart';
import 'package:money_app/widgets/empty.dart';
import 'package:money_app/widgets/gray_text.dart';
import 'package:money_app/widgets/normal_text.dart';
import 'package:money_app/widgets/title_text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class MoneySaving extends StatefulWidget {
  const MoneySaving({super.key});

  @override
  State<MoneySaving> createState() => _MoneySavingState();
}

class _MoneySavingState extends State<MoneySaving> {
  final List<SavingTargetWithItsRecords> _savingTargets = [];
  init() {
    Provider.of<MoneySavingState>(context, listen: false).refreshTargets();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: TitleText(t('Saving List', 'قائمة الادخار')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<MoneySavingState>(
            builder: (context, value, child) {
              return value.savingTargets.isNotEmpty
                  ? ListView(
                      children: [
                        ...value.savingTargets
                            .map((e) => SavingTargetCard(savingTarget: e))
                            .toList()
                      ],
                    )
                  : const Empty();
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              {Navigator.of(context).pushNamed('/money-saving/add-target')},
          child: const Icon(Icons.add),
        ));
  }
}

class SavingTargetCard extends StatelessWidget {
  final SavingTargetWithItsRecords savingTarget;
  const SavingTargetCard({super.key, required this.savingTarget});

  @override
  Widget build(BuildContext context) {
    final t = translate(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
          '/money-saving/track-progress-of-saving',
          arguments: savingTarget),
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                  height: 75,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.delete),
                        NormalText(t('Delete', 'حذف')),
                      ],
                    ),
                    onPressed: () async {
                      await savingTarget.savingTargetDB.delete();
                      Provider.of<MoneySavingState>(context, listen: false)
                          .refreshTargets();
                      Navigator.pop(context);
                    },
                  ));
            });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: AppCard(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoldText(savingTarget.savingTargetDB.target_name!),
                const SizedBox(height: 10),
                LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  lineHeight: 6,
                  percent: savingTarget.percent,
                  animation: true,
                  isRTL: t(false, true),
                  barRadius: const Radius.circular(16),
                  backgroundColor: Colors.grey[200],
                  progressColor: savingTarget.percent >= 1
                      ? AppColors.green
                      : AppColors.yellow,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    GrayText(savingTarget.progress),
                    const Spacer(),
                    savingTarget.percent >= 1
                        ? GrayText(t('Done ✅', '✅ تم'))
                        : GrayText(
                            '${savingTarget.timeLeft} ${t('days left', 'يوم متبقي')}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
