<template>
  <div style="height: 100vh" class="row justify-center items-center polka">
    <q-card>
      <q-card-section>
        <div class="text-h4 text-center">Unlock with your Face</div>
      </q-card-section>
      <q-card-section>
        <div class="row justify-center">
          <video autoplay ref="videoplay"></video>
        </div>
      </q-card-section>
      <q-card-actions align="center">
        <q-btn @click="goBack" no-caps outline align="around" label="Back" />
      </q-card-actions>
    </q-card>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { wahost } from './../boot/qtwebchannel';
const videoplay = ref<HTMLVideoElement | null>(null);
const imageCapture = ref<ImageCapture | null>(null);

const track = ref<MediaStreamTrack | null>(null);
onMounted(() => {
  navigator.mediaDevices.getUserMedia({ video: true }).then((mediaStream) => {
    if (!videoplay.value) return;
    videoplay.value.srcObject = mediaStream;
    track.value = mediaStream.getVideoTracks()[0];
    imageCapture.value = new ImageCapture(track.value);
    stillCapture(videoplay.value, scratchCanvas, scratchContext);
  });
});
const scratchCanvas = document.createElement('canvas');
scratchCanvas.width = 640;
scratchCanvas.height = 480;
const scratchContext = scratchCanvas.getContext('2d');
const router = useRouter();
const route = useRoute();
function stillCapture(
  video: HTMLVideoElement,
  canvas: HTMLCanvasElement,
  context: CanvasRenderingContext2D | null
) {
  if (!context) return;
  context.drawImage(video, 0, 0, video.videoWidth, video.videoHeight);
  canvas.toBlob(function (jpegBlob: any) {
    blobToBase64(jpegBlob).then((d) =>
      wahost.recognizeFace(
        route.params.username,
        d,
        function (status: boolean) {
          if (status) {
            router.push({ name: 'login' });
          } else if (route.name === 'face') {
            stillCapture(video, canvas, context);
          }
        }
      )
    );
  }, 'image/jpeg');
}
function blobToBase64(blob: Blob) {
  return new Promise((resolve, _) => {
    const reader = new FileReader();
    reader.onloadend = () => resolve(reader.result);
    reader.readAsDataURL(blob);
  });
}

function goBack() {
  router.push({ name: 'login' });
}
</script>
