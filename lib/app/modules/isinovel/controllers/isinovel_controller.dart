import 'package:get/get.dart';
import 'package:share_novel/app/data/models/isi_model.dart';
import 'package:share_novel/app/data/provider/isi_provider.dart';
import 'package:flutter_tts/flutter_tts.dart';

class IsinovelController extends GetxController {
  var isi = Isi().obs;
  final count = 0.obs;
  final isiProvider = Get.put(IsiProvider());
  var idChapter;

  var pitchvalue = 1.8.obs;
  final FlutterTts flutterTts = FlutterTts();
  bool isPaused = false;

  @override
  void onInit() {
    super.onInit();
    idChapter = Get.arguments['idChapter'];
    print(idChapter);
    fetchIsiByIdBuku(idChapter);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> fetchIsiByIdBuku(int id) async {
    try {
      isi.value = await isiProvider.fetchIsiByIdBuku(id);
    } catch (e) {
      print('Error: $e');
    }
  }

  // Method untuk mengubah isi menjadi speech
  Future<void> textToSpeech(String text) async {
    await flutterTts.setVoice({
      "name":
          "id-id-x-dfe-local", // Male voice identifier for Indonesian language
      "locale": "id-ID" // Set the locale to Indonesian
    });
    await flutterTts.setLanguage("id-ID"); // Set language to Indonesian
    await flutterTts.setPitch(pitchvalue.value); // Set pitch (optional)
    await flutterTts.speak(text); // Start text-to-speech
  }

  // Method untuk menjeda (pause) pembacaan teks
  Future<void> pauseSpeech() async {
    await flutterTts.pause();
  }

  Future<void> stopSpeech() async {
    await flutterTts.stop(); // Stop pembacaan teks
  }
}
