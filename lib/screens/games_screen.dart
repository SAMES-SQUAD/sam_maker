import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sam_maker/utils/colors.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  String searchValue = '';
  final List<String> _suggestions = [
    'Argila',
    'Bola de gude',
    'Papel',
    'Bola',
    'Externas'
  ];

  Future<List<String>> _fetchSuggestions(String searchValue) async {
    await Future.delayed(const Duration(milliseconds: 750));

    return _suggestions.where((element) {
      return element.toLowerCase().contains(searchValue.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenWidth * 0.01,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppColors.primaryColor
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
        padding: EdgeInsets.all(screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchBar(
                backgroundColor: MaterialStateProperty.all<Color>(AppColors.secondaryColor),
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide.none,
                  ),
                ),
                elevation: MaterialStateProperty.all<double>(4.0),
                onChanged: (value) {
                  setState(() {
                    searchValue = value;
                  });
                },
                leading: const Icon(Icons.search),
              ),
              if (searchValue.isNotEmpty)
                Expanded(
                  child: FutureBuilder<List<String>>(
                    future: _fetchSuggestions(searchValue),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final suggestions = snapshot.data!;
                      return ListView.builder(
                        itemCount: suggestions.length,
                        itemBuilder: (context, index) {
                          final item = suggestions[index];
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              setState(() {
                                searchValue = item;
                              });
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
} 
