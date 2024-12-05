/// isError : false
/// message : {"loanHistoryDtos":[{"id":1099,"appliedOn":"2024-08-15T18:52:32.4691113","isApproved":true,"noofinstallments":4,"noofinstallmentsByHr":3,"comments":"","loanDescription":"","totalLoanAmount":20000.00,"isRejected":false,"deductionType":"Loan Instalment","paymentReceivedByEmployeeDate":"2024-09-04T00:00:00","closingDate":"2025-01-04T00:00:00"}],"loanPaymentHistories":[]}
/// currentLoanStats : {"totalLoanAmount":20000.00,"totalInstallments":4.0,"amountPayedBack":0.0,"thisMonthInstallment":"Not Paid"}

class LoanHistoryModel {
  LoanHistoryModel({
      bool? isError, 
      Message? message, 
      CurrentLoanStats? currentLoanStats,}){
    _isError = isError;
    _message = message;
    _currentLoanStats = currentLoanStats;
}

  LoanHistoryModel.fromJson(dynamic json) {
    _isError = json['isError'];
    _message = json['message'] != null ? Message.fromJson(json['message']) : null;
    _currentLoanStats = json['currentLoanStats'] != null ? CurrentLoanStats.fromJson(json['currentLoanStats']) : null;
  }
  bool? _isError;
  Message? _message;
  CurrentLoanStats? _currentLoanStats;
LoanHistoryModel copyWith({  bool? isError,
  Message? message,
  CurrentLoanStats? currentLoanStats,
}) => LoanHistoryModel(  isError: isError ?? _isError,
  message: message ?? _message,
  currentLoanStats: currentLoanStats ?? _currentLoanStats,
);
  bool? get isError => _isError;
  Message? get message => _message;
  CurrentLoanStats? get currentLoanStats => _currentLoanStats;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isError'] = _isError;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_currentLoanStats != null) {
      map['currentLoanStats'] = _currentLoanStats?.toJson();
    }
    return map;
  }

}

/// totalLoanAmount : 20000.00
/// totalInstallments : 4.0
/// amountPayedBack : 0.0
/// thisMonthInstallment : "Not Paid"

class CurrentLoanStats {
  CurrentLoanStats({
      num? totalLoanAmount, 
      num? totalInstallments, 
      num? amountPayedBack, 
      String? thisMonthInstallment,}){
    _totalLoanAmount = totalLoanAmount;
    _totalInstallments = totalInstallments;
    _amountPayedBack = amountPayedBack;
    _thisMonthInstallment = thisMonthInstallment;
}

  CurrentLoanStats.fromJson(dynamic json) {
    _totalLoanAmount = json['totalLoanAmount'];
    _totalInstallments = json['totalInstallments'];
    _amountPayedBack = json['amountPayedBack'];
    _thisMonthInstallment = json['thisMonthInstallment'];
  }
  num? _totalLoanAmount;
  num? _totalInstallments;
  num? _amountPayedBack;
  String? _thisMonthInstallment;
CurrentLoanStats copyWith({  num? totalLoanAmount,
  num? totalInstallments,
  num? amountPayedBack,
  String? thisMonthInstallment,
}) => CurrentLoanStats(  totalLoanAmount: totalLoanAmount ?? _totalLoanAmount,
  totalInstallments: totalInstallments ?? _totalInstallments,
  amountPayedBack: amountPayedBack ?? _amountPayedBack,
  thisMonthInstallment: thisMonthInstallment ?? _thisMonthInstallment,
);
  num? get totalLoanAmount => _totalLoanAmount;
  num? get totalInstallments => _totalInstallments;
  num? get amountPayedBack => _amountPayedBack;
  String? get thisMonthInstallment => _thisMonthInstallment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalLoanAmount'] = _totalLoanAmount;
    map['totalInstallments'] = _totalInstallments;
    map['amountPayedBack'] = _amountPayedBack;
    map['thisMonthInstallment'] = _thisMonthInstallment;
    return map;
  }

}

/// loanHistoryDtos : [{"id":1099,"appliedOn":"2024-08-15T18:52:32.4691113","isApproved":true,"noofinstallments":4,"noofinstallmentsByHr":3,"comments":"","loanDescription":"","totalLoanAmount":20000.00,"isRejected":false,"deductionType":"Loan Instalment","paymentReceivedByEmployeeDate":"2024-09-04T00:00:00","closingDate":"2025-01-04T00:00:00"}]
/// loanPaymentHistories : []

class Message {
  Message({
      List<LoanHistoryDtos>? loanHistoryDtos, 
      List<dynamic>? loanPaymentHistories,}){
    _loanHistoryDtos = loanHistoryDtos;
    _loanPaymentHistories = loanPaymentHistories;
}

  Message.fromJson(dynamic json) {
    if (json['loanHistoryDtos'] != null) {
      _loanHistoryDtos = [];
      json['loanHistoryDtos'].forEach((v) {
        _loanHistoryDtos?.add(LoanHistoryDtos.fromJson(v));
      });
    }
    if (json['loanPaymentHistories'] != null) {
      _loanPaymentHistories = [];
      json['loanPaymentHistories'].forEach((v) {
        _loanPaymentHistories?.add(v);
      });
    }
  }
  List<LoanHistoryDtos>? _loanHistoryDtos;
  List<dynamic>? _loanPaymentHistories;
Message copyWith({  List<LoanHistoryDtos>? loanHistoryDtos,
  List<dynamic>? loanPaymentHistories,
}) => Message(  loanHistoryDtos: loanHistoryDtos ?? _loanHistoryDtos,
  loanPaymentHistories: loanPaymentHistories ?? _loanPaymentHistories,
);
  List<LoanHistoryDtos>? get loanHistoryDtos => _loanHistoryDtos;
  List<dynamic>? get loanPaymentHistories => _loanPaymentHistories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_loanHistoryDtos != null) {
      map['loanHistoryDtos'] = _loanHistoryDtos?.map((v) => v.toJson()).toList();
    }
    if (_loanPaymentHistories != null) {
      map['loanPaymentHistories'] = _loanPaymentHistories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1099
/// appliedOn : "2024-08-15T18:52:32.4691113"
/// isApproved : true
/// noofinstallments : 4
/// noofinstallmentsByHr : 3
/// comments : ""
/// loanDescription : ""
/// totalLoanAmount : 20000.00
/// isRejected : false
/// deductionType : "Loan Instalment"
/// paymentReceivedByEmployeeDate : "2024-09-04T00:00:00"
/// closingDate : "2025-01-04T00:00:00"

class LoanHistoryDtos {
  LoanHistoryDtos({
      num? id, 
      String? appliedOn, 
      bool? isApproved, 
      num? noofinstallments, 
      num? noofinstallmentsByHr, 
      String? comments, 
      String? loanDescription, 
      num? totalLoanAmount, 
      bool? isRejected, 
      String? deductionType, 
      String? paymentReceivedByEmployeeDate, 
      String? closingDate,}){
    _id = id;
    _appliedOn = appliedOn;
    _isApproved = isApproved;
    _noofinstallments = noofinstallments;
    _noofinstallmentsByHr = noofinstallmentsByHr;
    _comments = comments;
    _loanDescription = loanDescription;
    _totalLoanAmount = totalLoanAmount;
    _isRejected = isRejected;
    _deductionType = deductionType;
    _paymentReceivedByEmployeeDate = paymentReceivedByEmployeeDate;
    _closingDate = closingDate;
}

  LoanHistoryDtos.fromJson(dynamic json) {
    _id = json['id'];
    _appliedOn = json['appliedOn'];
    _isApproved = json['isApproved'];
    _noofinstallments = json['noofinstallments'];
    _noofinstallmentsByHr = json['noofinstallmentsByHr'];
    _comments = json['comments'];
    _loanDescription = json['loanDescription'];
    _totalLoanAmount = json['totalLoanAmount'];
    _isRejected = json['isRejected'];
    _deductionType = json['deductionType'];
    _paymentReceivedByEmployeeDate = json['paymentReceivedByEmployeeDate'];
    _closingDate = json['closingDate'];
  }
  num? _id;
  String? _appliedOn;
  bool? _isApproved;
  num? _noofinstallments;
  num? _noofinstallmentsByHr;
  String? _comments;
  String? _loanDescription;
  num? _totalLoanAmount;
  bool? _isRejected;
  String? _deductionType;
  String? _paymentReceivedByEmployeeDate;
  String? _closingDate;
LoanHistoryDtos copyWith({  num? id,
  String? appliedOn,
  bool? isApproved,
  num? noofinstallments,
  num? noofinstallmentsByHr,
  String? comments,
  String? loanDescription,
  num? totalLoanAmount,
  bool? isRejected,
  String? deductionType,
  String? paymentReceivedByEmployeeDate,
  String? closingDate,
}) => LoanHistoryDtos(  id: id ?? _id,
  appliedOn: appliedOn ?? _appliedOn,
  isApproved: isApproved ?? _isApproved,
  noofinstallments: noofinstallments ?? _noofinstallments,
  noofinstallmentsByHr: noofinstallmentsByHr ?? _noofinstallmentsByHr,
  comments: comments ?? _comments,
  loanDescription: loanDescription ?? _loanDescription,
  totalLoanAmount: totalLoanAmount ?? _totalLoanAmount,
  isRejected: isRejected ?? _isRejected,
  deductionType: deductionType ?? _deductionType,
  paymentReceivedByEmployeeDate: paymentReceivedByEmployeeDate ?? _paymentReceivedByEmployeeDate,
  closingDate: closingDate ?? _closingDate,
);
  num? get id => _id;
  String? get appliedOn => _appliedOn;
  bool? get isApproved => _isApproved;
  num? get noofinstallments => _noofinstallments;
  num? get noofinstallmentsByHr => _noofinstallmentsByHr;
  String? get comments => _comments;
  String? get loanDescription => _loanDescription;
  num? get totalLoanAmount => _totalLoanAmount;
  bool? get isRejected => _isRejected;
  String? get deductionType => _deductionType;
  String? get paymentReceivedByEmployeeDate => _paymentReceivedByEmployeeDate;
  String? get closingDate => _closingDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['appliedOn'] = _appliedOn;
    map['isApproved'] = _isApproved;
    map['noofinstallments'] = _noofinstallments;
    map['noofinstallmentsByHr'] = _noofinstallmentsByHr;
    map['comments'] = _comments;
    map['loanDescription'] = _loanDescription;
    map['totalLoanAmount'] = _totalLoanAmount;
    map['isRejected'] = _isRejected;
    map['deductionType'] = _deductionType;
    map['paymentReceivedByEmployeeDate'] = _paymentReceivedByEmployeeDate;
    map['closingDate'] = _closingDate;
    return map;
  }

}