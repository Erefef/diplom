import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PregnancyCalculatorScreen extends StatefulWidget {
  const PregnancyCalculatorScreen({Key? key}) : super(key: key);

  @override
  PregnancyCalculatorScreenState createState() => PregnancyCalculatorScreenState();
}

class PregnancyCalculatorScreenState extends State<PregnancyCalculatorScreen> {
  DateTime? _lastPeriodDate;
  DateTime? _conceptionDate;
  CalculationMethod _method = CalculationMethod.lastPeriod;
  final DateFormat _dateFormat = DateFormat('dd.MM.yyyy');
  bool _showResults = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Калькулятор беременности')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMethodSelector(),
            const SizedBox(height: 20),
            _buildDateInput(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Рассчитать'),
            ),
            if (_showResults) ...[
              const SizedBox(height: 30),
              _buildResults(),
            ],
          ],
        ),
      ),
    );
  }

  // Метод выбора способа расчета
  Widget _buildMethodSelector() {
    return Column(
      children: [
        RadioListTile<CalculationMethod>(
          title: const Text('По дате зачатия/овуляции'),
          value: CalculationMethod.lastPeriod,
          groupValue: _method,
          onChanged: (value) => setState(() {
            _method = value!;
            _resetResults();
          }),
        ),
        RadioListTile<CalculationMethod>(
          title: const Text('По дате последней менструации'),
          value: CalculationMethod.conception,
          groupValue: _method,
          onChanged: (value) => setState(() {
            _method = value!;
            _resetResults();
          }),
        ),
      ],
    );
  }

  // Поле ввода даты
  Widget _buildDateInput() {
    return InkWell(
      onTap: _pickDate,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: _method == CalculationMethod.lastPeriod
              ? 'Дата последней менструации'
              : 'Дата зачатия/овуляции',
          border: const OutlineInputBorder(),
        ),
        child: Text(
          _method == CalculationMethod.lastPeriod
              ? _lastPeriodDate?.format(_dateFormat) ?? 'Выберите дату'
              : _conceptionDate?.format(_dateFormat) ?? 'Выберите дату',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  // Карточка с результатом
  Widget _buildResultCard(String title, String value) {
    return SizedBox( // <-- Добавляем SizedBox
      width: double.infinity, // Растягиваем на всю ширину
      child: Card(
        margin: const EdgeInsets.only(bottom: 15),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Выбор даты
  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        if (_method == CalculationMethod.lastPeriod) {
          _lastPeriodDate = date;
        } else {
          _conceptionDate = date;
        }
        _resetResults();
      });
    }
  }

  // Сброс результатов при изменении данных
  void _resetResults() {
    if (_showResults) {
      setState(() => _showResults = false);
    }
  }

  // Основной расчет
  void _calculate() {
    if ((_method == CalculationMethod.lastPeriod && _lastPeriodDate == null) ||
        (_method == CalculationMethod.conception && _conceptionDate == null)) {
      _showErrorDialog('Пожалуйста, выберите дату');
      return;
    }

    if (_calculateDueDate() == null) {
      _showErrorDialog('Невозможно рассчитать срок');
      return;
    }

    setState(() => _showResults = true);
  }

  // Отображение ошибок
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Расчет даты родов
  DateTime? _calculateDueDate() {
    try {
      return _method == CalculationMethod.lastPeriod
          ? _lastPeriodDate?.add(const Duration(days: 280))
          : _conceptionDate?.add(const Duration(days: 266));
    } catch (e) {
      return null;
    }
  }

  // Расчет срока беременности
  String? _calculateGestation() {
    try {
      final currentDate = DateTime.now();
      Duration? gestation;

      if (_method == CalculationMethod.lastPeriod) {
        gestation = currentDate.difference(_lastPeriodDate!);
      } else {
        final conceptionDate = _conceptionDate!.subtract(const Duration(days: 14));
        gestation = currentDate.difference(conceptionDate);
      }

      final weeks = gestation.inDays ~/ 7;
      final days = gestation.inDays % 7;
      return '$weeks недель ${days > 0 ? '$days дней' : ''}';
    } catch (e) {
      return null;
    }
  }

  // Расчет окончания первого триместра
  DateTime? _calculateFirstTrimesterEnd() {
    try {
      final startDate = _method == CalculationMethod.lastPeriod
          ? _lastPeriodDate!
          : _conceptionDate!.subtract(const Duration(days: 14));
      return startDate.add(const Duration(days: 13 * 7));
    } catch (e) {
      return null;
    }
  }

  // Расчет даты УЗИ
  DateTime? _calculateUltrasoundDate() {
    final dueDate = _calculateDueDate();
    return dueDate?.subtract(const Duration(days: 20 * 7));
  }

  // Расчет даты анти-D профилактики
  DateTime? _calculateAntiDDate() {
    final dueDate = _calculateDueDate();
    return dueDate?.subtract(const Duration(days: 28 * 7));
  }

  // Построение результатов
  Widget _buildResults() {
    final dueDate = _calculateDueDate();
    final gestation = _calculateGestation();
    final firstTrimesterEnd = _calculateFirstTrimesterEnd();
    final ultrasoundDate = _calculateUltrasoundDate();
    final antiDDate = _calculateAntiDDate();

    if (dueDate == null || gestation == null) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (dueDate != null)
          _buildResultCard('Предполагаемая дата родов', _dateFormat.format(dueDate)),
        if (gestation != null)
          _buildResultCard('Срок беременности', gestation),
        if (firstTrimesterEnd != null)
          _buildResultCard('Окончание первого триместра',
              _dateFormat.format(firstTrimesterEnd)),
        if (ultrasoundDate != null)
          _buildResultCard('Рекомендуемое время УЗИ',
              '${_dateFormat.format(ultrasoundDate)} (18-20 недель)'),
        if (antiDDate != null)
          _buildResultCard('Анти-D профилактика (для Rh-)',
              _dateFormat.format(antiDDate)),
      ],
    );
  }
}

extension DateFormatter on DateTime {
  String format(DateFormat formatter) => formatter.format(this);
}

enum CalculationMethod { lastPeriod, conception }