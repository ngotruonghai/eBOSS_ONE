class DiaDiemCongTacModel {
  int Id;
  String KhuVuc;
  String LoaiCongtac;
  String DienGiai;
  String ChipPhiPhatSinh;
  String LyDoPhatSinh;
  String GhiChu;
  String TenKhuVuc;
  String TenLoaiCongTac;

  DiaDiemCongTacModel({
    required this.Id,
    required this.KhuVuc,
    required this.LoaiCongtac,
    required this.DienGiai,
    required this.ChipPhiPhatSinh,
    required this.LyDoPhatSinh,
    required this.GhiChu,
    required this.TenKhuVuc,
    required this.TenLoaiCongTac,
  });

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'KhuVuc': KhuVuc,
      'LoaiCongtac': LoaiCongtac,
      'DienGiai': DienGiai,
      'ChipPhiPhatSinh': ChipPhiPhatSinh,
      'LyDoPhatSinh': LyDoPhatSinh,
      'GhiChu': GhiChu,
    };
  }
}
