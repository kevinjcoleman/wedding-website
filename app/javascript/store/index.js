import Vue from 'vue'
import Vuex from 'vuex'
import { getInviteGroups } from '../data/api'

Vue.use(Vuex)

// root state object.
// each Vuex instance is just a single state tree.
const state = {
  inviteGroups: []
}

// mutations are operations that actually mutates the state.
// each mutation handler gets the entire state tree as the
// first argument, followed by additional payload arguments.
// mutations must be synchronous and can be recorded by plugins
// for debugging purposes.
const mutations = {
  setInviteGroups (state, inviteGroups) {
    state.inviteGroups = inviteGroups
  }
}

// actions are functions that cause side effects and can involve
// asynchronous operations.
const actions = {
  getInviteGroups ({commit, state}) {
    return new Promise((resolve, reject) => {
      getInviteGroups()
        .then((response) => {
          commit('setInviteGroups', response)
          resolve(true)
        }).catch((error) => {
          /* istanbul ignore next */
          reject(error)
        })
    })
  }
}

// getters are functions
const getters = {
  inviteGroups: state => state.inviteGroups
}

// A Vuex instance is created by combining the state, mutations, actions,
// and getters.
export default new Vuex.Store({
  state,
  getters,
  actions,
  mutations
})