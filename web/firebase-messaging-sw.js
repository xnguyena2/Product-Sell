importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: 'AIzaSyBd2e0R9d6R9E98rXIznGyWfbuTAhWXcJQ',
    appId: '1:863872732054:web:4d252ff4eb42cd8530abb7',
    messagingSenderId: '863872732054',
    projectId: 'trumbien',
    authDomain: 'trumbien.firebaseapp.com',
    storageBucket: 'trumbien.appspot.com',
    measurementId: 'G-EWD941CVYQ',
});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
    console.log("onBackgroundMessage", m);
});