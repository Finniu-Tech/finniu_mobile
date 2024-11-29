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
    final currentIndex = useState(0);
    useEffect(
      () {
        void listener() {
          currentIndex.value = tabController.index;
        }

        tabController.addListener(listener);
        return () => tabController.removeListener(listener);
      },
      [tabController],
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            labelPadding: const EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.zero,
            dividerColor: Colors.transparent,
            indicatorColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            tabs: [
              ButtonHistory(
                isSelected: currentIndex.value == 0,
                text: 'Contratos',
              ),
              ButtonHistory(
                isSelected: currentIndex.value == 1,
                text: 'Impuestos',
              ),
              ButtonHistory(
                isSelected: currentIndex.value == 2,
                text: 'Reportes',
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
                  itemBuilder: (context, index) => DocumentItem(
                    item: Document(
                      title: 'Contrato 1',
                      date: '01/01/2023',
                      downloadUrl: 'https://example.com/contract1.pdf',
                      type: DocumentType.contrato,
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => DocumentItem(
                    item: Document(
                      title: 'Contrato 1',
                      date: '01/01/2023',
                      downloadUrl: 'https://example.com/contract1.pdf',
                      type: DocumentType.impuesto,
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => DocumentItem(
                    item: Document(
                      title: 'Contrato 1',
                      date: '01/01/2023',
                      downloadUrl: 'https://example.com/contract1.pdf',
                      type: DocumentType.reporte,
                    ),
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

enum DocumentType { contrato, impuesto, reporte }

class Document {
  final String title;
  final String date;
  final String downloadUrl;
  final DocumentType type;

  Document({
    required this.title,
    required this.date,
    required this.downloadUrl,
    required this.type,
  });

  get getIcon {
    switch (type) {
      case DocumentType.contrato:
        return Icons.edit_document;
      case DocumentType.impuesto:
        return Icons.percent;
      case DocumentType.reporte:
        return Icons.bar_chart;
    }
  }
}

class DocumentItem extends ConsumerWidget {
  const DocumentItem({
    super.key,
    required this.item,
  });
  final Document item;
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
            item.getIcon,
            size: 24,
            color: isDarkMode
                ? const Color(DocumentsV4.itemIconDark)
                : const Color(DocumentsV4.itemIconLight),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextPoppins(
                text: "Operación ${item.title}",
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textDark: DocumentsV4.itemTitleDark,
                textLight: DocumentsV4.itemTitleLight,
              ),
              TextPoppins(
                text: item.date,
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
