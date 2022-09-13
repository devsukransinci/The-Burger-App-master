import 'package:flutter/material.dart';
import 'package:open_cart/providers/_mixins.dart';
import 'package:provider/provider.dart';

extension StringExtension on String {}

extension WidgetExtension on Widget {
  Widget withProviderProgress<P extends MixinProgressProvider>() => Stack(
        children: [
          this,
          Positioned.fill(
            child: Consumer<P>(builder: (context, provider, child) {
              if (provider.isLoading) {
                return const _ThisLoaderWidget();
              }

              return Container();
            }),
          ),
        ],
      );

  Widget withProviderProgress2<P1 extends MixinProgressProvider,
          P2 extends MixinProgressProvider>() =>
      Stack(
        children: [
          this,
          Positioned.fill(
            child: Consumer2<P1, P2>(builder: (context, p1, p2, child) {
              if (p1.isLoading || p2.isLoading) {
                return const _ThisLoaderWidget();
              }

              return Container();
            }),
          ),
        ],
      );
}

class _ThisLoaderWidget extends StatelessWidget {
  const _ThisLoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.25),
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
