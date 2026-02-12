import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/local_data_source.dart';
import '../../utils/constants.dart';

class PregnancyInfoCard extends StatefulWidget {
  const PregnancyInfoCard({Key? key}) : super(key: key);

  @override
  PregnancyInfoCardState createState() => PregnancyInfoCardState();
}

class PregnancyInfoCardState extends State<PregnancyInfoCard> {
  final LocalDataSource _dataSource = LocalDataSource();
  DateTime? _conceptionDate;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadConceptionDate();
  }

  Future<void> _loadConceptionDate() async {
    final date = await _dataSource.getConceptionDate();
    if (mounted) {
      setState(() {
        _conceptionDate = date;
        _isLoading = false;
      });
    }
  }

  Future<void> refresh() async {
    setState(() => _isLoading = true);
    await _loadConceptionDate();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_conceptionDate == null) {
      return _buildEmptyState();
    }

    final now = DateTime.now();
    final dueDate = _conceptionDate!.add(
      const Duration(days: AppConstants.pregnancyDuration),
    );

    final daysPregnant = now.difference(_conceptionDate!).inDays;
    final daysPregnantDisplay = daysPregnant >= 0 ? daysPregnant : 0;

    final daysLeft = dueDate.difference(now).inDays;
    final weeksLeft = daysLeft > 0 ? (daysLeft / 7).ceil() : 0;
    final isOverdue = daysLeft <= 0;

    final progress = (daysPregnantDisplay / AppConstants.pregnancyDuration)
        .clamp(0.0, 1.0);

    final formattedDueDate = DateFormat('dd.MM.yyyy').format(dueDate);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 8,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.blue.shade50, // очень светлый голубой
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Дни беременности + иконка
              Row(
                children: [
                  Icon(Icons.pregnant_woman,
                      color: Colors.blueGrey.shade600, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TweenAnimationBuilder<int>(
                      tween: IntTween(begin: 0, end: daysPregnantDisplay),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      builder: (context, value, _) => RichText(
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade900,
                          ),
                          children: [
                            TextSpan(text: '$value '),
                            TextSpan(
                              text: _pluralizeDays(value),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Прогресс‑бар
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.blueGrey.shade100,
                color: Colors.blue.shade300,
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 16),
              // Осталось недель + иконка
              Row(
                children: [
                  Icon(Icons.timer,
                      color: Colors.blueGrey.shade500, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: isOverdue
                        ? Text(
                      '🎉 Малыш уже с вами!',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                        color: Colors.blueGrey.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                        : Text.rich(
                      TextSpan(
                        style: Theme.of(context).textTheme.titleLarge,
                        children: [
                          const TextSpan(text: 'Осталось '),
                          TextSpan(
                            text: weeksLeft > 0 ? '~$weeksLeft' : 'менее 1',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                              text: ' ${_pluralizeWeeks(weeksLeft)}'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // ПДР + иконка
              Row(
                children: [
                  Icon(Icons.calendar_month,
                      color: Colors.blueGrey.shade600, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'ПДР: $formattedDueDate',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Пустое состояние — тоже бело‑голубое
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.blue.shade200, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_reaction, size: 48, color: Colors.blue.shade300),
              const SizedBox(height: 12),
              Text(
                'Укажите первый день последних месячных',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Чтобы мы могли рассчитать срок',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _pluralizeDays(int days) {
    if (days % 10 == 1 && days % 100 != 11) return 'день';
    if (days % 10 >= 2 && days % 10 <= 4 && (days % 100 < 10 || days % 100 >= 20)) {
      return 'дня';
    }
    return 'дней';
  }

  String _pluralizeWeeks(int weeks) {
    if (weeks % 10 == 1 && weeks % 100 != 11) return 'неделя';
    if (weeks % 10 >= 2 && weeks % 10 <= 4 && (weeks % 100 < 10 || weeks % 100 >= 20)) {
      return 'недели';
    }
    return 'недель';
  }
}