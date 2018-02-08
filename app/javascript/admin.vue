<template>
  <div id="admin">
    <div class="row at-row">
      <div class="col-xs-24 col-md-20 col-md-offset-2">
        <h1>Admin</h1>
      </div>
      <div class="col-xs-24 col-md-10 col-md-offset-2">
        <at-input v-model="searchTerm" @change="updateSearchTerm" placeholder="Search..." prepend-button>
          <template slot="prepend">
            <i class="icon icon-search"></i>
          </template>
        </at-input>
      </div>
      <div class="col-xs-24 col-md-10">
        <at-select v-model="inviteStatusCategory" clearable style="width:100%">
          <at-option value="attending">Attending</at-option>
          <at-option value="not_attending">Not Attending</at-option>
          <at-option value="unconfirmed">Unconfirmed</at-option>
        </at-select>
      </div>
      <div class="col-xs-24 col-md-10 col-md-offset-2">
        <p v-if="isSearching" style="text-align: left;">Current searched invite Count is {{ inviteCount }}</p>
        <p v-else style="text-align: left;">Current invite count is {{ inviteCount }}</p>
      </div>
    </div>
    <div class="row at-row">
      <div class="col-md-20 col-md-offset-2">
        <at-table :columns="columns" :data="inviteGroups"></at-table>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions, mapState } from 'vuex'


export default {
  data: function () {
    return {
      columns: [
        {
          title: 'Name',
          key: 'name'
        },
        {
          title: 'Invitees',
          key: 'inviteeString'
        },
        {
          title: 'Attending?',
          render: (h, params) => {
            return h('div', [
              h('at-badge', {
                props: {
                  value: this.inviteStatusString(params.item.rsvped),
                  status: this.inviteStatus(params.item.rsvped)
                }
              })
            ])
          }
        },
        {
          title: 'Invitees',
          render: (h, params) => {
            return h('div', [
              h('at-badge', {
                props: {
                  value: this.inviteeCount(params.item),
                  status: 'success'
                }
              })
            ])
          }
        },
        {
          title: 'Plus ones',
          render: (h, params) => {
            return h('div', [
              h('at-badge', {
                props: {
                  value: this.plusOneCount(params.item),
                  status: 'warning'
                }
              })
            ])
          }
        },
        {
          title: 'Total Attending',
          render: (h, params) => {
            return h('div', [
              h('at-badge', {
                props: {
                  value: this.totalAttendingCount(params.item),
                  status: 'default'
                }
              })
            ])
          }
        }
      ]
    }
  },
  computed: {
    ...mapGetters([
      'inviteGroups',
      'isSearching',
      'inviteCount'
    ]),
    searchTerm: {
      ...mapState({
        get: state => state.searchTerm
      }),
      set (value) {
        console.log(value)
        this.$store.commit('updateSearchTerm', value)
      }
    },
    inviteStatusCategory: {
      ...mapState({
        get: state => state.inviteStatusCategory
      }),
      set (value) {
        console.log(value)
        this.$store.commit('updateInviteStatusCategory', value)
      }
    },
    

  },
  methods: {
    ...mapActions([
      'getInviteGroups'
    ]),
    ...mapGetters([
      'searchInviteGroups'
    ]),
    inviteStatusString (status) {
      if (status === null) {
        return 'unconfirmed'
      } else {
        return status ? 'confirmed' : 'not attending'
      }
    },
    inviteStatus (status) {
      if (status === null) {
        return 'warning'
      } else {
        return status ? 'success' : 'danger'
      }
    }, 
    updateSearchTerm (e) {
      this.$store.commit('updateSearchTerm', e.target.value)
    },
    inviteeCount (inviteGroup) {
      return inviteGroup.invitees.length
    },
    plusOneCount (inviteGroup) {
      return _.filter(inviteGroup.invitees, (o) => { 
        return o.hasPlusOne
     }).length
    },
    totalAttendingCount (inviteGroup) {
      return _.reduce(inviteGroup.invitees, (sum, invitee) => {
        if (inviteGroup.rsvped == true && invitee.confirmed == true && invitee.hasPlusOne == true) {
          return sum + 2
        } else if (inviteGroup.rsvped == true && invitee.confirmed == true) {
          return sum + 1
        } else {
          return sum
        }
      }, 0)
    }
  },
  created() {
    this.getInviteGroups()
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
