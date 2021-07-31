import 'package:flutter/material.dart';
import 'package:mbeshtetu_app/src/models/selected_category.dart';

import 'components/body.dart';

class NavigationScreen extends StatelessWidget {
  final SelectedCat selectedCat;
  const NavigationScreen({this.selectedCat});

  @override
  Widget build(BuildContext context) {
    return Body(categorySelected: selectedCat);
  }
}