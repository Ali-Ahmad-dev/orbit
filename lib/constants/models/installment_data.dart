/// installmentNumber : 1
/// "StartDate": "2024-08-01", : ""
/// dueDate : "2024-08-30"
/// amountDue : 500
/// amountPaid : 500
/// status : "Pending/Paid/Expired"
/// penaltyAmount : "50/ In case of Expired"
/// paymentDate : null
/// remainingBalance : 4500.00

class InstallmentData {
  InstallmentData({
      num? installmentNumber, 
      String? StartDate20240801, 
      String? dueDate, 
      num? amountDue, 
      num? amountPaid, 
      String? status, 
      String? penaltyAmount, 
      dynamic paymentDate, 
      num? remainingBalance,}){
    _installmentNumber = installmentNumber;
    _StartDate20240801 = StartDate20240801;
    _dueDate = dueDate;
    _amountDue = amountDue;
    _amountPaid = amountPaid;
    _status = status;
    _penaltyAmount = penaltyAmount;
    _paymentDate = paymentDate;
    _remainingBalance = remainingBalance;
}

  InstallmentData.fromJson(dynamic json) {
    _installmentNumber = json['installmentNumber'];
    _StartDate20240801 = json['"StartDate": "2024-08-01",'];
    _dueDate = json['dueDate'];
    _amountDue = json['amountDue'];
    _amountPaid = json['amountPaid'];
    _status = json['status'];
    _penaltyAmount = json['penaltyAmount'];
    _paymentDate = json['paymentDate'];
    _remainingBalance = json['remainingBalance'];
  }
  num? _installmentNumber;
  String? _StartDate20240801;
  String? _dueDate;
  num? _amountDue;
  num? _amountPaid;
  String? _status;
  String? _penaltyAmount;
  dynamic _paymentDate;
  num? _remainingBalance;
InstallmentData copyWith({  num? installmentNumber,
  String? StartDate20240801,
  String? dueDate,
  num? amountDue,
  num? amountPaid,
  String? status,
  String? penaltyAmount,
  dynamic paymentDate,
  num? remainingBalance,
}) => InstallmentData(  installmentNumber: installmentNumber ?? _installmentNumber,
  StartDate20240801: StartDate20240801 ?? _StartDate20240801,
  dueDate: dueDate ?? _dueDate,
  amountDue: amountDue ?? _amountDue,
  amountPaid: amountPaid ?? _amountPaid,
  status: status ?? _status,
  penaltyAmount: penaltyAmount ?? _penaltyAmount,
  paymentDate: paymentDate ?? _paymentDate,
  remainingBalance: remainingBalance ?? _remainingBalance,
);
  num? get installmentNumber => _installmentNumber;
  String? get StartDate20240801 => _StartDate20240801;
  String? get dueDate => _dueDate;
  num? get amountDue => _amountDue;
  num? get amountPaid => _amountPaid;
  String? get status => _status;
  String? get penaltyAmount => _penaltyAmount;
  dynamic get paymentDate => _paymentDate;
  num? get remainingBalance => _remainingBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['installmentNumber'] = _installmentNumber;
    map['"StartDate": "2024-08-01",'] = _StartDate20240801;
    map['dueDate'] = _dueDate;
    map['amountDue'] = _amountDue;
    map['amountPaid'] = _amountPaid;
    map['status'] = _status;
    map['penaltyAmount'] = _penaltyAmount;
    map['paymentDate'] = _paymentDate;
    map['remainingBalance'] = _remainingBalance;
    return map;
  }

}