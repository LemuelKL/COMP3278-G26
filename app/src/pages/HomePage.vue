<template>
  <q-page class="q-pa-md">
    <div v-if="hasUpcomingLesson !== undefined">
      <UpcomingLessonVue v-if="hasUpcomingLesson"></UpcomingLessonVue>
      <PersonalTimetableVue v-else></PersonalTimetableVue>
    </div>
  </q-page>
</template>

<script lang="ts" setup>
import PersonalTimetableVue from 'src/components/PersonalTimetable.vue';
import UpcomingLessonVue from 'src/components/UpcomingLesson.vue';

import { ref } from 'vue';
import { wahost } from 'src/boot/qtwebchannel';

const hasUpcomingLesson = ref<undefined | boolean>(undefined);

wahost?.getUpcomingLesson((lesson) => {
  if (lesson == '') hasUpcomingLesson.value = false;
  else hasUpcomingLesson.value = true;
});
</script>
