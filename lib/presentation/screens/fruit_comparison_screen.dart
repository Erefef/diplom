import 'package:flutter/material.dart';

class FruitComparisonScreen extends StatefulWidget {
  const FruitComparisonScreen({Key? key}) : super(key: key);

  @override
  FruitComparisonScreenState createState() => FruitComparisonScreenState();
}

class FruitComparisonScreenState extends State<FruitComparisonScreen> {
  final TextEditingController _weekController = TextEditingController();
  FruitData? _selectedFruit;
  late List<FruitData> _fruits;

  @override
  void initState() {
    super.initState();
    _fruits = [
      FruitData(4, 'Малина', 'assets/fruits/raspberry.png', '4 см'),
      FruitData(8, 'Клубника', 'assets/fruits/strawberry.png', '1.6 см'),
      FruitData(12, 'Лимон', 'assets/fruits/lemon.png', '6 см'),
      FruitData(16, 'Авокадо', 'assets/fruits/avocado.png', '12 см'),
      FruitData(20, 'Банан', 'assets/fruits/banana.png', '25 см'),
      FruitData(24, 'Кукуруза', 'assets/fruits/corn.png', '30 см'),
      FruitData(28, 'Баклажан', 'assets/fruits/eggplant.png', '37 см'),
      FruitData(32, 'Тыква', 'assets/fruits/pumpkin.png', '42 см'),
      FruitData(36, 'Арбуз', 'assets/fruits/watermelon.png', '47 см'),
      FruitData(40, 'Тыква крупная', 'assets/fruits/big_pumpkin.png', '51 см'),
    ];
    _fruits.sort((a, b) => a.week.compareTo(b.week));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Какой фрукт ваш малыш?')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _weekController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Введите неделю беременности',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _findFruit,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_selectedFruit != null) _buildFruitCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildFruitCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Image.asset(
            _selectedFruit!.imagePath,
            height: 200,
            fit: BoxFit.contain,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Твой малыш похож на',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  _selectedFruit!.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Размер: ${_selectedFruit!.size}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Неделя беременности: ${_selectedFruit!.week}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _findFruit() {
    final week = int.tryParse(_weekController.text);
    if (week == null || week < 1 || week > 42) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Ошибка'),
          content: const Text('Введите корректный номер недели (1-42)'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      // Ищем первый фрукт с неделей БОЛЬШЕ ИЛИ РАВНОЙ введенной
      _selectedFruit = _fruits.firstWhere(
            (fruit) => fruit.week >= week,
        orElse: () => _fruits.last,
      );

      // Если введенная неделя меньше минимальной в списке
      if (week < _fruits.first.week) {
        _selectedFruit = _fruits.first;
      }
    });
  }
}

class FruitData {
  final int week;
  final String name;
  final String imagePath;
  final String size;

  FruitData(this.week, this.name, this.imagePath, this.size);
}