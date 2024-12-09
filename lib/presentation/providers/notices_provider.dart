import 'package:finniu/domain/entities/notice_entity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final noticesProvider = FutureProvider.autoDispose<List<Notice>>((ref) async {
  try {
    await Future.delayed(const Duration(seconds: 2));
    final List<Notice> notices = [
      Notice(
        title: "¿Que es la gestión financiera?",
        description:
            "Lorem ipsum dolor sit amet consectetur. Posuere rutrum quisque senectus et duis et varius. Duis egestas vestibulum egestas inte....",
        date: "28/Nov/2024",
        linkUrl:
            "https://www.ambito.com/negocios/el-futuro-del-delivery-ia-ultravelocidad-y-expansion-los-pilares-rappi-2025-n6088573",
        linkImage: "",
      ),
      Notice(
        title: "¿Como ahorrar con mi primer sueldo?",
        description:
            "Lorem ipsum dolor sit amet consectetur. Posuere rutrum quisque senectus et duis et varius. Duis egestas vestibulum egestas inte....",
        date: "18/Nov/2024",
        linkUrl:
            "https://www.ambito.com/negocios/el-futuro-del-delivery-ia-ultravelocidad-y-expansion-los-pilares-rappi-2025-n6088573",
        linkImage: "",
      ),
      Notice(
        title: "¿Por donde comenzar a invertir?",
        description:
            "Lorem ipsum dolor sit amet consectetur. Posuere rutrum quisque senectus et duis et varius. Duis egestas vestibulum egestas inte....",
        date: "12/Nov/2024",
        linkUrl:
            "https://www.ambito.com/negocios/el-futuro-del-delivery-ia-ultravelocidad-y-expansion-los-pilares-rappi-2025-n6088573",
        linkImage: "",
      ),
    ];
    return notices;
  } catch (e) {}
  return [];
});
