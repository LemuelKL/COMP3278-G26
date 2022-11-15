<template>
    This is the index page.

    <button @click="$router.push('login')">Go to Login</button>
    <button @click="$router.push('login/face/LEMUEL')">Go to Login Face</button>
</template>

<script lang="ts" setup>
// import {QWebChannel, qt} from 'qwebchannel'
// new QWebChannel(qt.webChannelTransport, function (channel) {
//             window.web_app_host = channel.objects.web_app_host;
//             alert('Web app host is ready');
//           });
// console.log(QWebChannel)
</script>