import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:orbit/constants/chat_keys.dart';
import 'package:orbit/constants/models/chat_model.dart';
import 'package:orbit/constants/models/hr_chat_list_model.dart';
import 'package:orbit/constants/network/network_endpoints.dart';
import 'package:orbit/models/login_model.dart';
import 'package:orbit/repositories/message_repository.dart';
import 'package:orbit/utils/hr_path_provider.dart';
import 'package:orbit/utils/hr_toast.dart';
import 'package:orbit/utils/pagination_utils.dart';
import 'package:just_audio/just_audio.dart';
import '../constants/routes/routes_endpoints.dart';

class MessageController extends GetxController {
  final preferencesController = Get.find<LoginModel>();
  final MessageRepository _repository;
  MessageController(this._repository);

  final RecorderController recorderController =
      RecorderController(); // Initialise
  final PlayerController playerController = PlayerController();
  late PaginationUtil paginationUtil;
  final TextEditingController messageController = TextEditingController();
  // VoiceMessageController? voiceController;
  RxList<ChatModel> list = <ChatModel>[].obs;
  final RxString errorMessage = ''.obs;
  RxBool apiCalling = true.obs;
  RxBool recording = false.obs;
  RxBool playing = false.obs;
  File? selectedImages;

  final AudioPlayer _audioPlayer = AudioPlayer();

  RxInt currentDuration = 0.obs;
  var isMoreDataAvailable = true.obs;
  var offset = 0.obs;
  final limit = 20;
  Timer? _timer;
  int maxDuration = 30;

  var arguments;
  bool employeeIsHR = false;
  var progress = 0.0.obs;
  var currentIndex = 0.obs;
  HrChatListModel? chatListModel;

  @override
  void onInit() {
    arguments = Get.arguments;
    if (arguments != null) {
      employeeIsHR = arguments[ChatKeys.employeeIsHR];
      chatListModel = arguments[ChatKeys.employeeChatModel];
    }

    // voiceController = Get.put(VoiceMessageController(list));
    // list.value = chat_data.map((item) => ChatModel.fromJson(item)).toList();
    playerController.addListener(() {});
    paginationUtil = Get.put(PaginationUtil(
        fetchNextPage: getHrChats,
        nextPage: isMoreDataAvailable.value,
        loading: apiCalling.value,
        limit: limit,
        offset: offset));
    getHrChats();
    super.onInit();
  }

  Future<Duration?> _loadAudio(String url) async {
    print('_loadAudio => $url');
    var dur;
    try {
      dur = await _audioPlayer.setUrl(url);
      print('_loadAudio_duration => $dur');
    } catch (e) {
      print('_loadAudio_exception $e');
    }

    // Load the audio source
    return dur;
  }

  Future<void> downloadImage(String url) async {
    final name = url.split("/").last;

    progress.value = 0.0001;
    print('====1');
    final result = await HrPathProvider.downloadFile(
      url: url,
      fileName: name,
      progressCallback: (current, total) {
        progress.value = (current / total);
        print('Downloading: ${progress.value}');
      },
      onDone: () async {
        progress.value = 0.0;
        print('onDone');
        HrToast.showToast(
            msg: 'File Downloaded successfully.', backgroundColor: Colors.red);
      },
    );
    if (result == 200) {
      progress.value = 0.0;
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    recorderController.dispose();
    playerController.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }

    super.dispose();
  }

  Future<void> getHrChats() async {
    final loginController = Get.find<LoginModel>();
    // var id = !employeeIsHR
    //     ? loginController.employeeDetails!.employeeId
    //     : chatListModel!.employeeId;
    print('getHrChats => $employeeIsHR');
    var id = !employeeIsHR
        ? loginController.employeeDetails!.employeeId
        : chatListModel!.employeeId;

    var id2 = !employeeIsHR
        ? loginController.hrLeadDetails!.employeeId
        : loginController.employeeDetails!.employeeId;
    try {
      if (!isMoreDataAvailable.value) return;
      errorMessage.value = '';
      var data = {
        "senderId": !employeeIsHR
            ? loginController.employeeDetails!.employeeId
            : chatListModel!.employeeId,
        "receiverid": !employeeIsHR
            ? loginController.hrLeadDetails!.employeeId
            : loginController.employeeDetails!.employeeId,
        "offset": paginationUtil.offset!.value,
        "limit": paginationUtil.limit
      };
      print(data);
      final result =
          await _repository.getChats(NetworkEndpoints.getChats, data);

      final status = result['statusCode'];
      print(result);

      if (status == 200) {
        List<ChatModel>? chatUnit = [];
        (result['content'] as List).forEach((element) {
          if (element != null) {
            chatUnit.add(ChatModel.fromJson(element));
          }
        });
        await checkAudiosLength(chatUnit);

        if (chatUnit.isEmpty || chatUnit.length < paginationUtil.limit) {
          isMoreDataAvailable.value = false;
          paginationUtil.nextPage = isMoreDataAvailable.value;
          list.addAll(chatUnit);
        } else {
          list.addAll(chatUnit);
          paginationUtil.offset!.value =
              paginationUtil.offset!.value + paginationUtil.limit;
          paginationUtil.nextPage = true;
        }
      } else {
        errorMessage.value = result['message'] ?? 'Unknown error occurred';
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch leave history: $e';
      print(e);
    } finally {
      apiCalling.value = false;
      paginationUtil.loading = apiCalling.value;
    }
  }

  Future<void> addMsg() async {
    try {
      errorMessage.value = '';
      var data = {
        "timeStamp": DateTime.now().toIso8601String(),
        "senderId": preferencesController.employeeDetails!.employeeId,
        "receiverId": preferencesController.hrLeadDetails!.employeeId,
        // !employeeIsHR
        //     ? preferencesController.hrLeadDetails!.employeeId
        //     : chatListModel!.employeeId,
        "contentType": "text",
        "messages": {"text": messageController.text.trim()},
      };
// !employeeIsHR
//             ? preferencesController.hrLeadDetails!.employeeId
//             : chatListModel!.employeeId,
      print(data);
      var result =
          await _repository.createChats(NetworkEndpoints.createChats, data);
      print('addMsg => $result');
      messageController.clear();
    } catch (e) {
      errorMessage.value = 'Failed to apply leave: $e';
    } finally {
      apiCalling.value = false;
    }
  }

  Future<void> addPicture(File? selected) async {
    List<int> imageBytes = await selected!.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    try {
      errorMessage.value = '';
      var data = {
        "timeStamp": DateTime.now().toIso8601String(),
        "senderId": preferencesController.employeeDetails!.employeeId,
        "receiverId": !employeeIsHR
            ? preferencesController.hrLeadDetails!.employeeId
            : chatListModel!.employeeId,
        "contentType": "file",
        "messages": {},
        "file": {
          "fileName": selected.path.split('/').last,
          "fileContent": base64Image
        }
      };
      print('addPicture => $data');
      var result =
          await _repository.createChats(NetworkEndpoints.createChats, data);
      print('addPicture => $result');
    } catch (e) {
      errorMessage.value = 'Failed to apply leave: $e';
    } finally {
      apiCalling.value = false;
    }
  }

  Future<void> addVoiceRecord(File? selected) async {
    List<int> imageBytes = await selected!.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    try {
      errorMessage.value = '';

      var data = {
        "timeStamp": DateTime.now().toIso8601String(),
        "senderId": preferencesController.employeeDetails!.employeeId,
        "receiverId": !employeeIsHR
            ? preferencesController.hrLeadDetails!.employeeId
            : chatListModel!.employeeId,
        "contentType": "audio",
        "messages": {},
        "file": {
          "fileName": selected.path.split('/').last,
          "fileContent": base64Image
        }
      };
      print('addPicture => $data');
      var result =
          await _repository.createChats(NetworkEndpoints.createChats, data);
      print('addVoiceRecord => $result');
    } catch (e) {
      errorMessage.value = 'Failed to apply leave: $e';
    } finally {
      apiCalling.value = false;
    }
  }

  goToImageScreen() async {
    final result = await Get.toNamed(RouteEndpoints.imageScreen);
    if (result != null) {
      var data = {
        "data": result,
        "timeStamp": DateTime.now().toIso8601String(),
        "senderId":
            preferencesController.employeeDetails!.employeeId.toString(),
        "receiverId": !employeeIsHR
            ? preferencesController.hrLeadDetails!.employeeId.toString()
            : chatListModel!.employeeId.toString(),
        "contentType": "file"
      };
      list.insert(0, ChatModel.fromJson(data));
      await addPicture(File(result));
    }
    print(result);
  }

  Future<void> sendTextMessage() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final message = messageController.text.trim();
    if (message.isEmpty) return;
    // messageController.clear();
    var data = {
      "data": message,
      "timeStamp": DateTime.now().toIso8601String(),
      "senderId": preferencesController.employeeDetails!.employeeId.toString(),
      "receiverId": !employeeIsHR
          ? preferencesController.hrLeadDetails!.employeeId.toString()
          : chatListModel!.employeeId.toString(),
      "contentType": "text"
    };
    print(data);
    list.insert(0, ChatModel.fromJson(data));
    await addMsg();
  }

  Future<void> startRecording() async {
    final permission = await recorderController.checkPermission();
    if (permission) {
      recording.value = true;
      recorderController.refresh();
      await recorderController.record();
      startTimer();
    }
  }

  Future<void> stopRecording() async {
    final result = await recorderController.stop();
    // final file = File(result!);
    // List<int> imageBytes = await file.readAsBytes();
    // String base64Image = base64Encode(imageBytes);
    if (result != null) {
      var data = {
        "data": result,
        "timeStamp": DateTime.now().toIso8601String(),
        "senderId":
            preferencesController.employeeDetails!.employeeId.toString(),
        "receiverId": !employeeIsHR
            ? preferencesController.hrLeadDetails!.employeeId.toString()
            : chatListModel!.employeeId.toString(),
        "contentType": "audio"
      };
      list.insert(0, ChatModel.fromJson(data));
      addVoiceRecord(File(result));
    }
    resetValues();
  }

  Future<void> cancelRecording() async {
    final result = await recorderController.stop();
    print(result);
    resetValues();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (currentDuration.value == maxDuration) {
          timer.cancel();
          recorderController.pause();
        } else {
          currentDuration.value++;
        }
      },
    );
  }

  void resetValues() {
    recording.value = false;
    currentDuration.value = 0;
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  Future prepareAudioPlayer(String path) async {
    await playerController.preparePlayer(
      path: path,
      shouldExtractWaveform: true,
      volume: 1.0,
    );
  }

  Future<void> updatePlayerState(String path) async {
    if (playing.value) {
      await playerController.pausePlayer();
    } else {
      await playerController.startPlayer();
    }
    playing.value = !playing.value;
  }

  Future<void> checkAudiosLength(List<ChatModel> chatUnit) async {
    for (int i = 0; i < chatUnit.length; i++) {
      final chat = chatUnit[i];
      print('checkAudiosLength => $chat');
      if (chat.contentType == 'audio') {
        final isFile = chat.data!.contains('http') ? false : true;
        if (!isFile) {
          final dur = await _loadAudio(chat.data!);
          print('checkAudiosLength => $dur');
          chat.duration = dur;
        }
      }
    }
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
