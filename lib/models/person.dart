class Person {
  final int? id;
  final String ad;
  final int yas;
  final String sehir;
  const Person(
      {this.id, required this.ad, required this.yas, required this.sehir});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ad': ad,
      'yas': yas,
      'sehir': sehir,
    };
  }

  static Person fromMap(Map<String, dynamic> map) => Person(
        id: map['id'],
        ad: map['ad'],
        yas: map['yas'],
        sehir: map['sehir'],
      );

  @override
  String toString() {
    return '[$id] Adı: $ad, Yaşı: $yas, Şehir: $sehir';
  }
}
