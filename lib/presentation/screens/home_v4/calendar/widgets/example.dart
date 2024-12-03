final List<FundItemCalendar> exampleFundItemCalendars = [
  FundItemCalendar(
    color: ItemColor(
      backgroundDark: 0xFF08273F,
      backgroundLight: 0xFFE6F9FF,
      title: "Fondo inversión empresariales",
      icon: "🏢",
    ),
    number: "001",
    voucherUrl: "https://example.com/voucher001",
    date: "2024-12-01",
    rent: "120.20",
  ),
  FundItemCalendar(
    color: ItemColor(
      backgroundDark: 0xFF08273F,
      backgroundLight: 0xFFF7F7F7,
      title: "Fondo inversión hipotecaria",
      icon: "🏡",
    ),
    number: "002",
    voucherUrl: "",
    date: "2024-12-02",
    rent: "120.20",
  ),
  FundItemCalendar(
    color: ItemColor(
      backgroundDark: 0xFF08273F,
      backgroundLight: 0xFFE6F9FF,
      title: "Fondo inversión empresariales",
      icon: "🏢",
    ),
    number: "003",
    voucherUrl: "https://example.com/voucher001",
    date: "2024-12-01",
    rent: "120.20",
  ),
  FundItemCalendar(
    color: ItemColor(
      backgroundDark: 0xFF08273F,
      backgroundLight: 0xFFF7F7F7,
      title: "Fondo inversión hipotecaria",
      icon: "🏡",
    ),
    number: "004",
    voucherUrl: "https://example.com/voucher001",
    date: "2024-12-02",
    rent: "120.20",
  ),
];

class ItemColor {
  final int backgroundDark;
  final int backgroundLight;
  final String title;
  final String icon;

  ItemColor({
    required this.backgroundDark,
    required this.backgroundLight,
    required this.title,
    required this.icon,
  });
}

class FundItemCalendar {
  final ItemColor color;
  final String number;
  final String voucherUrl;
  final String date;
  final String rent;

  FundItemCalendar({
    required this.color,
    required this.number,
    required this.voucherUrl,
    required this.date,
    required this.rent,
  });
}
