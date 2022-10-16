import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	connect(){}

	preview() {
		this.clearPreviews()
		for(let i=0; i < this.targets.element.files.length; i++){
			let file = this.targets.element.files[i];
			const reader = new FileReader();
			this.createAdnDisplayFilePreviewElements(file, reader);
		}
		this.toggleVisibility();
	}

	toggleVisibility() {
		let preview = document.getElementById("attachment-previews")
		preview.classList.toggle("d-none")
	}

	createAdnDisplayFilePreviewElements(file, reader){
		reader.onload = () => {
			let element = this.constructPreviews(file, reader);
			element.src = reader.result
			element.setAttribute("href", reader.result)
			element.setAttribute("target", "_blank")
			element.classList.add("attachment-preview")
			document.getElementById('attachment-previews').appendChild(element)
		}
		reader.readAsDataURL(file)
	}

	constructPreviews(file, reader) {
		let element;
		let cancelFunction = (e) => this.removePreview(e);
		switch(file.type) {
			case "image/jpeg":
			case "image/png":
			case "image/gif":
				element = this.createImageElement(cancelFunction, reader)
				break;
			case "audio/mp3":
			case "image/mpeg":
			case "image/wav":
				element = this.createAudioElement(cancelFunction)
				break;
			case "video/mp4":
			case "video/quicktime":
				element = this.createVideoElement(cancelFunction)
				break;
			default:
				element = this.createDefaultElement(cancelFunction)
		}
		element.dataset.filename = file.name
		return element
	}

	createImageElement(cancelFunction, reader) {
		let cancelUploadButton, element;
		const image = document.createElement("img");
		image.setAttribute("style", "background-image: url("+ reader.result+ ")")
		image.classList.add("preview-image")
		element = document.createElement("div")
		element.classList.add("attachment-image-container", "file-removal")
		element.appendChild(image)
		cancelUploadButton = document.createElement("i")
		cancelUploadButton.classList.add("bi","bi-x-circle-fill", "cancel-upload-button")
		cancelUploadButton.onclick = cancelFunction;
		element.appendChild(cancelUploadButton);
		return element;
	}

	createAudioElement(cancelFunction, reader) {
		let cancelUploadButton, element;
		element = document.createElement("i");
		element.classList.add("bi","bi-file-earmark-music-fill", "audio-preview-icon", "file-removal")
		cancelUploadButton = document.createElement("i")
		cancelUploadButton.classList.add("bi","bi-x-circle-fill", "cancel-upload-button")
		cancelUploadButton.onclick = cancelFunction;
		element.appendChild(cancelUploadButton);
		return element;
	}

	createVideoElement(cancelFunction, reader) {
		let cancelUploadButton, element;
		element = document.createElement("i");
		element.classList.add("bi","bi-file-earmark-play-fill", "video-preview-icon", "file-removal")
		cancelUploadButton = document.createElement("i")
		cancelUploadButton.classList.add("bi","bi-x-circle-fill", "cancel-upload-button")
		cancelUploadButton.onclick = cancelFunction;
		element.appendChild(cancelUploadButton);
		return element;
	}

	createDefaultElement(cancelFunction, reader) {
		let cancelUploadButton, element;
		element = document.createElement("i");
		element.classList.add("bi","bi-file-check-file", "file-preview-icon", "file-removal")
		cancelUploadButton = document.createElement("i")
		cancelUploadButton.classList.add("bi","bi-x-circle-fill", "cancel-upload-button")
		cancelUploadButton.onclick = cancelFunction;
		element.appendChild(cancelUploadButton);
		return element;
	}

	removePreview(event){
		const target = event.target.parentNode.closest(".attachment-preview")
		const dataTransfer = new DataTransfer()
		let fileInput = document.getElementById("message_attachments")
		let files = fileInput.files;
		let filesArray = Array.from(files)

		filesArray = filesArray.filter((file) => {
			let filename = target.dataset.flename;
			return file.name !== filename
		})

		target.parentNode.removeChild(target);
		fileArray.forEach((file)=> dataTransfer.items.add(file))
		fileInput.files = dataTransfer.files;
	}


	clearPreviews(){
		document.getElementById('attachment-previews').innerHTML="";
		let preview = document.getElementById("attachment-previews")
		preview.classList.add("d-none")
	}
}