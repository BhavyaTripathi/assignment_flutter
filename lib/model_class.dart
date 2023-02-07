class Address {
   String country = '';
   String stateName = '';
   String cityName = '';
   String address = '';

  Address({required this.country, required this.stateName, required this.cityName, required this.address});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['response']['viewdetaildata'][0]['country'],
      stateName: json['response']['viewdetaildata'][0]['statename'],
      cityName: json['response']['viewdetaildata'][0]['cityname'],
      address: json['response']['viewdetaildata'][0]['address'],
    );
  }
}