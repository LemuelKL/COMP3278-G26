import { boot } from 'quasar/wrappers'


interface WebAppHost {
  recognizeFace(username: string, image: string, callback: (status: boolean) => void): void
  checkUsername(username: string, callback: (userExists: boolean) => void): void
  recordLogout(): void
  getLastLoginDtStr(callback: (lastLoginDtStr: string) => void): void
  getUsername(callback: (username: string) => void): void

  getTimetable(callback: (timetableStr: string) => void): void
  getUpcomingLesson(callback: (upcomingLessonStr: string) => void): void

  updateStudentProfile(username: string): void
  emailMyself(callback: (result: string) => void): void
}

import { QWebChannel } from 'qwebchannel'
let wahost = null as WebAppHost | null


function bootWrapper() { 
  return new Promise<WebAppHost>((resolve, reject) => {
    // this `qt` variable will be available at run time in the QtWebEngine process
    new QWebChannel(qt.webChannelTransport, (channel: {objects: {web_app_host: WebAppHost}}) => {
      resolve(channel.objects.web_app_host)
    }, reject)
  })
}


console.log('booting qtwebchannel')
export default boot(async () => {
  wahost = await bootWrapper()
  console.log('qtwebchannel booted')
});

export { wahost }