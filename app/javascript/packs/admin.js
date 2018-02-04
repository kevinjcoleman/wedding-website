/* eslint no-console: 0 */

import Vue from 'vue'
import Admin from '../admin.vue'
import store from '../store'
import lodash from 'lodash'
import VueLodash from 'vue-lodash'
import Raven from 'raven-js';
import RavenVue from 'raven-js/plugins/vue';
import AtComponents from 'at-ui'
import 'at-ui-style'

Raven
    .config('https://7f28831b56f4499b9031dbbf21035203@sentry.io/280968')
    .addPlugin(RavenVue, Vue)
    .install()

Vue.use(AtComponents);
Vue.use(VueLodash, lodash)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#admin',
    store,
    render: h => h(Admin)
  })
})
