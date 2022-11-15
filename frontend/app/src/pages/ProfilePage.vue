<template>
  <q-page class="q-pa-md">
    <q-card flat bordered>
      <q-card-section>
        <q-input outlined v-model="username" label="Username" />
      </q-card-section>
      <q-card-actions align="right">
        <q-btn outline label="Update Profile" @click="updateProfile()" />
      </q-card-actions>
    </q-card>
  </q-page>
</template>

<script lang="ts" setup>
import { ref } from 'vue';
import { wahost } from 'src/boot/qtwebchannel';

const username = ref('');
wahost?.getUsername((un) => {
  username.value = un;
});

function updateProfile() {
  wahost?.updateStudentProfile(username.value);
}
</script>
