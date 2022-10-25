class Account {
  String? avatar;
  String? name;
  int? numberOfPost;
  int? numberOfGold;
  int? numberOfSilver;
  int? numberOfBronze;

  Account(this.avatar, this.name, this.numberOfPost, this.numberOfGold,
      this.numberOfSilver, this.numberOfBronze);
}

List<Account> listAccount = [
  Account('https://cdn-icons-png.flaticon.com/512/1077/1077114.png?w=360',
      'Trong Huy', 1010, 100, 100, 100),
  Account('https://cdn-icons-png.flaticon.com/512/1077/1077114.png?w=360',
      'Nhat Tan', 2871, 100, 100, 100)
];
