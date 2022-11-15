<template>
  <div style="height: 100vh" class="row justify-center items-center polka">
    <q-card flat bordered>
      <q-card-section class="welcome">
        <div class="text-h2">UScheduler</div>
        <div class="text-subtitle2 text-grey-6" style="max-width: 250px">
          your life easier
        </div>
      </q-card-section>
      <q-card-section>
        <q-input outlined v-model="username" label="Username" />
      </q-card-section>
      <q-separator></q-separator>
      <q-card-actions align="between">
        <q-btn
          @click="signup"
          no-caps
          outline
          align="around"
          label="Create Account"
        />
        <q-btn @click="login" no-caps outline align="around" label="Login" />
      </q-card-actions>
    </q-card>
  </div>
</template>

<script lang="ts" setup>
import { useRouter } from 'vue-router';

import { ref } from 'vue';
const username = ref('');

const router = useRouter();
function login() {
  router.push(`/login/face/${username.value}`);
}
function signup() {
  // TODO
  // router.push(`/signup/face/${username.value}`);
}

</script>

