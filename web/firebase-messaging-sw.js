importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: 'AIzaSyAGW2XNvy9jJEn-TURsyHykt2_i9DRiqSc',
    appId: '1:17775040778:web:9009f6375f271a9be402f3',
    messagingSenderId: '17775040778',
    projectId: 'sharenovel-flutter-3d556',
    authDomain: 'sharenovel-flutter-3d556.firebaseapp.com',
    // databaseURL: 'xxx',
    storageBucket: 'sharenovel-flutter-3d556.appspot.com',
    // measurementId: 'xxx',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
    console.log("onBackgroundMessage", m);
});