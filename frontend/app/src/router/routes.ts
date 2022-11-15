import { RouteRecordRaw } from 'vue-router';
import HomePageVue from 'pages/HomePage.vue';
import ProfilePageVue from 'pages/ProfilePage.vue';
import LoginPageVue from 'pages/LoginPage.vue';
import LoginFacePageVue from 'pages/LoginFacePage.vue';
import MainLayoutVue from 'src/layouts/MainLayout.vue';

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    component: MainLayoutVue,
    children: [
      {
        path: 'home',
        name: 'home',
        component: HomePageVue,
      },
      {
        path: 'profile',
        name: 'profile',
        component: ProfilePageVue,
      }
    ],
  },
  { path: '/login', name: 'login', component: LoginPageVue },
  { path: '/login/face/:username', name: 'face', component: LoginFacePageVue },
  // Always leave this as last one,
  // but you can also remove it
  {
    path: '/:catchAll(.*)*',
    component: () => import('pages/ErrorNotFound.vue'),
  },
];

export default routes;
