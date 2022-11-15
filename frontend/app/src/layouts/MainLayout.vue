<template>
  <q-layout view="hHh lpR fFf">
    <q-drawer show-if-above :width="250" :breakpoint="600" bordered>
      <q-scroll-area class="fit">
        <div class="column justify-between" style="height: 100vh">
          <div>
            <q-img
              src="https://cdn.quasar.dev/img/material.png"
              style="height: 150px"
            >
              <div class="bg-transparent">
                <q-avatar size="56px" class="q-mb-sm">
                  <img src="https://cdn.quasar.dev/img/boy-avatar.png" />
                </q-avatar>
                <div class="text-weight-bold">{{ username }}</div>
                <div>Welcome back!</div>
              </div>
            </q-img>

            <q-list>
              <q-item
                :active="$route.name === 'home'"
                clickable
                v-ripple
                @click="$router.push({ name: 'home' })"
              >
                <q-item-section avatar>
                  <q-icon name="home" />
                </q-item-section>
                <q-item-section> Home </q-item-section>
              </q-item>
              <q-separator></q-separator>
              <q-item
                :active="$route.name === 'profile'"
                clickable
                v-ripple
                @click="$router.push({ name: 'profile' })"
              >
                <q-item-section avatar>
                  <q-icon name="account_box" />
                </q-item-section>
                <q-item-section> Profile </q-item-section>
              </q-item>
              <q-separator></q-separator>
            </q-list>
          </div>
          <div class="q-px-md row justify-center">
            <div class="col column justify-center q-gutter-sm">
              <q-btn outline @click="logout">Logout</q-btn>
              <div
                class="text-subtitle2 text-grey-6"
                style="font-family: monospace"
              >
                {{ lastLoginDtStr }}
              </div>
            </div>
          </div>
        </div>
      </q-scroll-area>
    </q-drawer>
    <q-page-container class="polka">
      <router-view></router-view>
    </q-page-container>
  </q-layout>
</template>

<script lang="ts" setup>
import { wahost } from 'src/boot/qtwebchannel';
import { useRouter } from 'vue-router';
import { ref } from 'vue';
const lastLoginDtStr = ref('');
const username = ref('');

wahost?.getLastLoginDtStr((dtStr: string) => {
  lastLoginDtStr.value = dtStr;
});
wahost?.getUsername((usernameStr: string) => {
  username.value = usernameStr;
});

const router = useRouter();
function logout() {
  wahost?.recordLogout();
  router.push('/login');
}
</script>
