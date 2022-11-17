<template>
  <q-card bordered flat>
    <q-card-section>
      <div class="text-h6 text-right">{{ timeNow }}</div>
      <div class="text-subtitle2 text-grey-6 text-right">
        No upcoming classes in the following hour
      </div>
    </q-card-section>
    <q-separator></q-separator>
    <q-card-section>
      <q-markup-table flat>
        <thead>
          <tr>
            <th class="text-left">Course</th>
            <th class="text-left">Venue</th>
            <th class="text-right">Day</th>
            <th class="text-right">Start time</th>
            <th class="text-right">End time</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="lesson in timetable"
            :key="JSON.stringify(lesson)"
            :class="{ today: today_weekday == lesson.day }"
          >
            <td>{{ lesson.course_title }}</td>
            <td>{{ lesson.classroom }}</td>
            <td class="text-right">
              {{ weekday[lesson.day] }}
            </td>
            <td class="text-right" style="font-family: monospace">
              {{ lesson.start_time }}
            </td>
            <td class="text-right" style="font-family: monospace">
              {{ lesson.end_time }}
            </td>
          </tr>
        </tbody>
      </q-markup-table>
    </q-card-section>
  </q-card>
</template>

<script lang="ts" setup>
import { wahost } from 'src/boot/qtwebchannel';
import { ref } from 'vue';

const weekday = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
const today_weekday = new Date().getDay() - 1;

interface Lesson {
  course_title: string;
  classroom: string;
  start_time: string;
  end_time: string;
  day: number;
}

const timetable = ref<Lesson[]>([]);
wahost?.getTimetable((tt) => {
  timetable.value = JSON.parse(tt);
});

const timeNow = ref(new Date().toLocaleString());
setInterval(() => {
  timeNow.value = new Date().toLocaleString();
}, 1000);
</script>

<style scoped>
.today {
  background-color: blanchedalmond;
}
</style>
