import 'package:flutter/material.dart';
import 'package:open_cart/providers/auth_provider.dart';
import 'package:open_cart/providers/category_provider.dart';
import 'package:open_cart/providers/popular_deals_provider.dart';
import 'package:open_cart/screens/cart_screen.dart';
import 'package:open_cart/utils/colors.dart';
import 'package:open_cart/utils/constants.dart';
import 'package:open_cart/utils/sized_box_custom.dart';
import 'package:open_cart/utils/styles.dart';
import 'package:open_cart/utils/themes.dart';
import 'package:open_cart/utils/urls.dart';
import 'package:open_cart/widgets/cart_icon_with_count_widget.dart';
import 'package:open_cart/widgets/scrolling_position_indicator_widget.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:open_cart/utils/extensions.dart';

class HomeScreenBody extends StatelessWidget {
  /// The Class that respresents the TabBar View of thie main Home Page. Contains two widgets.
  /// A custom sliver appbar and a custom sliver list.
  const HomeScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        _HomeScreenCustomSliverAppBarWidget(),
        _HomeScreenCustomSliverListWidget(),
      ],
    );
  }
}

class _HomeScreenCustomSliverListWidget extends StatefulWidget {
  ///Custom Sliver list widget for the home screen body
  const _HomeScreenCustomSliverListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_HomeScreenCustomSliverListWidget> createState() =>
      _HomeScreenCustomSliverListWidgetState();
}

class _HomeScreenCustomSliverListWidgetState
    extends State<_HomeScreenCustomSliverListWidget> {
  late CategoryProvider _categoryProvider;
  late PopularDealsProvider _popularProvider;

  @override
  void initState() {
    _categoryProvider = CategoryProvider();
    _popularProvider = PopularDealsProvider();

    Future.microtask(() => _initAsync());
    super.initState();
  }

  @override
  void dispose() {
    _categoryProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CategoryProvider>.value(
            value: _categoryProvider,
          ),
          ChangeNotifierProvider<PopularDealsProvider>.value(
            value: _popularProvider,
          ),
        ],
        builder: (context, _) {
          return Consumer<CategoryProvider>(builder: (context, provider, _) {
            return SliverList(
                delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.all(2),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorOrangeCustom,
                  borderRadius: const BorderRadius.only(
                    topLeft: rC30,
                    topRight: rC30,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorGrey900,
                    borderRadius: const BorderRadius.only(
                      topLeft: rC30,
                      topRight: rC30,
                    ),
                  ),
                  child: Column(
                    children: const [
                      ScrollingPositionIndiacatorWidget(),
                      _HomeScreenCategoriesBoxWidget(),
                      SBH10(),
                      _HomeScreenPopularDealsWidget(),
                      SBH10(),
                      _HomeScreenCategoriesBoxWidget(),
                      SBH10(),
                      _HomeScreenCategoriesBoxWidget(),
                    ],
                  ),
                ),
              ).withProviderProgress<CategoryProvider>(),
            ]));
          });
        });
  }

  Future<void> _initAsync() async {
    await _categoryProvider.fetchProducts();
    await _popularProvider.fetchProducts();
  }
}

class _HomeScreenCategoriesBoxWidget extends StatelessWidget {
  const _HomeScreenCategoriesBoxWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorGrey900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _HomeScreenSectionHeaderWidget(headerText: 'Categories'),
          _HomeScreenCategoriesListWidget(),
          _HomeScreenCategoriesListWidget(),
          SBH10(),
        ],
      ),
    );
  }
}

class _HomeScreenCategoriesListWidget extends StatelessWidget {
  const _HomeScreenCategoriesListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      child: Consumer<CategoryProvider>(builder: (context, provider, _) {
        return SizedBox(
          width: double.infinity,
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.categoryList.length,
            itemBuilder: (context, index) => _HomeScreenItemBoxWidget(
              deviceSize: deviceSize,
              imageUrl:
                  provider.categoryList[index].categoryImageUrl.toString(),
              text: provider.categoryList[index].categoryName,
            ),
          ),
        );
      }),
    );
  }
}

class _HomeScreenItemBoxWidget extends StatelessWidget {
  final String text;
  final String imageUrl;
  const _HomeScreenItemBoxWidget(
      {Key? key,
      required this.deviceSize,
      required this.text,
      required this.imageUrl})
      : super(key: key);

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: SizedBox(
        width: deviceSize.width * (1 / 4),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorRed50,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(5),
              width: 70,
              height: 70,
              child: Image.network(imageUrl),
            ),
            const SBH5(),
            Text(text, style: tsCwhiteFFPrimaryS12),
          ],
        ),
      ),
    );
  }
}

class _HomeScreenPopularDealsWidget extends StatelessWidget {
  const _HomeScreenPopularDealsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _HomeScreenSectionHeaderWidget(headerText: 'Popular Deals'),
          _HomeScreenPopularDealsListWidget(),
          SBH10(),
        ],
      ),
    );
  }
}

class _HomeScreenPopularDealsListWidget extends StatelessWidget {
  const _HomeScreenPopularDealsListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Consumer<PopularDealsProvider>(builder: (context, provider, _) {
        return SizedBox(
          width: double.infinity,
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.categoryList.length,
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * (1 / 4),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(5),
                            width: 70,
                            height: 70,
                            child: Image.network(provider
                                    .categoryList[index].popularDealsImageUrl ??
                                loadErrorImageUrl),
                          ),
                          const SBH5(),
                          Text(
                              provider.categoryList[index].popularDealsName
                                  .toString(),
                              style: TextStyle(
                                  color: colorFF,
                                  fontSize: 10,
                                  fontFamily: primaryFont)),
                        ],
                      ),
                    ),
                  )),
        );
      }),
    );
  }
}

class _HomeScreenSectionHeaderWidget extends StatelessWidget {
  final String headerText;
  const _HomeScreenSectionHeaderWidget({Key? key, required this.headerText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        headerText,
        style: tsCffFFprimaryS20,
      ),
    );
  }
}

class _HomeScreenCustomSliverAppBarWidget extends StatelessWidget {
  const _HomeScreenCustomSliverAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      iconTheme: sliverAppBarIconTheme,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      centerTitle: true,
      actions: const [
        _FavouriteButtonWidget(),
        CartIconWithCounter(),
      ],
      expandedHeight: MediaQuery.of(context).size.height / 3,
      flexibleSpace: const _HomeScreenCustomFlexibleSpaceBar(),
    );
  }
}

class CartIconWithCounter extends StatelessWidget {
  const CartIconWithCounter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.route);
            },
            icon: const Icon(Icons.shopping_cart_outlined)),
        const Positioned(top: 0, right: 3, child: CountWidget()),
      ],
    );
  }
}

class _FavouriteButtonWidget extends StatelessWidget {
  const _FavouriteButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.favorite),
    );
  }
}

class _HomeScreenCustomFlexibleSpaceBar extends StatefulWidget {
  const _HomeScreenCustomFlexibleSpaceBar({
    Key? key,
  }) : super(key: key);

  @override
  State<_HomeScreenCustomFlexibleSpaceBar> createState() =>
      _HomeScreenCustomFlexibleSpaceBarState();
}

class _HomeScreenCustomFlexibleSpaceBarState
    extends State<_HomeScreenCustomFlexibleSpaceBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _HomeScreenHeyUserWidget(),
                      _HomeScreenWelcomeWidget(),
                      SBH10(),
                      SBH10(),
                      _HomeScreenSelectLocationDropdownWidget(),
                    ],
                  ),
                ),
                Expanded(
                  child: Image.network(homePageMainImage),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeScreenHeyUserWidget extends StatelessWidget {
  const _HomeScreenHeyUserWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Hey!',
      style: TextStyle(color: colorFF, fontSize: 30, fontFamily: primaryFont),
    );
  }
}

class _HomeScreenWelcomeWidget extends StatelessWidget {
  const _HomeScreenWelcomeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to',
          style: tsCwhiteFFPrimaryS15,
        ),
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'BurgerSpot',
              textStyle: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  color: colorOrangeCustom),
              speed: const Duration(milliseconds: 200),
            ),
          ],
          repeatForever: true,
          // pause: const Duration(milliseconds: 100),
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        )
      ],
    );
  }
}

class _HomeScreenSelectLocationDropdownWidget extends StatelessWidget {
  const _HomeScreenSelectLocationDropdownWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: colorOrangeCustom,
        ),
        const SBW5(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CyberPark',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: colorFF,
                  fontFamily: primaryFont),
            ),
            Text(
              'Palazhi, Bypass, Calicut',
              style: TextStyle(
                  fontWeight: FontWeight.w400, color: colorFF, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}
