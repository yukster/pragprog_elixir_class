import { Socket } from "phoenix"

export default class HangmanSocket {
  constructor(tally) {
    this.tally = tally
    this.socket = new Socket("/socket", {})
    this.socket.connect()
  }

  connect_to_hangman() {
    this.setup_channel()
    this.channel
      .join()
      .receive("ok", resp => {
        console.log("Socket connected")
        this.fetch_tally()
      })
      .receive("error", resp => {
        alert("Socket error; see console")
        console.error("Socket error: %o", resp)
        throw (resp)
      })
  }

  setup_channel() {
    this.channel = this.socket.channel("hangman:game", {})
    this.channel.on("tally", resp => {
      this.copy_tally(resp.data)
    })
    this.channel.on("error", resp => {
      alert("Channel error; see console")
      console.error("Channel error: %o", resp)
    })
  }

  fetch_tally() {
    // use this to test fall-through, unknown message type
    // this.channel.push("wibble", {})
    this.channel.push("tally", {})
  }

  make_move(guess) {
    this.channel.push("make_move", guess)
  }

  new_game() {
    this.channel.push("new_game", {})
  }

  copy_tally(from) {
    for (let k in from) {
      this.tally[k] = from[k]
    }
  }
}
