import 'package:finniu/constants/colors/my_invest_v4_colors.dart';
import 'package:finniu/presentation/providers/settings_provider.dart';
import 'package:finniu/presentation/screens/business_investments/widgets/tab_bar_business.dart';
import 'package:finniu/presentation/screens/catalog/widgets/text_poppins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DocumenteBody extends ConsumerWidget {
  const DocumenteBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      color: isDarkMode
          ? const Color(DocumentsV4.backgroundDark)
          : const Color(DocumentsV4.backgroundLight),
      child: const Column(
        children: [
          TitleDocuments(),
          TabBarDocuments(),
        ],
      ),
    );
  }
}

class TitleDocuments extends ConsumerWidget {
  const TitleDocuments({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.edit_document,
                    color: isDarkMode
                        ? const Color(DocumentsV4.goDocumentDark)
                        : const Color(DocumentsV4.goDocumentLight),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const TextPoppins(
                    text: "Documentación",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    textDark: DocumentsV4.goDocumentDark,
                    textLight: DocumentsV4.goDocumentLight,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: isDarkMode
                  ? const Color(DocumentsV4.dividerDark)
                  : const Color(DocumentsV4.dividerLight),
              height: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class TabBarDocuments extends HookConsumerWidget {
  const TabBarDocuments({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(
      initialLength: 3,
      initialIndex: 0,
    );

    return Column(
      children: [
        TabBar(
          controller: tabController,
          labelPadding: const EdgeInsets.symmetric(horizontal: 5),
          padding: EdgeInsets.zero,
          isScrollable: true,
          tabs: [
            ButtonHistory(
              isSelected: tabController.index == 0,
              text: 'Por validar',
            ),
            ButtonHistory(
              isSelected: tabController.index == 1,
              text: 'En curso',
            ),
            ButtonHistory(
              isSelected: tabController.index == 2,
              text: 'Pendientes',
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.65,
          alignment: Alignment.topCenter,
          child: TabBarView(
            controller: tabController,
            children: [
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => const DocumentItem(),
              ),
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => const DocumentItem(),
              ),
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => const DocumentItem(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DocumentItem extends ConsumerWidget {
  const DocumentItem({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(settingsNotifierProvider).isDarkMode;
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 70,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isDarkMode
            ? const Color(DocumentsV4.itemBankDark)
            : const Color(DocumentsV4.itemBankLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.edit_document,
            size: 24,
            color: isDarkMode
                ? const Color(DocumentsV4.itemIconDark)
                : const Color(DocumentsV4.itemIconLight),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextPoppins(
                text: "Operación #001345",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textDark: DocumentsV4.itemTitleDark,
                textLight: DocumentsV4.itemTitleLight,
              ),
              TextPoppins(
                text: "12/05/2024",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textDark: DocumentsV4.itemDateDark,
                textLight: DocumentsV4.itemDateLight,
              ),
            ],
          ),
          const Spacer(),
          Center(
            child: Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDarkMode
                    ? const Color(DocumentsV4.itemButtonDark)
                    : const Color(DocumentsV4.itemButtonLight),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Icon(
                  Icons.file_download_outlined,
                  size: 26,
                  color: isDarkMode
                      ? const Color(DocumentsV4.itemIconDark)
                      : const Color(DocumentsV4.itemIconLight),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
