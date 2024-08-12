import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  bool isRecording = false;

  bool imagein = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for ListViewCurrent widget.
  ScrollController? listViewCurrent;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - convertImageFileToBase64] action in IconButton widget.
  String? iran64;
  String? audioToUpload;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  // Stores action output result for [Custom Action - audioToBase64] action in IconButton widget.
  String? audio64;
  // Stores action output result for [Backend Call - API (VoiceChat)] action in IconButton widget.
  ApiCallResponse? apiResultVoice;
  // State field(s) for TextPrompt widget.
  FocusNode? textPromptFocusNode;
  TextEditingController? textPromptTextController;
  String? Function(BuildContext, String?)? textPromptTextControllerValidator;
  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  // Stores action output result for [Backend Call - API (ImageChat)] action in IconButton widget.
  ApiCallResponse? chatResult1;
  // Stores action output result for [Backend Call - API (askquestion)] action in IconButton widget.
  ApiCallResponse? chatResult;
  AudioRecorder? audioRecorder;
  // State field(s) for ScrollableColumn widget.
  ScrollController? scrollableColumn;
  // State field(s) for ChatHistoryListView widget.
  ScrollController? chatHistoryListView;

  @override
  void initState(BuildContext context) {
    listViewCurrent = ScrollController();
    scrollableColumn = ScrollController();
    chatHistoryListView = ScrollController();
  }

  @override
  void dispose() {
    listViewCurrent?.dispose();
    textPromptFocusNode?.dispose();
    textPromptTextController?.dispose();

    scrollableColumn?.dispose();
    chatHistoryListView?.dispose();
  }
}
