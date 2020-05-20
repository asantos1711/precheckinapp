final Map<String,String> clavePlan = {
  'AI' : 'ALL INCLUSIVE',
  'EP' : 'EUROPEAN PLAN',
};

String getClavePlan(String hotel, Map<String, String> plan) {
  if(hotel.isEmpty || hotel == null || plan == null)
    return '';

  String clave = plan[hotel];

  return clavePlan[clave] ?? clave;
}