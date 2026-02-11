import 'package:flutter/material.dart';
import 'package:pregnancy_calendar/data/local_data_source.dart';
import 'package:pregnancy_calendar/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ChecklistItem {
  final String id;
  final String title;
  final String description;
  final int startWeek;
  final int endWeek;
  bool isChecked;

  ChecklistItem({
    required this.id,
    required this.title,
    required this.description,
    required this.startWeek,
    required this.endWeek,
    this.isChecked = false,
  });
}

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({Key? key}) : super(key: key);

  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final LocalDataSource _dataSource = LocalDataSource();
  late List<ChecklistItem> _allItems;
  List<ChecklistItem> _filteredItems = [];
  int _currentWeek = 1;

  @override
  void initState() {
    super.initState();
    _initializeItems();
    _loadData();
  }

  void _initializeItems() {
    _allItems = [
      ChecklistItem(
        id: 'registration',
        title: 'Осмотр врача акушера-гинеколога с антропометрией',
        description: 'Измерением таза, осмотром в зеркалах и бимануальным исследованием',
        startWeek: 1,
        endWeek: 14,
      ),
      ChecklistItem(
        id: 'initial_tests',
        title: 'Первичные анализы',
        description: 'Общий анализ крови, мочи, биохимия крови, коагулограмма',
        startWeek: 1,
        endWeek: 14,
      ),
      ChecklistItem(
          id: 'specialists_consultation',
          title: 'Определение антител к вирусу краснухи и токсоплазме в крови',
          description: '1-14 неделя',
          startWeek: 1,
          endWeek: 14
      ),
      ChecklistItem(
        id: 'first_screening',
        title: 'Общий анализ мочи',
        description: '1-14 неделя',
        startWeek: 1,
        endWeek: 14,
      ),
      ChecklistItem(
        id: 'monthly_rh_control',
        title: 'Определение основных групп крови и резус-принадлежности',
        description: 'У резус-отрицательных женщин: обследование отца ребенка на групповую и резус-принадлежность',
        startWeek: 1,
        endWeek: 14,
      ),
      ChecklistItem(
        id: 'second_screening',
        title: 'Определение антител к бледной трепонеме, к вирусу иммунодефицита человека ВИЧ-1 и ВИЧ-2',
        description: 'К антигену вирусного гепатита B и к вирусному гепатиту C в крови',
        startWeek: 1,
        endWeek: 14,
      ),
      ChecklistItem(
          id: 'glucose_test',
          title: 'Микроскопия мазков на степень чистоты, на гонококк и кандиды (в т.ч. Фемофлор)',
          description: '1-14 неделя',
          startWeek: 1,
          endWeek: 14
      ),
      ChecklistItem(
        id: 'third_trimester_visits',
        title: 'Биохимический скрининг сывороточных маркеров - PAPP-A и бета-ХГЧ',
        description: '1-14 неделя',
        startWeek: 1,
        endWeek: 14,
      ),
      ChecklistItem(
        id: 'third_screening',
        title: 'Осмотры врачей',
        description: 'врача-терапевта',
        startWeek: 1,
        endWeek: 14,
      ),
      ChecklistItem(
        id: 'maternity_leave',
        title: 'Осмотры врачей',
        description: 'врача-стоматолога',
        startWeek: 1,
        endWeek: 14,
      ),
      ChecklistItem(
        id: 'rh_immunoglobulin',
        title: 'Осмотры врачей',
        description: 'врача-отоларинголога',
        startWeek: 1,
        endWeek: 14,
      ),
      ChecklistItem(
        id: 'ktg_monitoring',
        title: 'Осмотры врачей',
        description: 'врача-офтальмолога',
        startWeek: 1,
        endWeek: 14,
      ),
      ChecklistItem(
        id: 'hospital_admission',
        title: 'Осмотры врачей',
        description: 'других врачей-специалистов – по показаниям, с учетом сопутствующей патологии',
        startWeek: 1,
        endWeek: 14,
      ),
      ChecklistItem(
        id: 'postpartum_rh_prophylaxis',
        title: '1 УЗИ-скрининг',
        description: '11-14 неделя',
        startWeek: 1,
        endWeek: 14,
      ),
      ChecklistItem(
        id: 'vtoroi_trimestr_1',
        title: 'Общий анализ крови',
        description: '15-27 неделя',
        startWeek: 15,
        endWeek: 27,
      ),
      ChecklistItem(
        id: 'vtoroi_trimestr_2',
        title: 'Общий анализ мочи',
        description: '15-27 неделя',
        startWeek: 15,
        endWeek: 27,
      ),
      ChecklistItem(
        id: 'vtoroi_trimestr_3',
        title: 'Посев средней порции мочи (однократно)',
        description: '15-27 неделя',
        startWeek: 15,
        endWeek: 27,
      ),
      ChecklistItem(
        id: 'vtoroi_trimestr_4',
        title: 'Анализ крови на эстриол, альфа-фетопротеин, бета-ХГ',
        description: '15-27 неделя',
        startWeek: 15,
        endWeek: 27,
      ),
      ChecklistItem(
        id: 'vtoroi_trimestr_5',
        title: 'Осмотр врача акушера-гинеколога с определением окружности живота, высоты стояния дна матки, тонуса матки, пальпация частей плода, аускультация сердца плода',
        description: '15-27 неделя',
        startWeek: 15,
        endWeek: 27,
      ),
      ChecklistItem(
        id: 'vtoroi_trimestr_6',
        title: '2 УЗИ-скрининг',
        description: '18-21 неделя',
        startWeek: 15,
        endWeek: 27,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_1',
        title: 'Общий анализ крови',
        description: 'с 28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_2',
        title: 'Биохимичекий анализ крови',
        description: 'с 28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_3',
        title: 'Коагулограмма',
        description: 'с 28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_4',
        title: 'Определение антител к вирусу краснухи и токсоплазме в крови',
        description: 'с 28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_5',
        title: 'Общий анализ мочи',
        description: 'с 28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_6',
        title: 'Определение основных групп крови и резус-принадлежности',
        description: 'У резус-отрицательных женщин: обследование отца ребенка на групповую и резус-принадлежность.',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_7',
        title: 'Определение антител к бледной трепонеме, к вирусу иммунодефицита человека ВИЧ-1 и ВИЧ-2, к антигену вирусного гепатита B и к вирусному гепатиту C в крови',
        description: 'с 28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_8',
        title: 'Микроскопия мазков на степень чистоты, на гонококк и кандиды (в т.ч. Фемофлор)',
        description: 'с 28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_9',
        title: 'Осмотр врача акушера-гинеколога с определением окружности живота, высоты стояния дна матки, тонуса матки, пальпация частей плода, аускультация сердца плода',
        description: 'с 28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_10',
        title: 'Осмотр врача-терапевта',
        description: 'с 28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_11',
        title: 'Осмотр врача-стоматолога',
        description: 'с 28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_12',
        title: 'Кардиотокография плода',
        description: 'с 33 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_13',
        title: 'Пероральный глюкозотолерантный  тест',
        description: '24-28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_14',
        title: 'Определение резус-антител, если мама резус-отрицательна, а отец резус-положительный',
        description: 'с 28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_15',
        title: 'По показаниям - введение иммуноглобулина антирезус',
        description: 'с 28 недели',
        startWeek: 28,
        endWeek: 42,
      ),
      ChecklistItem(
        id: 'tretiy_trimestr_16',
        title: '3 УЗИ- скрининг с допплерометрией',
        description: '30-34 неделя',
        startWeek: 28,
        endWeek: 42,
      ),
    ];
    _filteredItems = _allItems;
  }

  Future<void> _loadData() async {
    await _loadCurrentWeek();
    await _loadChecklistState();
  }

  Future<void> _loadCurrentWeek() async {
    final conceptionDate = await _dataSource.getConceptionDate();
    if (conceptionDate != null) {
      final today = DateTime.now();
      final difference = today.difference(conceptionDate).inDays;
      setState(() => _currentWeek = (difference ~/ 7) + 1);
    }
  }

  Future<void> _loadChecklistState() async {
    final states = await _dataSource.loadChecklistState();
    setState(() {
      for (var item in _allItems) {
        item.isChecked = states[item.id] ?? false;
      }
    });
  }

  Future<void> _saveChecklistState() async {
    final states = {for (var item in _allItems) item.id: item.isChecked};
    await _dataSource.saveChecklistState(states);
  }

  Widget _buildWeekSelector() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Text(
            'Текущая неделя:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 12),
          DropdownButton<int>(
            value: _currentWeek,
            items: List.generate(42, (i) => i + 1)
                .map((week) => DropdownMenuItem(
              value: week,
              child: Text('$week неделя'),
            ))
                .toList(),
            onChanged: (value) => setState(() => _currentWeek = value!),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(ChecklistItem item) {
    final isActive = _currentWeek >= item.startWeek && _currentWeek <= item.endWeek;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: CheckboxListTile(
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 16,
            color: isActive ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: Text(
          item.description,
          style: TextStyle(
            fontSize: 14,
            color: isActive ? Colors.black54 : Colors.grey,
          ),
        ),
        secondary: Icon(
          Icons.medical_services,
          color: isActive ? AppConstants.primaryColor : Colors.grey[300],
        ),
        value: item.isChecked,
        onChanged: isActive
            ? (value) {
          setState(() => item.isChecked = value ?? false);
          _saveChecklistState();
        }
            : null,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: AppConstants.primaryColor,
        checkColor: Colors.white,
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Фильтры'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFilterOption('Все', () => _filterItems(null)),
            _buildFilterOption('Текущие', () => _filterItems(true)),
            _buildFilterOption('Выполненные', () => _filterItems(false)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String text, VoidCallback onTap) {
    return ListTile(
      title: Text(text),
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
    );
  }

  void _filterItems(bool? filter) {
    setState(() {
      _filteredItems = _allItems.where((item) {
        if (filter == null) return true;
        if (filter) {
          return _currentWeek >= item.startWeek &&
              _currentWeek <= item.endWeek;
        }
        return item.isChecked;
      }).toList();
    });
  }

  Future<void> _launchDoctorAppointment() async {
    const url = 'https://www.gosuslugi.ru/10059/1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось открыть сайт госуслуг')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Чек-лист'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.calendar_today, size: 20),
              label: const Text('Записаться к врачу'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstants.primaryColor, // заменил primary
                foregroundColor: Colors.white, // заменил onPrimary
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 2,
              ),
              onPressed: _launchDoctorAppointment,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildWeekSelector(),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredItems.length,
              itemBuilder: (context, index) =>
                  _buildChecklistItem(_filteredItems[index]),
            ),
          ),
        ],
      ),
    );
  }
}