<template>
  <div id="invite">
    <div class="jumbotron jumbotron-pink">
      <h1 class="display-4 text-center">Update Your Invitation</h1>
      <hr class="my-4">
      <p class="lead">Please update your invitation with your name if it needs edits, whether you will be attending or not whether you will be bringing a plus one.</p>
      
      
      <b-alert variant="warning"
               dismissible
               :show="showAlert"
               @dismissed="showAlert=false">
        Please fill out all names to submit.
      </b-alert>
      
      <b-alert variant="success"
               dismissible
               :show="showSuccess"
               @dismissed="showSuccess=false">
        You've RSVP'd successfully, we'll see you on April 21st!
      </b-alert>
      
      <b-alert variant="success"
               dismissible
               :show="canceledRsvpSuccess"
               @dismissed="canceledRsvpSuccess=false">
        You've canceled your RSVP, we'll miss you!
      </b-alert>
      
      <b-alert variant="warning"
               dismissible
               :show="showNoInvites"
               @dismissed="showNoInvites=false">
        You've RSVP'd with no invites, please cancel your RSVP, or confirm for one of your invites.
      </b-alert>

      <div class='row'>
        <div class="col-10">
          Name
        </div>
        <div class="col-2">
          Attending
        </div>
      </div>

      <div class="" v-for="invitee in invitees">
        <div class="row invite-section">
          <div class='col-10'>
            <b-form-input v-model="invitee.name"
                      type="text"
                      placeholder="Add name"
                      :state="validInput(invitee.name)"
                      @input="logChange(invitee.id)"></b-form-input>
            <b-form-invalid-feedback>
              <!-- This will only be shown if the preceeding input has an invalid state -->
              You must enter a name.
            </b-form-invalid-feedback>
          </div>
          <div class='col-2'>
            <b-form-checkbox v-model="invitee.confirmed"
                             value="true"
                             unchecked-value="false">
            </b-form-checkbox>
            <b-btn v-if="(invitee.hasPlusOne == null || invitee.hasPlusOne == false) && invitee.plusOneEligible " variant="white" @click="invitee.hasPlusOne = !invitee.hasPlusOne">
              Add plus one <i class="fa fa-plus" aria-hidden="true"></i>
            </b-btn>          
          </div>
        </div>
        <b-collapse class="mt-2" v-model="invitee.hasPlusOne" :id="invitee.id + 'collapse'">
          <div class="row">
            <div class='col-10'>
              <b-form-input v-model="invitee.plusOneName"
                        type="text"
                        :state="validInput(invitee.plusOneName)"
                        placeholder="Add name"></b-form-input>
              <b-form-invalid-feedback>
                <!-- This will only be shown if the preceeding input has an invalid state -->
                You must enter a name.
              </b-form-invalid-feedback>
            </div>
            <div class='col-2'>
              <b-btn v-if="invitee.plusOneEligible" class="plusone-button" variant="warning" @click="invitee.hasPlusOne = !invitee.hasPlusOne">
                Remove plus one <i class="fa fa-times" aria-hidden="true"></i>
              </b-btn>  
            </div>
          </div>

        </b-collapse>
      </div>
      <div style="margin-bottom: 3em;"></div>
      <b-button-group class="submit-buttons row">
        <b-button @click="onSubmit" variant="success" class="col-md-6">RSVP</b-button>
        <b-button @click="cancelRsvp" variant="warning" class="col-md-6">Not attending</b-button>
      </b-button-group>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      invitees: [],
      plusOneCount: 1,
      slug: window.slug,
      submitted: false,
      showAlert: false,
      showSuccess: false,
      showNoInvites: false,
      canceledRsvpSuccess: false
    }
  },
  methods: {
    logChange: function (invitee) {
    },
    onSubmit: function () {
      this.cancelNotifications()
      this.submitted = true
      if (this.invalidInput()) {
        this.showAlert = true
      } else {
        if (this.hasConfirmedInvites()) {
          this.showSuccess = true
          axios.patch(`/invite_groups/${this.slug}`, this.invitees)
          .then(response => {
          })
          .catch(e => {
            console.log(e)
          })
        } else {
          this.showNoInvites = true
        }
      }
    },
    addPlusOne: function() {
      console.log('adding plus one')
    },
    validInput: function(name) {
      if (name && name.length > 0 ) {
        return true
      } else if (!this.submitted) {
        return true
      } else {
        return false
      }
    },
    invalidInput: function() {
      return _.some(this.invitees, function(invitee) {
          if (invitee.hasPlusOne && ((invitee.plusOneName && invitee.plusOneName.length == 0) || !invitee.plusOneName)) {          
            return true
          } 
          else if (!invitee.name && invitee.confirmed) {
            return true
          } else {
            return false
          }
      })
    },
    cancelRsvp: function() {
      this.cancelNotifications()
      _.each(this.invitees, function(invitee) {
        invitee.confirmed = false
      })
      this.canceledRsvpSuccess = true
    },
    hasConfirmedInvites: function() {
      console.log('confirmed invites', _.filter(this.invitees, function(o) { return o.confirmed; }).length > 0)
      return  _.filter(this.invitees, function(o) { return o.confirmed; }).length > 0
    },
    cancelNotifications: function() {
      this.showAlert = false
      this.showSuccess = false
      this.showNoInvites = false
      this.canceledRsvpSuccess = false
    }
  },
  computed: {

  },
  created() {
    axios.get(`/invite_groups/${this.slug}.json`)
    .then(response => {
      // JSON responses are automatically parsed.
      console.log(response.data)
      this.invitees = response.data.invitees
      this.inviteName = response.data.inviteName
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
.submit-buttons {
  width: 100%;
}
.invalid-feedback {
  color: yellow;
}
.alert-warning {
    color: black;
    background-color: yellow;
    border-color: yellow;
}
.btn-warning {
  background-color: yellow !important;
}

.alert-success {
    color: white;
    background-color: green;
    border-color: green;
}
.invite-section {
  margin-top: 1em;
  margin-bottom: 1em;
}

</style>
