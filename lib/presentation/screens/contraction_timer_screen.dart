import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pregnancy_calendar/data/models/contraction.dart';
import 'package:pregnancy_calendar/data/local_data_source.dart';

class ContractionTimerScreen extends StatefulWidget {
  const ContractionTimerScreen({Key? key}) : super(key: key);

  @override
  _ContractionTimerScreenState createState() => _ContractionTimerScreenState();
}

class _ContractionTimerScreenState extends State<ContractionTimerScreen> {
  DateTime? _startTime;
  List<Contraction> _contractions = [];
  late Timer _timer;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _loadData();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateTimer());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _loadData() async {
    final contractions = await LocalDataSource().getContractions();
    setState(() => _contractions = contractions);
  }

  void _updateTimer() {
    if (_startTime != null) {
      setState(() => _duration = DateTime.now().difference(_startTime!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Счётчик схваток')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          _buildTimerDisplay(),
          const SizedBox(height: 16),
          _buildControlButtons(),
          const Divider(height: 1),
          Expanded(
            child: Column(
              children: [
                Expanded(child: _buildContractionsList()),
                _buildFullWidthTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullWidthTable() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Этапы родов:',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
            },
            border: TableBorder.all(
              color: Colors.grey,
              width: 0.5,
              borderRadius: BorderRadius.circular(4),
            ),
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[200]),
                children: [
                  _buildTableCell('Длительность (сек)', isHeader: true),
                  _buildTableCell('Интервал (мин)', isHeader: true),
                  _buildTableCell('Раскрытие (см)', isHeader: true),
                ],
              ),
              _buildTableRow(['15-20', '0', '0']),
              _buildTableRow(['30', '15', '1']),
              _buildTableRow(['45', '7-10', '3']),
              _buildTableRow(['50', '5', '4']),
              _buildTableRow(['60', '5', '5']),
              _buildTableRow(['60', '3', '8']),
              _buildTableRow(['90', '1-2', '9-10']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isHeader ? 14 : 13,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  TableRow _buildTableRow(List<String> cells) {
    return TableRow(
      children: cells.map((text) => _buildTableCell(text)).toList(),
    );
  }

  Widget _buildTimerDisplay() {
    return Text(
      _formatDuration(_duration),
      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.play_arrow),
          label: const Text('Начало'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _startTime == null ? Colors.green : Colors.grey,
          ),
          onPressed: _startTime == null ? _startContraction : null,
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.stop),
          label: const Text('Конец'),
          style: ElevatedButton.styleFrom(
            backgroundColor: _startTime != null ? Colors.red : Colors.grey,
          ),
          onPressed: _startTime != null ? _endContraction : null,
        ),
      ],
    );
  }

  Widget _buildContractionsList() {
    if (_contractions.isEmpty) {
      return const Center(child: Text('Нет записанных схваток'));
    }
    return ListView.builder(
      itemCount: _contractions.length,
      itemBuilder: (context, index) {
        final contraction = _contractions[index];
        return ListTile(
          leading: const Icon(Icons.access_time),
          title: Text('${_formatTime(contraction.start)} - ${_formatTime(contraction.end)}'),
          subtitle: Text('Длительность: ${_formatDuration(contraction.duration)}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _deleteContraction(index),
          ),
        );
      },
    );
  }

  void _startContraction() {
    setState(() {
      _startTime = DateTime.now();
      _duration = Duration.zero;
    });
  }

  void _endContraction() async {
    if (_startTime == null) return;
    final contraction = Contraction(start: _startTime!, end: DateTime.now());
    await LocalDataSource().saveContraction(contraction);
    setState(() {
      _contractions.insert(0, contraction);
      _startTime = null;
      _duration = Duration.zero;
    });
  }

  String _formatDuration(Duration duration) {
    return '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Future<void> _deleteContraction(int index) async {
    await LocalDataSource().deleteContraction(_contractions[index]);
    setState(() => _contractions.removeAt(index));
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}