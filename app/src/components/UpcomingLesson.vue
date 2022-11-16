<template>
  <q-card flat bordered>
    <q-card-section>
      <div class="text-h6 text-right">{{ timeNow }}</div>
      <div class="text-subtitle2 text-grey-6 text-right">
        Information of the upcoming lesson
      </div>
    </q-card-section>
    <q-separator></q-separator>
    <q-card-section>
      <q-markup-table flat v-if="upcomingLesson">
        <tr>
          <th class="text-right">Course:</th>
          <td>{{ upcomingLesson.course_title }}</td>
        </tr>
        <tr>
          <th class="text-right">Venue:</th>
          <td>{{ upcomingLesson.classroom }}</td>
        </tr>
        <tr>
          <th class="text-right">Time:</th>
          <td>
            {{ upcomingLesson.start_time }} - {{ upcomingLesson.end_time }}
          </td>
        </tr>
        <tr>
          <th class="text-right">Message:</th>
          <td>{{ upcomingLesson.message }}</td>
        </tr>
        <tr>
          <th class="text-right">Zoom link:</th>
          <td><q-btn icon="videocam" outline @click="joinZoom">join</q-btn></td>
        </tr>
        <tr>
          <th><q-separator></q-separator></th>
          <td><q-separator></q-separator></td>
        </tr>
        <tr v-for="r in upcomingLesson.resources" :key="r.url">
          <th class="text-right">{{ r.name }}</th>
          <td>
            <a :href="r.url">{{ r.url }}</a>
          </td>
        </tr>
      </q-markup-table>
    </q-card-section>
    <q-separator></q-separator>
    <q-card-actions align="right">
      <q-btn icon="send" outline @click="emailMyself">Email Myself</q-btn>
    </q-card-actions>
  </q-card>
</template>

<script lang="ts" setup>
import { useQuasar } from 'quasar'
import { ref } from 'vue';
import { wahost } from 'src/boot/qtwebchannel';

interface Lesson {
  course_title: string;
  classroom: string;
  start_time: string;
  end_time: string;
  message: string | null;
  zoomLink: string | null;
  resources: Resource[];
}

interface Resource {
  name: string;
  url: string;
}

const upcomingLesson = ref<Lesson | null>(null);

wahost?.getUpcomingLesson((lesson) => {
  if (lesson == '') return;
  upcomingLesson.value = JSON.parse(lesson);
});

const timeNow = ref(new Date().toLocaleString());
setInterval(() => {
  timeNow.value = new Date().toLocaleString();
}, 1000);

function joinZoom() {
  if (upcomingLesson.value?.zoomLink == null) return;
  window.location.href = upcomingLesson.value.zoomLink;
}

const $q = useQuasar();

function emailMyself() {
  wahost?.emailMyself((result: string) => {
    $q.dialog({
      title: 'Email',
      message: result,
      ok: 'OK',
    });
  });
}
</script>
