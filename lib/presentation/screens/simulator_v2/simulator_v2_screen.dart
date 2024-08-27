import 'package:finniu/domain/entities/fund_entity.dart';
import 'package:finniu/presentation/providers/funds_provider.dart';
import 'package:finniu/presentation/providers/navigator_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/providers/v2_simulator_slider_provider.dart';
import 'package:finniu/presentation/screens/home_v2/widgets/navigation_bar.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/button_calculate.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/column_how_invest.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/custom_for_how_long.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/simulator_appbar.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/title_simulator.dart';
import 'package:finniu/presentation/screens/simulator_v2/widgets/type_investment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class V2SimulatorScreen extends HookConsumerWidget {
  const V2SimulatorScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int columnColorDark = 0xff0E0E0E;
    const int columnColorLight = 0xffDCF6FF;

    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(navigatorStateProvider.notifier).state = 1;
        });
        return null;
      },
      [],
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(columnColorDark) : const Color(columnColorLight),
        appBar: const AppBarSimulatorScreen(),
        bottomNavigationBar: const NavigationBarHome(
          colorBackground: Colors.transparent,
        ),
        extendBody: true,
        body: const SingleChildScrollView(
          child: Column(
            children: [
              TitleSimulator(),
              SimulatorBody(),
              SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}

class SimulatorBody extends ConsumerStatefulWidget {
  const SimulatorBody({Key? key}) : super(key: key);

  @override
  _SimulatorBodyState createState() => _SimulatorBodyState();
}

class _SimulatorBodyState extends ConsumerState<SimulatorBody> {
  FundEntity getCorporateFund(List<FundEntity> fundList) {
    return fundList.firstWhere((element) => element.fundType == FundTypeEnum.corporate);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(fundListFutureProvider.future).then((fundList) {
        final defaultEnterpriseFund = getCorporateFund(fundList);
        if (ref.read(defaultCorporateFundProvider) == null) {
          ref.read(defaultCorporateFundProvider.notifier).state = defaultEnterpriseFund;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final fundListAsyncValue = ref.watch(fundListFutureProvider);

    const int backgroundDark = 0xff191919;
    const int backgroundLight = 0xffFFFFFF;

    return fundListAsyncValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (fundList) {
        return Container(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(backgroundDark) : const Color(backgroundLight),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TypeInvestment(),
              ColumnHowInvest(),
              ColumnForHowLong(),
              ButtonCalculate(),
            ],
          ),
        );
      },
    );
  }
}
