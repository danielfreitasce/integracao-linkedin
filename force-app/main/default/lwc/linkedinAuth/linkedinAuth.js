import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getLinkedinAuthUrl from '@salesforce/apex/CalloutConfigService.getLinkedinAuthUrl';
import getLinkedinUserStatus from '@salesforce/apex/LinkedinUserConfigService.getLinkedinUserStatus';
import insertUrlState from '@salesforce/apex/LinkedinUserConfigService.insertUrlState';
import usrId from '@salesforce/user/Id';

export default class LinkedinAuth extends NavigationMixin(LightningElement) {
    
    url = '';
    state = '';
    userId = usrId; 
    
    isExpired  = false; 
    connectedCallback() {
        getLinkedinUserStatus({userId : this.userId}).
        then(result => {
           this.isExpired = result;
        })
        .catch(error =>{
            console.log(error);
        });
    }

    toggleClass()
    {
        const botaoAutorizar = this.template.querySelector('[data-id="botao-autorizar"]');
        const avisoAutorizacao = this.template.querySelector('[data-id="aviso-autorizacao"]'); 
        avisoAutorizacao.classList.toggle('slds-hide'); 
        botaoAutorizar.classList.toggle('slds-hide');
    }

    discordar() {
        // Navigate to a specific CustomTab.
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'home'
            },
        });
    }

    cancelar()
    {
        this.toggleClass();
    }

    concordar() {

        this.toggleClass();

        getLinkedinAuthUrl({userId: this.userId})
        .then(result =>{
            this.url = result[0];
            this.state = result[1];
        })
        .catch(error =>{
            console.log(error);
        });
    }

    insertState(){
        insertUrlState({
            state : this.state,
            userId : this.userId
        }).then(result =>{
            
        })
        .catch(error =>{
            console.log(error);
        });
    }
    //connectedCallback é o mesmo que a função init no aura: https://developer.salesforce.com/docs/component-library/documentation/en/lwc/migrate_initializers
}