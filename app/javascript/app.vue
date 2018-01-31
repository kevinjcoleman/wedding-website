<template>
  <div id="rsvp">
    <div class="jumbotron jumbotron-fluid blue-jumbotron text-center">
      <h1 class="display-4">Please RSVP Below</h1>
      <hr class="my-4 pink-break">
      <label class='field'>
        <b-form-input v-model="searchTerm"
                  type="text"
                  placeholder="Enter your name..."
                  @input="logChange"></b-form-input>
      </label>
      <div class='row rsvps'>
        <div class='col-12 col-md-4' v-for="group in inviteSearch">
          <b-card bg-variant="dark" text-variant="white" :title="group.name">
            <p class="card-text">
              <hr class="my-4">
              {{ group.inviteeString }}
            </p>
            <b-button :href="group.editUrl" variant="white">RSVP</b-button>
          </b-card>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      message: "Hello Vue!",
      searchTerm: '',
      inviteGroups: [],
      searchedInviteGroups: []
    }
  },
  methods: {
    logChange: function () {
      this.filterForTerm()
    },
    filterForTerm: function () {
      var state = this
      this.searchedInviteGroups = this._.filter(this.inviteGroups, function(o) { 
         return o.name.toLowerCase().includes(state.searchTerm.toLowerCase()) || o.inviteeString.toLowerCase().includes(state.searchTerm.toLowerCase())
      })
    }
  },
  computed: {
    inviteSearch: function () {
      return this.searchTerm.length > 2 ? this.searchedInviteGroups : [] // Make this an empty array soon.
    }
  },
  created() {
    axios.get(`/invite_groups.json`)
    .then(response => {
      // JSON responses are automatically parsed.
      console.log(response.data)
      this.inviteGroups = response.data.inviteGroups
    })
    .catch(e => {
      this.errors.push(e)
    })
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
