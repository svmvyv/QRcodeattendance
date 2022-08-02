class device {
  final String devicename;
  final String id;
  final String rssi;
  final String txpower;
  device(this.devicename,
      this.id,
      this.rssi,
      this.txpower,);
   String getdvicename()
  {
    return this.devicename;
  }
  String getdviceid()
  {
    return this.id;
  }
  String getdvicerssi()
  {
    return this.rssi;
  }
  String getdvicetxpower()
  {
    return this.txpower;
  }
}