import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class exten Controller {
	initialize(){
		this.resetScrollWithoutThreshold(messages);
	}
  connect() {
  	const messages = document.getElementById("messages");
  	messages.addEventListener("DOMNodeInserted",this.resetScroll)
  }
  disconnect() {
  	console.log("Disconnected")
  }

  resetScroll(){
  	const bottomOfScroll = message.scrollHeight - messages.clintHeight;
  	const uppreScrollThreshold = bottomOfScroll -500

  	if(messagesscrollTop >uppreScrollThreshold) {
  		this.resetScrollWithoutThreshold(messages);
  	}
  }
  resetScrollWithoutThreshold(messages){
  	messsages.scrollTop = messages.scrollHeight - messages.clintHeight
  }
}
