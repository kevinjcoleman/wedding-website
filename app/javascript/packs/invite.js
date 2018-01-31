/* eslint no-console: 0 */

import Vue from 'vue'
import App from '../invite.vue'
import BootstrapVue from 'bootstrap-vue'
import lodash from 'lodash'
import VueLodash from 'vue-lodash'
import Raven from 'raven-js';
import RavenVue from 'raven-js/plugins/vue';

Raven
    .config('https://7f28831b56f4499b9031dbbf21035203@sentry.io/280968')
    .addPlugin(RavenVue, Vue)
    .install()
    
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
