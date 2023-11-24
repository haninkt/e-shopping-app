import 'package:flutter/material.dart';

class Likes extends StatefulWidget {
  const Likes({super.key});

  @override
  State<Likes> createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  final List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Tool 1',
    'Tool 2',
    'Tool 3',
    'Tool 4',
    'Tool 5',
    'Cart 1',
    'Cart 2',
    'Cart 3',
    'Cart 4',
    'Cart 5'
    
  ];

  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Filter Demo'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (text) {
              setState(() {
                _searchTerm = text;
              });
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];

                if (_searchTerm.isEmpty ||
                    item.toLowerCase().contains(_searchTerm.toLowerCase())) {
                  return ListTile(
                    title: Text(item),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
