<template lang="pug">
.validators
  list-item(
    v-if="orderedValidators.length > 0"
    v-for="v in orderedValidators"
    :image="v.avatarUrl"
    :key="v.owner"
    :title="validatorTitle(v)"
    :subtitle="votingPower(v)"
    :to="`/validators/${v.owner}`")
  list-item(v-else title="validators are loading...")
</template>

<script>
import { mapGetters } from "vuex"
import orderedValidators from "scripts/orderedValidators"
import validatorTitle from "scripts/validatorTitle"
import votingPower from "scripts/votingPower"
import votingValidators from "scripts/votingValidators"
import ListItem from "./NiListItem"
export default {
  name: "page-validators",
  components: {
    ListItem
  },
  computed: {
    ...mapGetters(["validators"]),
    orderedValidators() {
      return orderedValidators(votingValidators(this.validators))
    }
  },
  data: () => ({
    validatorTitle: validatorTitle,
    votingPower: votingPower
  })
}
</script>
