import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'models/weight_entry.dart';
import 'models/contraction.dart';

class LocalDataSource {
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> saveConceptionDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('conception_date', _dateFormat.format(date));
  }

  Future<DateTime?> getConceptionDate() async {
    final prefs = await SharedPreferences.getInstance();
    final dateString = prefs.getString('conception_date');
    return dateString != null ? _dateFormat.parse(dateString) : null;
  }

  Future<void> saveComment(DateTime day, String comment) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dateFormat.format(day), comment);
  }

  Future<String?> getComment(DateTime day) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dateFormat.format(day));
  }

  Future<void> saveChecklistState(Map<String, bool> states) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('checklist', jsonEncode(states));
  }

  Future<Map<String, bool>> loadChecklistState() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('checklist');
    return data != null
        ? Map<String, bool>.from(jsonDecode(data))
        : {};
  }
  // Добавить методы:
  Future<void> saveWeightEntry(WeightEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = await getWeightHistory();
    entries.add(entry);
    await prefs.setString('weight_history', jsonEncode(entries.map((e) => e.toJson()).toList()));
  }

  Future<List<WeightEntry>> getWeightHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('weight_history');
    return data != null
        ? (jsonDecode(data) as List).map((e) => WeightEntry.fromJson(e)).toList()
        : [];
  }

  Future<void> saveContraction(Contraction contraction) async {
    final prefs = await SharedPreferences.getInstance();
    final contractions = await getContractions();
    contractions.add(contraction);
    await prefs.setString('contractions', jsonEncode(contractions.map((e) => e.toJson()).toList()));
  }

  Future<List<Contraction>> getContractions() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('contractions');
    return data != null
        ? (jsonDecode(data) as List).map((e) => Contraction.fromJson(e)).toList()
        : [];
  }

  Future<void> deleteContraction(Contraction contraction) async {
    final prefs = await SharedPreferences.getInstance();
    final contractions = await getContractions();
    contractions.removeWhere((c) => c.start == contraction.start && c.end == contraction.end);
    await prefs.setString('contractions', jsonEncode(contractions.map((e) => e.toJson()).toList()));
  }

  Future<void> deleteWeightEntry(WeightEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = await getWeightHistory();
    entries.removeWhere((e) => e.date == entry.date && e.weight == entry.weight);
    await prefs.setString('weight_history', jsonEncode(entries.map((e) => e.toJson()).toList()));
  }
}