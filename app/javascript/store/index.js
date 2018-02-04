import Vue from 'vue'
import Vuex from 'vuex'
import _ from 'lodash'
import { getInviteGroups } from '../data/api'

Vue.use(Vuex)

// root state object.
// each Vuex instance is just a single state tree.
const state = {
  inviteGroups: [],
  searchTerm: "",
  inviteStatusCategory: null
}

function notNilField(field) {
  if (field != null && field.length != 0) {
    return true
  } else {
    return false
  }
}

function returnInviteGroupsByTerm(state, inviteGroups) {
   return _.filter(inviteGroups, function(o) { 
     return o.name.toLowerCase().includes(state.searchTerm.toLowerCase()) || o.inviteeString.toLowerCase().includes(state.searchTerm.toLowerCase())
  })
}

function returnInviteGroupsByStatus(state, inviteGroups) {
  return _.filter(inviteGroups, function(o) { 
    if (state.inviteStatusCategory == 'attending') {
      return o.rsvped == true 
    } else if (state.inviteStatusCategory == 'not_attending') {
      return o.rsvped == false 
    } else {
      return o.rsvped == null
    }
 })
}

function filteredInviteGroups (state) {
  if (notNilField(state.searchTerm) && notNilField(state.inviteStatusCategory)) {
    var inviteGroups = returnInviteGroupsByTerm(state, state.inviteGroups)
    return returnInviteGroupsByStatus(state, inviteGroups)
  } else if (notNilField(state.searchTerm)) {
    return returnInviteGroupsByTerm(state, state.inviteGroups)
  } else if (notNilField(state.inviteStatusCategory)) {
    return returnInviteGroupsByStatus(state, state.inviteGroups)
  } else {
    return state.inviteGroups
  }
}

// mutations are operations that actually mutates the state.
// each mutation handler gets the entire state tree as the
// first argument, followed by additional payload arguments.
// mutations must be synchronous and can be recorded by plugins
// for debugging purposes.
const mutations = {
  setInviteGroups (state, inviteGroups) {
    state.inviteGroups = inviteGroups
    state.filteredInviteGroups = inviteGroups
  },
  updateSearchTerm (state, searchTerm) {
    state.searchTerm = searchTerm
  },
  updateInviteStatusCategory (state, inviteStatusCategory) {
    state.inviteStatusCategory = inviteStatusCategory
  }
}

// actions are functions that cause side effects and can involve
// asynchronous operations.
const actions = {
  getInviteGroups ({commit, state}) {
    return new Promise((resolve, reject) => {
      getInviteGroups()
        .then((response) => {
          commit('setInviteGroups', response.inviteGroups)
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
  inviteGroups: (state, getters) => {
    return filteredInviteGroups(state)
  },
  searchTerm: state => state.searchTerm,
  inviteStatusCategory: state => state.inviteStatusCategory,
  isSearching: (state) => {
    return notNilField(state.searchTerm) || notNilField(state.inviteStatusCategory)
  },
  inviteCount: (state, getters) => getters.inviteGroups.length,
}

// A Vuex instance is created by combining the state, mutations, actions,
// and getters.
export default new Vuex.Store({
  state,
  getters,
  actions,
  mutations
})