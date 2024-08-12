import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCfS8S74ZgAlMbMJlCWwVLeIfhuUI3_b5Y",
            authDomain: "chatter-box-v2-inoz2n.firebaseapp.com",
            projectId: "chatter-box-v2-inoz2n",
            storageBucket: "chatter-box-v2-inoz2n.appspot.com",
            messagingSenderId: "22113650499",
            appId: "1:22113650499:web:994c84a0853b2b7d0351f6"));
  } else {
    await Firebase.initializeApp();
  }
}
