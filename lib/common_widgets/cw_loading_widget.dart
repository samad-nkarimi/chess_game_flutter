import 'package:flutter/material.dart';

import 'cw_container.dart';

class CWLoadingWidget extends StatelessWidget {
  const CWLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CWContainer(
        brAll: 15,
        color: Colors.orange,
        pad: [10, 10, 10, 10],
        child: CircularProgressIndicator(),
      ),
    );
  }
}
