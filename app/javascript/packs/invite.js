/* eslint no-console: 0 */

import Vue from 'vue'
import App from '../invite.vue'
import BootstrapVue from 'bootstrap-vue'
import lodash from 'lodash'
import VueLodash from 'vue-lodash'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'


Vue.use(BootstrapVue);
Vue.use(VueLodash, lodash)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#invite',
    render: h => h(App)
  })
})
