<template>
  <q-page class="q-pa-md">
    <q-card flat bordered>
      <q-card-section>
        <q-input outlined v-model="email" label="Email" />
      </q-card-section>
      <q-card-actions align="right">
        <q-btn outline label="Update Profile" @click="updateProfile()" />
      </q-card-actions>
    </q-card>
  </q-page>
</template>

<script lang="ts" setup>
import { useQuasar } from 'quasar';
import { ref } from 'vue';
import { wahost } from 'src/boot/qtwebchannel';

const $q = useQuasar();
const email = ref('');
wahost?.getStudentEmail((_email) => {
  email.value = _email;
});

function updateProfile() {
  wahost?.updateStudentProfile(email.value, function (status) {
    if (status) {
      $q.dialog({
        title: 'Success',
        message: 'Profile updated',
      });
    } else {
      $q.dialog({
        title: 'Error',
        message: 'Profile update failed',
      });
    }
  });
}
</script>
