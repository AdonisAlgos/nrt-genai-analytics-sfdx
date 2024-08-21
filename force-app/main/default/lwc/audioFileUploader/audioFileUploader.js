import { LightningElement, track } from 'lwc';
import createConference from '@salesforce/apex/AudioFileUploader.createConference';
import sendDataToPythonAnywhere from '@salesforce/apex/PythonAnywhereIntegration.sendDataToPythonAnywhere';

export default class ConferenceAudioUpload extends LightningElement {
    @track conferenceTitle = '';
    @track conferenceId = '';
    @track mediaId = '';
    @track mediaContentId = '';
    @track isUploaded = false;
    @track isCreating = false;
    @track isFileUploadDisabled = true; // Initially disable file upload

    handleTitleChange(event) {
        this.conferenceTitle = event.target.value;
        // Enable file upload if conference title is set
        this.isFileUploadDisabled = !this.conferenceTitle;
    }

    async handleUploadFinished(event) {
        const uploadedFiles = event.detail.files;
        if (uploadedFiles.length > 0) {
            const documentId = uploadedFiles[0].documentId;
            this.isCreating = true;

            try {
                // Step 1: Create the conference and media objects
                const result = await createConference({ title: this.conferenceTitle, fileId: documentId });
                this.conferenceId = result[0];
                this.mediaId = result[1];
                this.mediaContentId = result[2];
                this.isUploaded = true;
                this.isCreating = false;

                console.log('Conference created successfully with ID:', this.conferenceId);
                console.log('Media created successfully with ID:', this.mediaId);

                
            } catch (error) {
                console.error('Error creating conference and media:', error);
                this.isCreating = false;
                return;
            }

            try {
                // Step 2: Send data to PythonAnywhere
                await sendDataToPythonAnywhere({
                    fileUrl: '/sfc/servlet.shepherd/document/download/' + this.mediaContentId,
                    conferenceId: this.conferenceId
                });

                console.log('Data sent to PythonAnywhere successfully');
            } catch (error) {
                console.error('Error sending data to PythonAnywhere:', error);
                this.isCreating = false;
            }
        }
    }
}
