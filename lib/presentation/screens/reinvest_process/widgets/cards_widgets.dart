import 'package:finniu/constants/colors.dart';
import 'package:finniu/constants/number_format.dart';
import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/presentation/providers/bank_provider.dart';
import 'package:finniu/presentation/providers/bank_user_account_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/back_account_register_modal.dart';
import 'package:finniu/domain/entities/re_investment_entity.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/modal_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
// Asegúrate de importar tu modelo de cuenta bancaria

class CreditCardWidget extends StatelessWidget {
  final String imageAsset;
  final BankAccount bankAccount;
  final Function onTap;

  const CreditCardWidget({
    super.key,
    required this.imageAsset,
    required this.onTap,
    required this.bankAccount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        // width: 288.3,
        // height: 171.6,
        width: 345.96,
        height: 205.92,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: imageAsset,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Text(
              BankAccount.getSafeBankAccountNumber(bankAccount.bankAccount),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(150, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreditCardWheel extends StatefulHookConsumerWidget {
  final String currency;
  final bool isSender; // Indica si la tarjeta es del remitente o del destinatario
  final String typeReInvestment;
  const CreditCardWheel({
    super.key,
    required this.currency,
    required this.isSender,
    required this.typeReInvestment,
  });

  @override
  _CreditCardWheelState createState() => _CreditCardWheelState();
}

class _CreditCardWheelState extends ConsumerState<CreditCardWheel> {
  bool showDetail = false;
  BankAccount? bankAccountSelected;
  String selectedImage = '';
  FixedExtentScrollController? controller;
  List<BankEntity> banks = [];

  @override
  void initState() {
    super.initState();
    controller = FixedExtentScrollController(initialItem: 0);

    //LOAD AFTER INIT STATE FINISH TO AVOID ERROR

    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   loadBanks();

    // });
    // loadBanks();
  }

  @override
  void dispose() {
    controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final bankAccountsAsyncValue = ref.watch(bankAccountFutureProvider);
        final banksAsyncValue = ref.watch(bankFutureProvider);
        final bool createdNewBankAccount = ref.watch(boolCreatedNewBankAccountProvider);

        return SizedBox(
          height: 480,
          width: double.infinity,
          child: bankAccountsAsyncValue.when(
            data: (bankAccounts) {
              return banksAsyncValue.when(
                data: (banks) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (createdNewBankAccount) {
                      controller?.animateToItem(
                        bankAccounts.length,
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeInOut,
                      );
                      ref.read(boolCreatedNewBankAccountProvider.notifier).state = false;
                    }
                  });
                  return showDetail
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Add return button that will set showDetail to false
                            Column(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.9,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.arrow_back_ios),
                                        onPressed: () {
                                          setState(() {
                                            showDetail = false;
                                          });
                                        },
                                      ),
                                      Text(
                                        bankAccountSelected!.alias ?? '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(primaryDark),
                                        ),
                                      ),
                                      // const SizedBox(width: 140),
                                      const Spacer(),
                                      Image.asset(
                                        'assets/icons/square2.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 299,
                              child: Text(
                                '${TypeAccountEnum.mapTypeAccountToLabel(bankAccountSelected!.typeAccount)} ${BankAccount.getSafeBankAccountNumber(bankAccountSelected!.bankAccount)}',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(height: 20),
                            CreditCardWidget(
                              imageAsset: selectedImage,
                              onTap: () {
                                setState(() {
                                  showDetail = false;
                                  bankAccountSelected = null;
                                });
                              },
                              bankAccount: bankAccountSelected!,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: 299,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  showAccountTransferModal(
                                    context,
                                    widget.currency,
                                    widget.isSender,
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(primaryLight),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/square2.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Agregar cuenta bancaria',
                                      style: TextStyle(
                                        color: Color(primaryDark),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: 299,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  //SET SELECTED BANK ACCOUNT
                                  if (widget.isSender) {
                                    ref
                                        .read(
                                          selectedBankAccountSenderProvider.notifier,
                                        )
                                        .state = bankAccountSelected;
                                  } else {
                                    ref
                                        .read(
                                          selectedBankAccountReceiverProvider.notifier,
                                        )
                                        .state = bankAccountSelected;
                                  }
                                  //pop modal
                                  Navigator.of(context).pop();
                                  if (widget.typeReInvestment == typeReinvestmentEnum.CAPITAL_ONLY &&
                                      !widget.isSender) {
                                    showThanksModal(context);
                                  }
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(primaryDark),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/square2.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Confirmar cuenta',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 360,
                              child: ListWheelScrollView.useDelegate(
                                controller: controller,
                                itemExtent: 220,
                                diameterRatio: 2,
                                physics: const FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    final bankAccount = bankAccounts[index % bankAccounts.length];
                                    final bank = banks.isNotEmpty
                                        ? BankEntity.getBankByName(
                                            bankAccount.bankName,
                                            banks,
                                          )
                                        : null;
                                    final imageAsset = bank?.cardImageUrl ??
                                        'https://finniu-statics.s3.amazonaws.com/finniu/images/bank/1db5fde8/agora.png';
                                    return CreditCardWidget(
                                      bankAccount: bankAccount,
                                      imageAsset: imageAsset,
                                      onTap: () async {
                                        if (!showDetail) {
                                          if (banks.isNotEmpty) {
                                            final selectedBank = BankEntity.getBankByName(
                                              bankAccount.bankName,
                                              banks,
                                            );
                                            setState(() {
                                              showDetail = true;
                                              bankAccountSelected = bankAccount;
                                              selectedImage =
                                                  selectedBank.cardImageUrl ?? 'assets/credit_cards/golden_card.png';
                                            });
                                          } else {
                                            // Manejar el caso cuando banks aún no está cargado
                                          }
                                        }
                                      },
                                    );
                                  },
                                  childCount: bankAccounts.length,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 299,
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  showAccountTransferModal(
                                    context,
                                    widget.currency,
                                    widget.isSender,
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: const Color(primaryLight),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/square2.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Agregar cuenta bancaria',
                                      style: TextStyle(
                                        color: Color(primaryDark),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => const Center(child: Text('Failed to load banks')),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => const Center(child: Text('Failed to load bank accounts')),
          ),
        );
      },
    );
  }
}

class FinalAmountWidget extends HookConsumerWidget {
  final double amount;
  final bool isSoles; // true for S/, false for $
  final bool isActive;

  const FinalAmountWidget({
    super.key,
    required this.amount,
    required this.isSoles,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(settingsNotifierProvider);
    const activeTextColor = Color(primaryDark); // Use the theme's primaryDark color
    const inactiveTextColor = Color(grayText); // Use the theme's grayText color
    const activeBackgroundColor = Color(0xFFEBFBFF); // Use the theme's primaryLight color
    const inactiveBackgroundColor = Color(0xFFF9FAFA); // Background color for inactive state

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 57,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isActive ? activeBackgroundColor : inactiveBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Image.asset(
              'assets/reinvestment/money_bag.png',
              height: 20,
              width: 20,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Monto final',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w800,
                          color: isActive ? activeTextColor : inactiveTextColor,
                        ),
                      ),
                    ),
                    Text(
                      isSoles ? formatterSoles.format(amount) : formatterUSD.format(amount),
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                        color: isActive ? activeTextColor : inactiveTextColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  '(Capital de la operación en curso + monto adicional)',
                  style: TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.w600,
                    color: isActive ? activeTextColor.withOpacity(0.6) : inactiveTextColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InvestmentDateRangeWidget extends HookConsumerWidget {
  final String startDate;
  final String endDate;

  const InvestmentDateRangeWidget({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(settingsNotifierProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 20,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          decoration: BoxDecoration(
            // color: const Color(0xFFF5F5F5), // Background color
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/reinvestment/calendar.png',
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 8.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Inicio: ',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.normal,
                        color: theme.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: startDate,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: theme.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 20,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
          decoration: BoxDecoration(
            // color: const Color(0xFFF5F5F5), // Background color
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/reinvestment/money_bag.png',
                height: 20,
                width: 20,
              ),
              const SizedBox(width: 8.0),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Finaliza: ',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.normal,
                        color: theme.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: endDate,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: theme.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
