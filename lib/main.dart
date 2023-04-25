import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuto_provider/widgets/breadcrumb_widget.dart';
import 'package:tuto_provider/widgets/new_breadcrumb_widget.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BreadCrumbProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        routes: {
          '/new': (context) => const NewBreadCrumbWidget(),
        },
      ),
    ),
  );
}

class BreadCrumb {
  bool isActive;
  final String name;
  final String uuid;

  BreadCrumb({
    this.isActive = false,
    required this.name,
  }) : uuid = const Uuid().v4();

  void activate() {
    isActive = true;
  }

  @override
  bool operator ==(covariant BreadCrumb other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  String get title => name + (isActive ? '>' : '');
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];

//read_only
  UnmodifiableListView<BreadCrumb> get items => UnmodifiableListView(_items);

  void add(BreadCrumb breadCrumb) {
    for (final item in _items) {
      item.activate();
    }
    _items.add(breadCrumb);
    notifyListeners();
  }

  void reset() {
    _items.clear();
    notifyListeners();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Consumer<BreadCrumbProvider>(
              builder: (context, value, child) {
                return BreadCrumbWidget(
                  items: value.items,
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/new');
              },
              child: const Text('Add new bread'),
            ),
            TextButton(
              onPressed: () {
                context.read<BreadCrumbProvider>().reset();
                context.watch();
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
