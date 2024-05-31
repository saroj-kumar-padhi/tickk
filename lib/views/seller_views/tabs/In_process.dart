import 'package:flutter/material.dart';

import '../../../utils/components/sellerScreenTiles/process_tile.dart';

class AcceptedTabSeller extends StatelessWidget {
  const AcceptedTabSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 12,
          child: ListView.builder(itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(10.0),
              child: ProcessSellerCard(),
            );
          }),
        ),
      ],
    );
  }
}
