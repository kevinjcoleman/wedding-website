<template>
  <div id="admin">
    <at-table :columns="columns" :data="inviteGroups.inviteGroups"></at-table>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'


export default {
  data: function () {
    return {
      columns: [
        {
          title: 'Name',
          key: 'name'
        },
        {
          title: 'Attending',
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
        }
      ]
    }
  },
  computed: mapGetters([
    'inviteGroups'
  ]),
  methods: {
    ...mapActions([
      'getInviteGroups'
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
