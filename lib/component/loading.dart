import 'package:app_firestore/component/cube_grid.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitCubeGrid(
      size: 51.0,
      color: Theme.of(context).primaryColor,
    );
  }
}