import axios from 'axios';

export const getInviteGroups = () => {
  return axios.get(`/invite_groups.json`)
  .then(response => {
    // JSON responses are automatically parsed.
    return Promise.resolve(response.data)
  })
  .catch((e) => {
    console.log(e)
    return Promise.reject(error)
  })
}