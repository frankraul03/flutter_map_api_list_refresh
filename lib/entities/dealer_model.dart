class DealerInfo {
  String location;
  String dealerName;

  String dealerAddress;

  String dealerContact;

  String dealerDesc;

  String dealerLongLat;
  
  DealerInfo(this.location, this.dealerName,this.dealerAddress,this.dealerContact,this.dealerDesc,this.dealerLongLat);

  DealerInfo.fromJson(Map<String, dynamic> json) {
    location = json['Name'];
    dealerName = json['Dist'];
    dealerAddress = json['DistAddress'];
    dealerContact = json['DistContact'];
    dealerDesc = json['Desc'];
    dealerLongLat = json['LongLat'];
  }
}