import 'package:flutter/material.dart';

class ChatModel {
  ChatModel({
    String? data,
    String? timeStamp,
    String? senderId,
    String? receiverId,
    String? contentType,
    Duration? duration
  }) {
    _data = data;
    _timeStamp = timeStamp;
    _senderId = senderId;
    _receiverId = receiverId;
    _contentType = contentType;
    _duration = duration;
  }
  ChatModel.fromJson(dynamic json) {
    _data = json['data'];
    _timeStamp = json['timeStamp'];
    _senderId = json['senderId'];
    _receiverId = json['receiverId'];
    _contentType = json['contentType'];
    _duration = json['duration'];
  }
  String? _data;
  String? _timeStamp;
  String? _senderId;
  String? _receiverId;
  String? _contentType;
  Duration? _duration;
  ChatModel copyWith({
    String? data,
    String? timeStamp,
    String? senderId,
    String? receiverId,
    String? contentType,
    Duration? duration,
  }) =>
      ChatModel(
        data: data ?? _data,
        timeStamp: timeStamp ?? _timeStamp,
        senderId: senderId ?? _senderId,
        receiverId: receiverId ?? _receiverId,
        contentType: contentType ?? _contentType,
        duration: duration ?? _duration,
      );
  String? get data => _data;
  String? get timeStamp => _timeStamp;
  String? get senderId => _senderId;
  String? get receiverId => _receiverId;
  String? get contentType => _contentType;
  Duration? get duration => _duration;
  set duration(value) => _duration = value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['data'] = _data;
    map['timeStamp'] = _timeStamp;
    map['senderId'] = _senderId;
    map['receiverId'] = _receiverId;
    map['contentType'] = _contentType;
    map['duration'] = _duration;
    return map;
  }
}
