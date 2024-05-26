class BottomMenuEnum {
  final home = MenuItem(label: 'Inicio', icon: 'assets/icons/home.png', route: '/home_home', index: 0);
  final plans = MenuItem(label: 'Planes', icon: 'assets/icons/square.png', route: '/plan_list', index: 1);
  final investments =
      MenuItem(label: 'Inversiones', icon: 'assets/icons/dollar.png', route: '/process_investment', index: 2);
}

class MenuItem {
  final String label;
  final String icon;
  final String route;
  final int index;

  MenuItem({
    required this.label,
    required this.icon,
    required this.route,
    required this.index,
  });

  factory MenuItem.fromMap(Map<String, dynamic> map) {
    return MenuItem(
      label: map['label'],
      icon: map['icon'],
      route: map['route'],
      index: map['index'],
    );
  }
}
