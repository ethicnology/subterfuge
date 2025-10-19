import 'package:flutter/material.dart';
import 'package:subterfuge/features/home/page.dart';
import 'package:subterfuge/features/show_shares/shares_widget.dart';

class ShowSharesPage extends StatelessWidget {
  final List<String> shares;

  const ShowSharesPage({super.key, required this.shares});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shares')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...List.generate(shares.length, (index) {
              return SharesWidget(
                  number: '${index + 1}', shares: [shares[index]]);
            }),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
