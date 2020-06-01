class Politicas{

  String claveidioma;
  String seg_obj_dej;
  String seg_acu_est;
  String seg_san_amb;
  String seg_acu_prom;
  String seg_avi_priv;
  String seg_acu_reg;

  Politicas({
    this.claveidioma,
    this.seg_obj_dej,
    this.seg_acu_est,
    this.seg_san_amb,
    this.seg_acu_prom,
    this.seg_avi_priv,
    this.seg_acu_reg,
  });


  factory Politicas.fromJson(Map<String,dynamic> json) => Politicas(
    seg_obj_dej  : json['seg_obj_dej'] ?? '',
    seg_acu_est  : json['seg_acu_est'] ?? '',
    seg_san_amb  : json['seg_san_amb'] ?? '',
    seg_acu_prom : json['seg_acu_prom'] ?? '',
    seg_avi_priv : json['seg_avi_priv'] ?? '',
    seg_acu_reg  : json['seg_acu_reg'] ?? '',
  );
}