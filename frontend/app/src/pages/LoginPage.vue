<template>
    Login Page.

    <q-input v-model="username" label="Username" />
    <q-btn @click="login">Login</q-btn>

</template>

<script lang="ts" setup>
import { wahost } from './../boot/qtwebchannel'

import { ref } from 'vue';
const username = ref('');

const login = () => {
    wahost.sayMsg(username.value)
}
</script>