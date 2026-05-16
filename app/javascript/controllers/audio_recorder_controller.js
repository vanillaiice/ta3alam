import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["recordButton", "stopButton", "audioPlayback", "fileInput", "status"]
  static values = {
    recordingText: { type: String, default: "Recording..." },
    attachedText: { type: String, default: "Recording attached." },
    errorText: { type: String, default: "Microphone access denied or not available." }
  }

  connect() {
    this.mediaRecorder = null
    this.audioChunks = []
  }

  async start(event) {
    event.preventDefault()
    
    try {
      const stream = await navigator.mediaDevices.getUserMedia({ audio: true })
      this.mediaRecorder = new MediaRecorder(stream)
      this.audioChunks = []

      this.mediaRecorder.addEventListener("dataavailable", event => {
        this.audioChunks.push(event.data)
      })

      this.mediaRecorder.addEventListener("stop", () => {
        const audioBlob = new Blob(this.audioChunks, { type: 'audio/webm' })
        const audioUrl = URL.createObjectURL(audioBlob)
        this.audioPlaybackTarget.src = audioUrl
        this.audioPlaybackTarget.classList.remove('hidden')
        
        // Create a File object and attach it to the file input
        const file = new File([audioBlob], "recorded_audio.webm", { type: 'audio/webm', lastModified: new Date().getTime() })
        const container = new DataTransfer()
        container.items.add(file)
        this.fileInputTarget.files = container.files
        
        // Stop all tracks to release the microphone
        stream.getTracks().forEach(track => track.stop())
      })

      this.mediaRecorder.start()
      
      this.recordButtonTarget.classList.add('hidden')
      this.stopButtonTarget.classList.remove('hidden')
      this.statusTarget.textContent = this.recordingTextValue
      this.statusTarget.classList.add('text-error', 'animate-pulse')
      this.statusTarget.classList.remove('text-success')
    } catch (err) {
      console.error("Error accessing microphone:", err)
      this.statusTarget.textContent = this.errorTextValue
      this.statusTarget.classList.add('text-error')
    }
  }

  stop(event) {
    event.preventDefault()
    
    if (this.mediaRecorder && this.mediaRecorder.state !== 'inactive') {
      this.mediaRecorder.stop()
    }
    
    this.recordButtonTarget.classList.remove('hidden')
    this.stopButtonTarget.classList.add('hidden')
    this.statusTarget.textContent = this.attachedTextValue
    this.statusTarget.classList.remove('text-error', 'animate-pulse')
    this.statusTarget.classList.add('text-success')
  }
}
