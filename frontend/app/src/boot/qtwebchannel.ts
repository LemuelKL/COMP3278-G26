import { boot } from 'quasar/wrappers'

// "async" is optional;
// more info on params: https://v2.quasar.dev/quasar-cli/boot-files
// export default boot(async (/* { app, router, ... } */) => {
//   // something to do
// })

import { QWebChannel } from 'qwebchannel'
let wahost = null

export default boot(async () => {
  new QWebChannel(qt.webChannelTransport, function (channel: { objects: { web_app_host: any; }; }) {
    wahost = channel.objects.web_app_host;
  });
});

export { wahost }