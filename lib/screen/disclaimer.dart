import 'package:flutter/material.dart';

class DisclaimerScreen extends StatelessWidget {
  const DisclaimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disclaimer')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'This application relies on few dependencies. They are listed in the pubspec.yaml under the dependencies section.',
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
          ]))
        ],
      ),
    );
  }
}
