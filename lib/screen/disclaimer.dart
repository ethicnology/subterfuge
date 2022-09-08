import 'package:flutter/material.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disclaimer')),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Center(
            child: Text(
              'Dependencies',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            'Applications relies on dependencies. These dependencies may contain bugs or vulnerabilities that I\'m not responsible for because they are developed and maintained by third parties. Subterfuge relies only on few dependencies, they are listed in the pubspec.yaml file in the root of the project repository.',
          ),
          Text(
            '\n- flutter maintained by google, the framework used to create this cross-platform app',
          ),
          Text(
            '\n- slip39-dart maintained by ilap, which is one of the listed reference implementations in the proposal',
          ),
          Text(
            '\n- convert maintained by dart.dev provide encoder/decoder functions',
          ),
          SelectableText.rich(TextSpan(children: [
            TextSpan(
                text: '\nsubterfuge',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: ': https://github.com/ethicnology/subterfuge',
                style: TextStyle(fontStyle: FontStyle.italic)),
            TextSpan(
                text: '\nslip39',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    ': https://github.com/satoshilabs/slips/blob/master/slip-0039.md',
                style: TextStyle(fontStyle: FontStyle.italic)),
            TextSpan(
                text: '\nslip39-dart',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(
                text: ': https://github.com/ilap/slip39-dart',
                style: TextStyle(fontStyle: FontStyle.italic)),
          ])),
          Center(
            child: Text(
              '\nRandomness',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(
              'Randomness in computer science is a whole research field that deal with random in a determinist system such as computers.'),
          Text(
              'The random secret generator in this program relies on Dart language "Random.secure()", it generates 32 numbers between 0 and 255 a.k.a. bytes.'),
          Text(
              'In my opinion, you should\'nt relies on subterfuge random generator and should find a better source of entropy such as dices, coins or true random generator…'),
          SelectableText(
              style: TextStyle(fontStyle: FontStyle.italic),
              '\nhttps://engineering.mit.edu/engage/ask-an-engineer/can-a-computer-generate-a-truly-random-number/')
        ],
      )),
    );
  }
}
