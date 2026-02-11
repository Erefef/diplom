import 'package:flutter/material.dart';
import 'package:pregnancy_calendar/utils/constants.dart';
import 'weight_tracker_screen.dart';
import 'contraction_timer_screen.dart';
import 'pregnancy_calculator_screen.dart'; // Добавляем импорт калькулятора
import 'fruit_comparison_screen.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Инструменты')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildToolCard(
            context,
            'Мониторинг веса',
            Icons.monitor_weight,
            const WeightTrackerScreen(),
          ),
          _buildToolCard(
            context,
            'Счётчик схваток',
            Icons.timer,
            const ContractionTimerScreen(),
          ),
          _buildToolCard(
            context,
            'Калькулятор беременности',
            Icons.calculate,
            const PregnancyCalculatorScreen(), // Теперь класс доступен
          ),
          _buildToolCard(
            context,
            'Какой фрукт ваш малыш?',
            Icons.emoji_food_beverage,
            const FruitComparisonScreen(),
          ),
        ],
      ),
    );
  }

  Widget _buildToolCard(
      BuildContext context,
      String title,
      IconData icon,
      Widget screen,
      ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 40, color: AppConstants.primaryColor),
              const SizedBox(width: 20),
              Text(title, style: const TextStyle(fontSize: 18)),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}