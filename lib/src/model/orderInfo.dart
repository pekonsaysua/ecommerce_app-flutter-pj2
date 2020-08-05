class OrderInfo {
  String id;

  OrderInfo(
      {this.id,
      this.subId,
      this.customerName,
      this.receiverName,
      this.address,
      this.phone,
      this.total,
      this.status,
      this.createAt,
      this.shipping});

  String customerName;
  String receiverName;
  String phone;
  String address;
  String total;
  String status;
  String createAt;
  String subId;
  String shipping;
}
