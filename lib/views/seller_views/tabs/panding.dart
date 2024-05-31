import 'package:flutter/material.dart';

import '../../../utils/components/sellerScreenTiles/pandingSellerTile.dart';

class PandingTabSeller extends StatelessWidget {
  const PandingTabSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 12,
          child: ListView.builder(itemBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.all(10.0),
              child: PandingSellerCard(),
            );
          }),
        ),
      ],
    );
  }
}
