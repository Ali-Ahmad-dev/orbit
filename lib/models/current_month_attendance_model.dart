class CurrentMonthAttendanceModel {
  CurrentMonthAttendanceModel({
    List<CurrentMonthAttendence>? currentMonthAttendence,
    PreviousMonthHours? previousMonthHours,
    List<dynamic>? perviousMonthLeaves,
    UnApprovedLeaves? unApprovedLeaves,
    num? employeeId,
    bool? isError,
  }) {
    _currentMonthAttendence = currentMonthAttendence;
    _previousMonthHours = previousMonthHours;
    _perviousMonthLeaves = perviousMonthLeaves;
    _unApprovedLeaves = unApprovedLeaves;
    _employeeId = employeeId;
    _isError = isError;
  }

  CurrentMonthAttendanceModel.fromJson(dynamic json) {
    if (json['currentMonthAttendence'] != null) {
      _currentMonthAttendence = [];
      json['currentMonthAttendence'].forEach((v) {
        _currentMonthAttendence?.add(CurrentMonthAttendence.fromJson(v));
      });
    }
    _previousMonthHours = json['previousMonthHours'] != null
        ? PreviousMonthHours.fromJson(json['previousMonthHours'])
        : null;
    if (json['perviousMonthLeaves'] != null) {
      _perviousMonthLeaves = [];
      json['perviousMonthLeaves'].forEach((v) {
        _perviousMonthLeaves?.add({});
        // _perviousMonthLeaves?.add(Dynamic.fromJson(v));
      });
    }
    _unApprovedLeaves = json['unApprovedLeaves'] != null
        ? UnApprovedLeaves.fromJson(json['unApprovedLeaves'])
        : null;
    _employeeId = json['employeeId'];
    _isError = json['isError'];
  }
  List<CurrentMonthAttendence>? _currentMonthAttendence;
  PreviousMonthHours? _previousMonthHours;
  List<dynamic>? _perviousMonthLeaves;
  UnApprovedLeaves? _unApprovedLeaves;
  num? _employeeId;
  bool? _isError;
  CurrentMonthAttendanceModel copyWith({
    List<CurrentMonthAttendence>? currentMonthAttendence,
    PreviousMonthHours? previousMonthHours,
    List<dynamic>? perviousMonthLeaves,
    UnApprovedLeaves? unApprovedLeaves,
    num? employeeId,
    bool? isError,
  }) =>
      CurrentMonthAttendanceModel(
        currentMonthAttendence:
            currentMonthAttendence ?? _currentMonthAttendence,
        previousMonthHours: previousMonthHours ?? _previousMonthHours,
        perviousMonthLeaves: perviousMonthLeaves ?? _perviousMonthLeaves,
        unApprovedLeaves: unApprovedLeaves ?? _unApprovedLeaves,
        employeeId: employeeId ?? _employeeId,
        isError: isError ?? _isError,
      );
  List<CurrentMonthAttendence>? get currentMonthAttendence =>
      _currentMonthAttendence;
  PreviousMonthHours? get previousMonthHours => _previousMonthHours;
  List<dynamic>? get perviousMonthLeaves => _perviousMonthLeaves;
  UnApprovedLeaves? get unApprovedLeaves => _unApprovedLeaves;
  num? get employeeId => _employeeId;
  bool? get isError => _isError;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_currentMonthAttendence != null) {
      map['currentMonthAttendence'] =
          _currentMonthAttendence?.map((v) => v.toJson()).toList();
    }
    if (_previousMonthHours != null) {
      map['previousMonthHours'] = _previousMonthHours?.toJson();
    }
    if (_perviousMonthLeaves != null) {
      map['perviousMonthLeaves'] =
          _perviousMonthLeaves?.map((v) => v.toJson()).toList();
    }
    if (_unApprovedLeaves != null) {
      map['unApprovedLeaves'] = _unApprovedLeaves?.toJson();
    }
    map['employeeId'] = _employeeId;
    map['isError'] = _isError;
    return map;
  }
}

/// unApprovedLEavesDtos : [{"applY_FROM_DATE":"2024-07-28T00:00:00","applY_TO_DATE":"2024-07-29T00:00:00","employeE_COMMENTS":"bye","attachment":"http://localhost:44353//EmployeeLeaveRequest/05cf49a7-7c02-4e32-8a21-41ff9f13dfb8_09-Jul-2024_15-08-28_1000002015.jpg","leaveType":"Reserved","leaveTypeId":12,"id":1071,"firstHalf":false,"secondHalf":false,"startTime":"0","endTime":"0","createD_DATE_TIME":"2024-07-09T15:08:28.5206608","leaveCatName":"Reserved Leave"},{"applY_FROM_DATE":"2024-07-18T00:00:00","applY_TO_DATE":"2024-07-18T00:00:00","employeE_COMMENTS":"busy","attachment":"http://localhost:44353//EmployeeLeaveRequest/46f56262-1168-4cd9-9986-11f4a937d929_11-Jul-2024_14-48-28_1000143480.jpg","leaveType":"Half Day","leaveTypeId":14,"id":1073,"firstHalf":false,"secondHalf":false,"startTime":"0","endTime":"0","createD_DATE_TIME":"2024-07-11T14:48:29.908382","leaveCatName":"Half Day"},{"applY_FROM_DATE":"2024-07-22T00:00:00","applY_TO_DATE":"2024-07-23T00:00:00","employeE_COMMENTS":"busy","attachment":"http://localhost:44353//EmployeeLeaveRequest/6b4d219b-93db-454a-9bc9-1509c877322e_11-Jul-2024_14-48-55_1000143480.jpg","leaveType":"Half Day","leaveTypeId":14,"id":1074,"firstHalf":false,"secondHalf":false,"startTime":"0","endTime":"0","createD_DATE_TIME":"2024-07-11T14:48:55.1907641","leaveCatName":"Half Day"},{"applY_FROM_DATE":"2024-08-04T00:00:00","applY_TO_DATE":"2024-08-05T00:00:00","employeE_COMMENTS":"busy","attachment":"http://localhost:44353//EmployeeLeaveRequest/f48e070a-66da-4f1a-95f5-fb4dc73ac765_11-Jul-2024_14-51-00_1000143480.jpg","leaveType":"Half Day","leaveTypeId":14,"id":1075,"firstHalf":false,"secondHalf":false,"startTime":"0","endTime":"0","createD_DATE_TIME":"2024-07-11T14:51:00.0586838","leaveCatName":"Half Day"},{"applY_FROM_DATE":"2024-08-08T00:00:00","applY_TO_DATE":"2024-08-08T00:00:00","employeE_COMMENTS":"busy","attachment":"http://localhost:44353//EmployeeLeaveRequest/ab5b13f6-f762-4f1c-86c6-a344d61399a5_11-Jul-2024_14-51-21_1000143480.jpg","leaveType":"Half Day","leaveTypeId":14,"id":1076,"firstHalf":false,"secondHalf":false,"startTime":"0","endTime":"0","createD_DATE_TIME":"2024-07-11T14:51:21.2365117","leaveCatName":"Half Day"},{"applY_FROM_DATE":"2024-08-15T00:00:00","applY_TO_DATE":"2024-08-15T00:00:00","employeE_COMMENTS":"busy","attachment":"http://localhost:44353//EmployeeLeaveRequest/82abf758-a0a9-4ddb-a265-e0c44a36febc_11-Jul-2024_14-51-44_1000143480.jpg","leaveType":"Half Day","leaveTypeId":14,"id":1077,"firstHalf":false,"secondHalf":false,"startTime":"0","endTime":"0","createD_DATE_TIME":"2024-07-11T14:51:44.3643295","leaveCatName":"Half Day"},{"applY_FROM_DATE":"2024-07-17T00:00:00","applY_TO_DATE":"2024-07-17T00:00:00","employeE_COMMENTS":"test","attachment":"http://localhost:44353//EmployeeLeaveRequest/","leaveType":"CL","leaveTypeId":9,"id":1079,"firstHalf":false,"secondHalf":false,"startTime":"0","endTime":"0","createD_DATE_TIME":"2024-07-12T12:37:33.9327152","leaveCatName":"Casual Leave"}]
/// isSandWitchAllowed : false
/// offDayPolicyForThisEmployee : {"id":3,"description":"Friday&Saturday Off Day","displayName":"Friday&Saturday Off Day","code":"OD-0002","monday":false,"tuesday":false,"wednesday":false,"thursday":false,"friday":true,"saturday":true,"sunday":false,"companyId":1,"businessUnitId":null,"branchId":1,"companyName":"","company":null,"branch":null,"businessUnit":null,"empOffDayPolicy":null,"createdBy":1,"updatedBy":null,"createdDateTime":"2022-05-01T00:00:00","updatedDateTime":null,"isDeleted":false,"isActive":true}

class UnApprovedLeaves {
  UnApprovedLeaves({
    List<UnApprovedLEavesDtos>? unApprovedLEavesDtos,
    bool? isSandWitchAllowed,
    OffDayPolicyForThisEmployee? offDayPolicyForThisEmployee,
  }) {
    _unApprovedLEavesDtos = unApprovedLEavesDtos;
    _isSandWitchAllowed = isSandWitchAllowed;
    _offDayPolicyForThisEmployee = offDayPolicyForThisEmployee;
  }

  UnApprovedLeaves.fromJson(dynamic json) {
    if (json['unApprovedLEavesDtos'] != null) {
      _unApprovedLEavesDtos = [];
      json['unApprovedLEavesDtos'].forEach((v) {
        _unApprovedLEavesDtos?.add(UnApprovedLEavesDtos.fromJson(v));
      });
    }
    _isSandWitchAllowed = json['isSandWitchAllowed'];
    _offDayPolicyForThisEmployee = json['offDayPolicyForThisEmployee'] != null
        ? OffDayPolicyForThisEmployee.fromJson(
            json['offDayPolicyForThisEmployee'])
        : null;
  }
  List<UnApprovedLEavesDtos>? _unApprovedLEavesDtos;
  bool? _isSandWitchAllowed;
  OffDayPolicyForThisEmployee? _offDayPolicyForThisEmployee;
  UnApprovedLeaves copyWith({
    List<UnApprovedLEavesDtos>? unApprovedLEavesDtos,
    bool? isSandWitchAllowed,
    OffDayPolicyForThisEmployee? offDayPolicyForThisEmployee,
  }) =>
      UnApprovedLeaves(
        unApprovedLEavesDtos: unApprovedLEavesDtos ?? _unApprovedLEavesDtos,
        isSandWitchAllowed: isSandWitchAllowed ?? _isSandWitchAllowed,
        offDayPolicyForThisEmployee:
            offDayPolicyForThisEmployee ?? _offDayPolicyForThisEmployee,
      );
  List<UnApprovedLEavesDtos>? get unApprovedLEavesDtos => _unApprovedLEavesDtos;
  bool? get isSandWitchAllowed => _isSandWitchAllowed;
  OffDayPolicyForThisEmployee? get offDayPolicyForThisEmployee =>
      _offDayPolicyForThisEmployee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_unApprovedLEavesDtos != null) {
      map['unApprovedLEavesDtos'] =
          _unApprovedLEavesDtos?.map((v) => v.toJson()).toList();
    }
    map['isSandWitchAllowed'] = _isSandWitchAllowed;
    if (_offDayPolicyForThisEmployee != null) {
      map['offDayPolicyForThisEmployee'] =
          _offDayPolicyForThisEmployee?.toJson();
    }
    return map;
  }
}

/// id : 3
/// description : "Friday&Saturday Off Day"
/// displayName : "Friday&Saturday Off Day"
/// code : "OD-0002"
/// monday : false
/// tuesday : false
/// wednesday : false
/// thursday : false
/// friday : true
/// saturday : true
/// sunday : false
/// companyId : 1
/// businessUnitId : null
/// branchId : 1
/// companyName : ""
/// company : null
/// branch : null
/// businessUnit : null
/// empOffDayPolicy : null
/// createdBy : 1
/// updatedBy : null
/// createdDateTime : "2022-05-01T00:00:00"
/// updatedDateTime : null
/// isDeleted : false
/// isActive : true

class OffDayPolicyForThisEmployee {
  OffDayPolicyForThisEmployee({
    num? id,
    String? description,
    String? displayName,
    String? code,
    bool? monday,
    bool? tuesday,
    bool? wednesday,
    bool? thursday,
    bool? friday,
    bool? saturday,
    bool? sunday,
    num? companyId,
    dynamic businessUnitId,
    num? branchId,
    String? companyName,
    dynamic company,
    dynamic branch,
    dynamic businessUnit,
    dynamic empOffDayPolicy,
    num? createdBy,
    dynamic updatedBy,
    String? createdDateTime,
    dynamic updatedDateTime,
    bool? isDeleted,
    bool? isActive,
  }) {
    _id = id;
    _description = description;
    _displayName = displayName;
    _code = code;
    _monday = monday;
    _tuesday = tuesday;
    _wednesday = wednesday;
    _thursday = thursday;
    _friday = friday;
    _saturday = saturday;
    _sunday = sunday;
    _companyId = companyId;
    _businessUnitId = businessUnitId;
    _branchId = branchId;
    _companyName = companyName;
    _company = company;
    _branch = branch;
    _businessUnit = businessUnit;
    _empOffDayPolicy = empOffDayPolicy;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
    _createdDateTime = createdDateTime;
    _updatedDateTime = updatedDateTime;
    _isDeleted = isDeleted;
    _isActive = isActive;
  }

  OffDayPolicyForThisEmployee.fromJson(dynamic json) {
    _id = json['id'];
    _description = json['description'];
    _displayName = json['displayName'];
    _code = json['code'];
    _monday = json['monday'];
    _tuesday = json['tuesday'];
    _wednesday = json['wednesday'];
    _thursday = json['thursday'];
    _friday = json['friday'];
    _saturday = json['saturday'];
    _sunday = json['sunday'];
    _companyId = json['companyId'];
    _businessUnitId = json['businessUnitId'];
    _branchId = json['branchId'];
    _companyName = json['companyName'];
    _company = json['company'];
    _branch = json['branch'];
    _businessUnit = json['businessUnit'];
    _empOffDayPolicy = json['empOffDayPolicy'];
    _createdBy = json['createdBy'];
    _updatedBy = json['updatedBy'];
    _createdDateTime = json['createdDateTime'];
    _updatedDateTime = json['updatedDateTime'];
    _isDeleted = json['isDeleted'];
    _isActive = json['isActive'];
  }
  num? _id;
  String? _description;
  String? _displayName;
  String? _code;
  bool? _monday;
  bool? _tuesday;
  bool? _wednesday;
  bool? _thursday;
  bool? _friday;
  bool? _saturday;
  bool? _sunday;
  num? _companyId;
  dynamic _businessUnitId;
  num? _branchId;
  String? _companyName;
  dynamic _company;
  dynamic _branch;
  dynamic _businessUnit;
  dynamic _empOffDayPolicy;
  num? _createdBy;
  dynamic _updatedBy;
  String? _createdDateTime;
  dynamic _updatedDateTime;
  bool? _isDeleted;
  bool? _isActive;
  OffDayPolicyForThisEmployee copyWith({
    num? id,
    String? description,
    String? displayName,
    String? code,
    bool? monday,
    bool? tuesday,
    bool? wednesday,
    bool? thursday,
    bool? friday,
    bool? saturday,
    bool? sunday,
    num? companyId,
    dynamic businessUnitId,
    num? branchId,
    String? companyName,
    dynamic company,
    dynamic branch,
    dynamic businessUnit,
    dynamic empOffDayPolicy,
    num? createdBy,
    dynamic updatedBy,
    String? createdDateTime,
    dynamic updatedDateTime,
    bool? isDeleted,
    bool? isActive,
  }) =>
      OffDayPolicyForThisEmployee(
        id: id ?? _id,
        description: description ?? _description,
        displayName: displayName ?? _displayName,
        code: code ?? _code,
        monday: monday ?? _monday,
        tuesday: tuesday ?? _tuesday,
        wednesday: wednesday ?? _wednesday,
        thursday: thursday ?? _thursday,
        friday: friday ?? _friday,
        saturday: saturday ?? _saturday,
        sunday: sunday ?? _sunday,
        companyId: companyId ?? _companyId,
        businessUnitId: businessUnitId ?? _businessUnitId,
        branchId: branchId ?? _branchId,
        companyName: companyName ?? _companyName,
        company: company ?? _company,
        branch: branch ?? _branch,
        businessUnit: businessUnit ?? _businessUnit,
        empOffDayPolicy: empOffDayPolicy ?? _empOffDayPolicy,
        createdBy: createdBy ?? _createdBy,
        updatedBy: updatedBy ?? _updatedBy,
        createdDateTime: createdDateTime ?? _createdDateTime,
        updatedDateTime: updatedDateTime ?? _updatedDateTime,
        isDeleted: isDeleted ?? _isDeleted,
        isActive: isActive ?? _isActive,
      );
  num? get id => _id;
  String? get description => _description;
  String? get displayName => _displayName;
  String? get code => _code;
  bool? get monday => _monday;
  bool? get tuesday => _tuesday;
  bool? get wednesday => _wednesday;
  bool? get thursday => _thursday;
  bool? get friday => _friday;
  bool? get saturday => _saturday;
  bool? get sunday => _sunday;
  num? get companyId => _companyId;
  dynamic get businessUnitId => _businessUnitId;
  num? get branchId => _branchId;
  String? get companyName => _companyName;
  dynamic get company => _company;
  dynamic get branch => _branch;
  dynamic get businessUnit => _businessUnit;
  dynamic get empOffDayPolicy => _empOffDayPolicy;
  num? get createdBy => _createdBy;
  dynamic get updatedBy => _updatedBy;
  String? get createdDateTime => _createdDateTime;
  dynamic get updatedDateTime => _updatedDateTime;
  bool? get isDeleted => _isDeleted;
  bool? get isActive => _isActive;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['description'] = _description;
    map['displayName'] = _displayName;
    map['code'] = _code;
    map['monday'] = _monday;
    map['tuesday'] = _tuesday;
    map['wednesday'] = _wednesday;
    map['thursday'] = _thursday;
    map['friday'] = _friday;
    map['saturday'] = _saturday;
    map['sunday'] = _sunday;
    map['companyId'] = _companyId;
    map['businessUnitId'] = _businessUnitId;
    map['branchId'] = _branchId;
    map['companyName'] = _companyName;
    map['company'] = _company;
    map['branch'] = _branch;
    map['businessUnit'] = _businessUnit;
    map['empOffDayPolicy'] = _empOffDayPolicy;
    map['createdBy'] = _createdBy;
    map['updatedBy'] = _updatedBy;
    map['createdDateTime'] = _createdDateTime;
    map['updatedDateTime'] = _updatedDateTime;
    map['isDeleted'] = _isDeleted;
    map['isActive'] = _isActive;
    return map;
  }
}

/// applY_FROM_DATE : "2024-07-28T00:00:00"
/// applY_TO_DATE : "2024-07-29T00:00:00"
/// employeE_COMMENTS : "bye"
/// attachment : "http://localhost:44353//EmployeeLeaveRequest/05cf49a7-7c02-4e32-8a21-41ff9f13dfb8_09-Jul-2024_15-08-28_1000002015.jpg"
/// leaveType : "Reserved"
/// leaveTypeId : 12
/// id : 1071
/// firstHalf : false
/// secondHalf : false
/// startTime : "0"
/// endTime : "0"
/// createD_DATE_TIME : "2024-07-09T15:08:28.5206608"
/// leaveCatName : "Reserved Leave"

class UnApprovedLEavesDtos {
  UnApprovedLEavesDtos({
    String? applYFROMDATE,
    String? applYTODATE,
    String? employeECOMMENTS,
    String? attachment,
    String? leaveType,
    num? leaveTypeId,
    num? id,
    bool? firstHalf,
    bool? secondHalf,
    String? startTime,
    String? endTime,
    String? createDDATETIME,
    String? leaveCatName,
  }) {
    _applYFROMDATE = applYFROMDATE;
    _applYTODATE = applYTODATE;
    _employeECOMMENTS = employeECOMMENTS;
    _attachment = attachment;
    _leaveType = leaveType;
    _leaveTypeId = leaveTypeId;
    _id = id;
    _firstHalf = firstHalf;
    _secondHalf = secondHalf;
    _startTime = startTime;
    _endTime = endTime;
    _createDDATETIME = createDDATETIME;
    _leaveCatName = leaveCatName;
  }

  UnApprovedLEavesDtos.fromJson(dynamic json) {
    _applYFROMDATE = json['applY_FROM_DATE'];
    _applYTODATE = json['applY_TO_DATE'];
    _employeECOMMENTS = json['employeE_COMMENTS'];
    _attachment = json['attachment'];
    _leaveType = json['leaveType'];
    _leaveTypeId = json['leaveTypeId'];
    _id = json['id'];
    _firstHalf = json['firstHalf'];
    _secondHalf = json['secondHalf'];
    _startTime = json['startTime'];
    _endTime = json['endTime'];
    _createDDATETIME = json['createD_DATE_TIME'];
    _leaveCatName = json['leaveCatName'];
  }
  String? _applYFROMDATE;
  String? _applYTODATE;
  String? _employeECOMMENTS;
  String? _attachment;
  String? _leaveType;
  num? _leaveTypeId;
  num? _id;
  bool? _firstHalf;
  bool? _secondHalf;
  String? _startTime;
  String? _endTime;
  String? _createDDATETIME;
  String? _leaveCatName;
  UnApprovedLEavesDtos copyWith({
    String? applYFROMDATE,
    String? applYTODATE,
    String? employeECOMMENTS,
    String? attachment,
    String? leaveType,
    num? leaveTypeId,
    num? id,
    bool? firstHalf,
    bool? secondHalf,
    String? startTime,
    String? endTime,
    String? createDDATETIME,
    String? leaveCatName,
  }) =>
      UnApprovedLEavesDtos(
        applYFROMDATE: applYFROMDATE ?? _applYFROMDATE,
        applYTODATE: applYTODATE ?? _applYTODATE,
        employeECOMMENTS: employeECOMMENTS ?? _employeECOMMENTS,
        attachment: attachment ?? _attachment,
        leaveType: leaveType ?? _leaveType,
        leaveTypeId: leaveTypeId ?? _leaveTypeId,
        id: id ?? _id,
        firstHalf: firstHalf ?? _firstHalf,
        secondHalf: secondHalf ?? _secondHalf,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        createDDATETIME: createDDATETIME ?? _createDDATETIME,
        leaveCatName: leaveCatName ?? _leaveCatName,
      );
  String? get applYFROMDATE => _applYFROMDATE;
  String? get applYTODATE => _applYTODATE;
  String? get employeECOMMENTS => _employeECOMMENTS;
  String? get attachment => _attachment;
  String? get leaveType => _leaveType;
  num? get leaveTypeId => _leaveTypeId;
  num? get id => _id;
  bool? get firstHalf => _firstHalf;
  bool? get secondHalf => _secondHalf;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get createDDATETIME => _createDDATETIME;
  String? get leaveCatName => _leaveCatName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['applY_FROM_DATE'] = _applYFROMDATE;
    map['applY_TO_DATE'] = _applYTODATE;
    map['employeE_COMMENTS'] = _employeECOMMENTS;
    map['attachment'] = _attachment;
    map['leaveType'] = _leaveType;
    map['leaveTypeId'] = _leaveTypeId;
    map['id'] = _id;
    map['firstHalf'] = _firstHalf;
    map['secondHalf'] = _secondHalf;
    map['startTime'] = _startTime;
    map['endTime'] = _endTime;
    map['createD_DATE_TIME'] = _createDDATETIME;
    map['leaveCatName'] = _leaveCatName;
    return map;
  }
}

/// totalHours : 45.0

class PreviousMonthHours {
  PreviousMonthHours({
    num? totalHours,
  }) {
    _totalHours = totalHours;
  }

  PreviousMonthHours.fromJson(dynamic json) {
    _totalHours = json['totalHours'];
  }
  num? _totalHours;
  PreviousMonthHours copyWith({
    num? totalHours,
  }) =>
      PreviousMonthHours(
        totalHours: totalHours ?? _totalHours,
      );
  num? get totalHours => _totalHours;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalHours'] = _totalHours;
    return map;
  }
}

/// date : "01 - July"
/// checkIn : "9:00AM"
/// checkOut : "6:00PM"
/// duration : "09:00"
/// noOfMinutes : 540

class CurrentMonthAttendence {
  CurrentMonthAttendence({
    String? date,
    String? checkIn,
    String? checkOut,
    String? duration,
    num? noOfMinutes,
  }) {
    _date = date;
    _checkIn = checkIn;
    _checkOut = checkOut;
    _duration = duration;
    _noOfMinutes = noOfMinutes;
  }

  CurrentMonthAttendence.fromJson(dynamic json) {
    _date = json['date'];
    _checkIn = json['checkIn'];
    _checkOut = json['checkOut'];
    _duration = json['duration'];
    _noOfMinutes = json['noOfMinutes'];
  }
  String? _date;
  String? _checkIn;
  String? _checkOut;
  String? _duration;
  num? _noOfMinutes;
  CurrentMonthAttendence copyWith({
    String? date,
    String? checkIn,
    String? checkOut,
    String? duration,
    num? noOfMinutes,
  }) =>
      CurrentMonthAttendence(
        date: date ?? _date,
        checkIn: checkIn ?? _checkIn,
        checkOut: checkOut ?? _checkOut,
        duration: duration ?? _duration,
        noOfMinutes: noOfMinutes ?? _noOfMinutes,
      );
  String? get date => _date;
  String? get checkIn => _checkIn;
  String? get checkOut => _checkOut;
  String? get duration => _duration;
  num? get noOfMinutes => _noOfMinutes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['checkIn'] = _checkIn;
    map['checkOut'] = _checkOut;
    map['duration'] = _duration;
    map['noOfMinutes'] = _noOfMinutes;
    return map;
  }
}
