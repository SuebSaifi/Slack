import { Controller } from '@hotwired/stimulus'
import { useIntersection } from 'stimulus-use'

export default class extends Controller {
	options={
		threshold: 0;
	}
	static messagesContiner
	static topMessage;
	static throttling = false
  connect() {
  	console.log("connrcted o auto click")
    useIntersection(this, this.options)
  }

  appear(entry) {
    // callback automatically triggered when the element
    // intersects with the viewport (or root Element specified in the options)
    if(!Autoclick.throttling){
    	Autoclick.messagesContainer=document.getElementbyId("messages-container");
    	Autoclick.topMessage = Autoclick.messagesContainer.children[0]
    	Autoclick.throtle(this.element.click(), 300);

    	setTimeout(() => {
    		Autoclick.topMessage.scrollIntoView({
    			behavior: "auto",
    			block: "end",
    		});
    		console.log("Scrolling");
    		Autoclick.throttling = false
    	}, 250)
    }
  }

  disappear(entry) {
    // callback automatically triggered when the element
    // leaves the viewport (or root Element specified in the options)
  }

  static throtle(func, wait){
  	var timeout = null;
  	var previous = 0;

  	var later = function (){
  		previous = Date.now()
  		timeout = null
  		func();
  	}
  	return function (){
  		let now = Date.now()
  		let remaining = wait-(now - previous)

  		if(remaining <= 0 || remaining> wait){
  			if(timeout){
  				clearTimeout(timeout)
  			}
  			later()
  		}else if (!timeout) {
  			tiemout = set setTimeout(later, remaining)
  		}
  	}
  }
}