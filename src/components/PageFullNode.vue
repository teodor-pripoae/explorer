<template lang="pug">
page(:title="`Node: ${getIp(fullNode)}`")
  tool-bar
    router-link(to="/nodes" exact): i.material-icons arrow_back
    anchor-copy(:value="fullNode.node_info.id" icon="content_copy")

  part(title='ID')
    list-item(dt="Moniker" :dd="fullNode.node_info.moniker")
    list-item(dt="IP" :dd="getIp(fullNode)")
    list-item(dt="Start Date" :dd="fullNode.connection_status && readableDate(fullNode.connection_status.SendMonitor.Start)")

  part(title='Pub Key')
    list-item(dt="Value" :dd="fullNode.node_info.id")
    list-item(dt="Persistent Peer" :dd="persistentPeer")

  part(title='Network')
    list-item(dt="Network" :dd="fullNode.node_info.network")
    list-item(dt="Tendermint Version" :dd="fullNode.node_info.version")
    list-item(dt="Channels" :dd="fullNode.node_info.channels")

  // part(title='Profile')
    list-item(dt="Total Vote Power" :dd="fullNode.fullNode ? fullNode.fullNode.voting_power : 0 + ' ATOM'" to="/vote-power")
    //list-item(dt="Solo Vote Power" dd="1M ATOM (19%)")
    //list-item(dt="Delg. Vote Power" dd="3.2M ATOM (81%)")
    //list-item(dt="Vote History" dd="37 Votes" to="/votes")
    //list-item(dt="Proposals" dd="13" to="/proposals")
    //list-item(dt="Slashes" dd="6" to="/slashes")

  //part(title='Staking')
    list-item(dt="Delegators" dd="" to="/delegators")
    list-item(dt="Earn Rate" dd="8.1K ATOM / day'")
    list-item(dt="Total Earnings" dd="301.8K ATOM")
</template>

<script>
import moment from "moment"
import { mapGetters } from "vuex"
import ListItem from "./NiListItem"
import ToolBar from "./NiToolBar"
import Page from "./NiPage"
import Part from "./NiPart"
import AnchorCopy from "./AnchorCopy"
export default {
  name: "page-fullNode",
  components: {
    AnchorCopy,
    ListItem,
    Page,
    Part,
    ToolBar
  },
  computed: {
    ...mapGetters(["nodes"]),
    fullNode() {
      if (this.nodes && this.nodes.length > 0) {
        return this.nodes.find(
          v =>
            this.urlsafeIp(v.node_info.listen_addr) ===
            this.$route.params.node + ":46656"
        )
      } else {
        return this.tmpFullNode
      }
    },
    persistentPeer() {
      return `${this.fullNode.node_info.id}@${
        this.fullNode.node_info.listen_addr
      }`
    }
  },
  data: () => ({
    tmpFullNode: {
      node_info: {
        moniker: "Loading...",
        pub_key: "todoreplacemewithfullNodepubkey"
      }
    }
  }),
  methods: {
    urlsafeIp(ip) {
      return ip.split(".").join("-")
    },
    getIp(fullNode) {
      return (
        fullNode.node_info.listen_addr &&
        fullNode.node_info.listen_addr.split(":")[0]
      )
    },
    readableDate(ms) {
      return moment(ms).format("YYYY-MM-DD h:mm:ss A")
    }
  },
  mounted() {
    // setInterval(console.log(this.fullNode), 1000)
  }
}
</script>
