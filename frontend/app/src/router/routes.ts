import { RouteRecordRaw } from 'vue-router';
import IndexPageVue from 'pages/IndexPage.vue';
import LoginPageVue from 'pages/LoginPage.vue';
import LoginFacePageVue from 'pages/LoginFacePage.vue';

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    component: IndexPageVue,
  },
  { path: '/login', component: LoginPageVue },
  { path: '/login/face/:username', component: LoginFacePageVue },
  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue'),
  },
];

export default routes;
