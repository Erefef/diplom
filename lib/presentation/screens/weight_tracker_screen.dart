import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../data/local_data_source.dart';
import '../../data/models/weight_entry.dart';
import 'package:pregnancy_calendar/utils/constants.dart';

class WeightTrackerScreen extends StatefulWidget {
  const WeightTrackerScreen({Key? key}) : super(key: key);

  @override
  WeightTrackerScreenState createState() => WeightTrackerScreenState();
}

class WeightTrackerScreenState extends State<WeightTrackerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _weightController = TextEditingController();
  List<WeightEntry> _weightHistory = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final entries = await LocalDataSource().getWeightHistory();
    setState(() => _weightHistory = entries);
  }

  Future<void> _deleteEntry(WeightEntry entry) async {
    await LocalDataSource().deleteWeightEntry(entry);
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мониторинг веса')),
      body: Column(
        children: [
          _buildInputForm(),
          Expanded(child: _buildWeightChart()),
          Expanded(child: _buildWeightList()),
        ],
      ),
    );
  }

  Widget _buildInputForm() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Вес (кг)',
                  border: OutlineInputBorder(),
                  suffixText: 'кг',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Введите вес';
                  final weight = double.tryParse(value);
                  if (weight == null || weight <= 0 || weight > 200) {
                    return 'Введите значение от 0.1 до 200';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.add_circle, size: 40),
              color: AppConstants.primaryColor,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await LocalDataSource().saveWeightEntry(WeightEntry(
                    date: DateTime.now(),
                    weight: double.parse(_weightController.text),
                  ));
                  _weightController.clear();
                  await _loadData();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightChart() {
    if (_weightHistory.isEmpty) {
      return const Center(child: Text('Нет данных для отображения'));
    }

    final sortedEntries = _weightHistory..sort((a, b) => a.date.compareTo(b.date));

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Убираем подписи снизу
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Убираем подписи слева
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: List.generate(
                sortedEntries.length,
                    (index) => FlSpot(
                  (index + 1).toDouble(),
                  sortedEntries[index].weight,
                ),
              ),
              isCurved: false,
              color: AppConstants.primaryColor,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          minX: 1,
          maxX: sortedEntries.length.toDouble(),
          minY: 0,
          maxY: sortedEntries.map((e) => e.weight).reduce((a, b) => a > b ? a : b) + 10,
        ),
      ),
    );
  }

  Widget _buildWeightList() {
    return ListView.builder(
      itemCount: _weightHistory.length,
      itemBuilder: (context, index) {
        final entry = _weightHistory[index];
        return ListTile(
          title: Text('${entry.weight} кг - ${entry.date}'),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => _deleteEntry(entry),
          ),
        );
      },
    );
  }
}
