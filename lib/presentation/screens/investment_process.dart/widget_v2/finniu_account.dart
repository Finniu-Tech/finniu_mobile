import 'package:finniu/presentation/providers/finniu_account_provider.dart';
import 'package:finniu/presentation/providers/money_provider.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/catalog/circular_loader.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FinniuAccountProvider extends ConsumerWidget {
  const FinniuAccountProvider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final finniuAccount = ref.watch(finniuAccountProvider);
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    final isSoles = ref.watch(isSolesStateProvider);
    const int containerDark = 0xff0D3A5C;
    const int containerLight = 0xffFFEEDD;

    return finniuAccount.when(
      data: (data) {
        return FinniuAccount(
          accountCci: data.accountCci,
          bankName: data.bankName,
          accountNumber: data.accountNumber,
          bankUrl: data.bankUrl ?? "",
        );
      },
      error: (error, stackTrace) {
        if (isSoles) {
          final data = finniuAccountSolesDefault;
          return FinniuAccount(
            accountCci: data.accountCci,
            bankName: data.bankName,
            accountNumber: data.accountNumber,
            bankUrl: data.bankUrl ?? "",
          );
        } else {
          final data = finniuAccountDolarsDefault;
          return FinniuAccount(
            accountCci: data.accountCci,
            bankName: data.bankName,
            accountNumber: data.accountNumber,
            bankUrl: data.bankUrl ?? "",
          );
        }
      },
      loading: () {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(containerDark)
                : const Color(containerLight),
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
            ),
          ),
          child: const Center(child: CircularLoader(width: 50, height: 50)),
        );
      },
    );
  }
}

class FinniuAccount extends ConsumerWidget {
  const FinniuAccount({
    super.key,
    required this.bankName,
    required this.accountNumber,
    required this.accountCci,
    required this.bankUrl,
  });
  final String bankName;
  final String accountNumber;
  final String accountCci;
  final String bankUrl;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;

    const int containerDark = 0xff0D3A5C;
    const int containerLight = 0xffFFEEDD;
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(containerDark)
            : const Color(containerLight),
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const TextPoppins(
            text: "Finniu S.A.C",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            textDark: titleDark,
            textLight: titleLight,
          ),
          const SizedBox(
            height: 5,
          ),
          const Row(
            children: [
              TextPoppins(
                text: "RUC",
                fontSize: 12,
              ),
              SizedBox(
                width: 5,
              ),
              TextPoppins(
                text: "20609327210",
                fontSize: 12,
                fontWeight: FontWeight.w600,
                textDark: titleDark,
                textLight: titleLight,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          FinniuTranferContainer(
            bank: "Nº cuenta $bankName",
            bankNumber: accountNumber,
            bankUrl: bankUrl,
          ),
          const SizedBox(
            height: 5,
          ),
          FinniuTranferContainer(
            bank: "CCI    ",
            bankNumber: accountCci,
            bankUrl: bankUrl,
          ),
        ],
      ),
    );
  }
}

class FinniuTranferContainer extends HookConsumerWidget {
  const FinniuTranferContainer({
    super.key,
    required this.bank,
    required this.bankNumber,
    required this.bankUrl,
  });
  final String bank;
  final String bankNumber;
  final String bankUrl;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    const int iconDark = 0xffFFFFFF;
    const int iconLight = 0xff0D3A5C;
    const int titleDark = 0xffA2E6FA;
    const int titleLight = 0xff0D3A5C;
    const int snackDark = 0xff000000;
    const int snackLight = 0xffFFFFFF;
    const int errorDark = 0xff181818;
    const int errorLight = 0xffA2E6FA;

    void copyToClipboard() {
      Clipboard.setData(ClipboardData(text: bankNumber));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor:
              isDarkMode ? const Color(titleDark) : const Color(titleLight),
          duration: const Duration(seconds: 1),
          content: TextPoppins(
            text: 'Número de cuenta $bank copiado al portapapeles',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            textDark: snackDark,
            textLight: snackLight,
            lines: 2,
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.network(
                bankUrl,
                width: 20,
                height: 20,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const CircularLoader(width: 10, height: 10);
                  }
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color(errorDark)
                        : const Color(errorLight),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/bank_case_error.png",
                      width: 15,
                      height: 15,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Row(
              children: [
                TextPoppins(
                  text: bank,
                  fontSize: 12,
                ),
                const SizedBox(
                  width: 5,
                ),
                TextPoppins(
                  text: bankNumber,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  textDark: titleDark,
                  textLight: titleLight,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
          width: 20,
          height: 20,
          child: GestureDetector(
            onTap: () => copyToClipboard(),
            child: SvgPicture.asset(
              "assets/svg_icons/copy_icon.svg",
              width: 20,
              height: 20,
              color:
                  isDarkMode ? const Color(iconDark) : const Color(iconLight),
            ),
          ),
        ),
      ],
    );
  }
}
