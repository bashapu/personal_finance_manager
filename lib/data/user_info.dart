enum TranscationType {
  outflow,
  inflow
}

enum ItemCategoryType {
  fashion,
  grocery,
  payment,
  rent,
  food,
  entertainment
}

class UserInfo {
  final String name;
  final String totalBalance;
  final String inflow;
  final String outflow;
  final List<Transcation> transcations;

  const UserInfo({
    required this.name,
    required this.totalBalance,
    required this.inflow,
    required this.outflow,
    required this.transcations
  });
}

class Transcation {
  final ItemCategoryType categoryType;
  final TranscationType transcationType;
  final String itemCategoryName;
  final String itemName;
  final String amount;
  final String date;

  const Transcation({
    required this.categoryType,
    required this.transcationType,
    required this.itemCategoryName,
    required this.itemName,
    required this.amount,
    required this.date,
  });
}

const List<Transcation> transactions1 = [
  Transcation(
    categoryType: ItemCategoryType.fashion,
    transcationType: TranscationType.outflow,
    itemCategoryName: "Shoes",
    itemName: "Puma Sneaker",
    amount: "\$3,500.00",
    date: "Mar 23, 2025"
  ),
  Transcation(
    categoryType: ItemCategoryType.fashion,
    transcationType: TranscationType.outflow,
    itemCategoryName: "Bag",
    itemName: "Gucci Flax",
    amount: "\$10,500.00",
    date: "Feb 24, 2025"
  )
];

const List<Transcation> transactions2 = [
  Transcation(
    categoryType: ItemCategoryType.payment,
    transcationType: TranscationType.inflow,
    itemCategoryName: "Transfer from Nikhil",
    itemName: "Puma Sneaker",
    amount: "\$13,600.00",
    date: "Mar 2, 2025"
  ),
  Transcation(
    categoryType: ItemCategoryType.grocery,
    transcationType: TranscationType.outflow,
    itemCategoryName: "Food",
    itemName: "Chicken Wings",
    amount: "\$10.00",
    date: "Feb 13, 2025"
  )
];

const userdata = UserInfo(
  name: "Jacob",
  totalBalance: "\$4,580.00",
  inflow: "\$4,000.00",
  outflow: "\$2,000.00",
  transcations: transactions1
);