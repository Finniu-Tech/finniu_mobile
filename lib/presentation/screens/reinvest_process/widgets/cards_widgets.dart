import 'package:finniu/constants/colors.dart';
import 'package:finniu/domain/entities/bank_entity.dart';
import 'package:finniu/domain/entities/user_bank_account_entity.dart';
import 'package:finniu/presentation/providers/bank_provider.dart';
import 'package:finniu/presentation/providers/bank_user_account_provider.dart';
import 'package:finniu/presentation/providers/re_investment_provider.dart';
import 'package:finniu/presentation/screens/reinvest_process/widgets/back_account_register_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
// Asegúrate de importar tu modelo de cuenta bancaria

class CreditCardWidget extends StatelessWidget {
  final String imageAsset;
  final BankAccount bankAccount;
  final Function onTap;

  const CreditCardWidget({
    Key? key,
    required this.imageAsset,
    required this.onTap,
    required this.bankAccount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        width: 288.3,
        height: 171.6,
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
              errorWidget: (context, url, error) => Icon(Icons.error),
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
              '**** ${bankAccount.bankAccount.substring(bankAccount.bankAccount.length - 4)}',
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

  const CreditCardWheel({Key? key, required this.currency}) : super(key: key);

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
    controller = FixedExtentScrollController(initialItem: 1);

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

  // Future<void> loadBanks() async {
  //   banks = await ref.read(bankFutureProvider.future);
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final bankAccountsAsyncValue = ref.watch(bankAccountFutureProvider);
        final banksAsyncValue = ref.watch(bankFutureProvider);

        return SizedBox(
          height: 400,
          width: double.infinity,
          child: bankAccountsAsyncValue.when(
            data: (bankAccounts) {
              return banksAsyncValue.when(
                data: (banks) {
                  // Ambos providers han cargado exitosamente
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
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Color(primaryDark),
                                        ),
                                      ),
                                      const SizedBox(width: 140),
                                      Image.asset(
                                        'assets/icons/square2.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 299,
                              child: Text(
                                '${bankAccountSelected!.typeAccount}  **** ${bankAccountSelected!.bankAccount.substring(bankAccountSelected!.bankAccount.length - 4)}',
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
                              bankAccount: bankAccounts.first,
                            ),
                            SizedBox(height: 20),
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
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {},
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
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  //SET SELECTED BANK ACCOUNT
                                  print('bank account selected: ${bankAccountSelected!.bankName}');
                                  ref.read(selectedBankAccountProvider.notifier).state = bankAccountSelected;
                                  //pop modal
                                  Navigator.of(context).pop();
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
                              height: 280,
                              child: ListWheelScrollView.useDelegate(
                                controller: controller,
                                itemExtent: 150,
                                diameterRatio: 2,
                                physics: const FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    final bankAccount = bankAccounts[index % bankAccounts.length];
                                    final bank =
                                        banks.isNotEmpty ? BankEntity.getBankByName(bankAccount.bankName, banks) : null;
                                    final imageAsset = bank?.cardImageUrl ??
                                        'https://finniu-statics.s3.amazonaws.com/finniu/images/bank/1db5fde8/agora.png';
                                    return CreditCardWidget(
                                      bankAccount: bankAccount,
                                      imageAsset: imageAsset,
                                      onTap: () async {
                                        if (!showDetail) {
                                          if (banks.isNotEmpty) {
                                            final selectedBank = BankEntity.getBankByName(bankAccount.bankName, banks);
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
                            SizedBox(height: 20),
                            SizedBox(
                              width: 299,
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  showAccountTransferModal(context, widget.currency);
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
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text('Failed to load banks')),
              );
            },
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Failed to load bank accounts')),
          ),
        );
      },
    );
  }
}
