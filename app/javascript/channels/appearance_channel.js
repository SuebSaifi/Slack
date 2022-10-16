import consumer from "channels/consumer"
  let resetfunc;
  let timer=0;

consumer.subscriptions.create("AppearanceChannel", {

  initialized(){},
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected");
    resetfunc= ()=> this.resetTimer(this.uninstall)
    this.install()
    window.addEventListener("turbo:load", () => this.resetTimer())
  },
  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("Disconnected");
    this.uninstall();
  },
  rejected(){
    console.log("Rejected")
    this.uninstall()
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    
  },
  online(){
    console.log("Online")
    this.perform("online")
  },
  offline(){
    console.log("offline")
    this.perform("offline")
  },
  away(){
    console.log("away")
    this.perform("away")
  },
  uninstall(){
    const shouldRun = document.getElementById("appearance_channel")
    if (!shouldRun) {
      clearTimeout(timer)
      this.perform("offline")
    }
  },
  install(){
    console.log("install")
    window.removeEventListener("load", resetfunc);
    window.removeEventListener("DOMContentLoaded", resetfunc);
    window.removeEventListener("click", resetfunc);
    window.removeEventListener("keydown", resetfunc);

    window.addEventListener("load", resetfunc);
    window.addEventListener("DOMContentLoaded", resetfunc);
    window.addEventListener("click", resetfunc);
    window.addEventListener("keydown", resetfunc);
    this.resetTimer();
  },
  resetTimer(){
    this.uninstall();
    const shouldRun = document.getElementById("appearance_channel")
    if (!!shouldRun) {
      this.online
      clearTimeout(timer)
      const timeSeconds = 5
      const miliseconds = 1000
      const timeInMiliseconds = timeSeconds * miliseconds

      timer = setTimeout(this.away.bind(this), timeInMiliseconds)
    }
  }
});
