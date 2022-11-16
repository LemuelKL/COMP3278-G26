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
      <q-markup-table flat>
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
          <th class="text-right">Notes:</th>
          <td>{{ upcomingLesson.notes }}</td>
        </tr>
        <tr>
          <th class="text-right">Other:</th>
          <td>{{ upcomingLesson.other }}</td>
        </tr>
      </q-markup-table>
    </q-card-section>
    <q-card-actions align="right">
      <q-btn icon="send" outline @click="emailMyself">Email Myself</q-btn>
    </q-card-actions>
  </q-card>
</template>

<script lang="ts" setup>
import { ref } from 'vue';
import { wahost } from 'src/boot/qtwebchannel';

const upcomingLesson = ref({
  course_title: '',
  classroom: '',
  start_time: '',
  end_time: '',
  message: '',
  zoomLink: '',
  notes: '',
  other: '',
});

wahost?.getUpcomingLesson((lesson) => {
  if (lesson == '') return;
  upcomingLesson.value = JSON.parse(lesson);
});

const timeNow = ref(new Date().toLocaleString());
setInterval(() => {
  timeNow.value = new Date().toLocaleString();
}, 1000);

function joinZoom() {
  window.location.href = upcomingLesson.value.zoomLink;
}

function emailMyself() {
  // wahost?.emailMyself();
  alert('Email Sent!');
}
</script>
