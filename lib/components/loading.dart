import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final bool loading;

  const Loading({super.key, this.loading = true});

  @override
  Widget build(BuildContext context) {
    return loading
        ? Container(
            padding: const EdgeInsets.all(10),
            child: const Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : Container();
  }
}
