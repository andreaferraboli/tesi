# Rischi di Sicurezza Postman

1. **Credenziali Esposte**:  
    - Rischio di **Credential Stuffing** e **Brute Force Attack**.

2. **Mancanza di Autenticazione a Due Fattori (2FA)**:  
    - Rischio di **Account Takeover**.

3. **Uso di HTTP invece di HTTPS**:  
    - Rischio di **Man-in-the-Middle (MITM)** e **Eavesdropping**.

4. **Gestione Insicura delle Variabili di Ambiente**:  
    - Rischio di **Environment Variable Injection**.

5. **Documentazione Pubblica**:  
    - Rischio di **Information Disclosure**.

6. **Mancanza di Controlli di Accesso**:  
    - Rischio di **Unauthorized Access**.

7. **Paginazione non Sicura**:  
    - Rischio di **Data Scraping**.

8. **Mancanza di Validazione degli Input**:  
    - Rischio di **SQL Injection** e **Cross-Site Scripting (XSS)**.

9. **Uso di Postman per Operazioni Sensibili**:  
    - Rischio di **Token Theft**.

10. **Mancanza di Monitoraggio e Logging**:  
     - Rischio di **Stealth Attacks**.

    ## Soluzioni per Mitigare i Rischi di Sicurezza

    1. **Protezione delle Credenziali**:  
        - Utilizzare un **password manager** o **vault** per memorizzare le credenziali.  
        - Evitare di esporre credenziali in documenti o codice.  

    2. **Autenticazione a Due Fattori (2FA)**:  
        - Implementare **2FA** per aggiungere un ulteriore livello di sicurezza all'accesso.  

    3. **Utilizzo di HTTPS**:  
        - Configurare il server per utilizzare **HTTPS** e ottenere un certificato SSL/TLS valido.  

    4. **Gestione Sicura delle Variabili di Ambiente**:  
        - Utilizzare strumenti come **AWS Secrets Manager**, **Azure Key Vault** o **HashiCorp Vault**.  
        - Limitare l'accesso alle variabili di ambiente solo agli utenti autorizzati.  

    5. **Limitare l'Accesso alla Documentazione**:  
        - Rendere la documentazione accessibile solo tramite **autenticazione** o **VPN**.  
        - Utilizzare strumenti di controllo degli accessi come **IAM** (Identity and Access Management).  

    6. **Controlli di Accesso Robusti**:  
        - Implementare **RBAC** (Role-Based Access Control) per limitare l'accesso agli endpoint sensibili.  
        - Verificare i permessi degli utenti prima di ogni operazione.  

    7. **Paginazione Sicura**:  
        - Limitare il numero massimo di elementi restituiti per pagina.  
        - Implementare controlli per evitare l'accesso a pagine non autorizzate.  

    8. **Validazione degli Input**:  
        - Utilizzare librerie di validazione per prevenire **SQL Injection** e **XSS**.  
        - Sanitizzare tutti gli input prima di elaborarli.  

    9. **Uso Sicuro di Postman**:  
        - Evitare di memorizzare token o credenziali in Postman.  
        - Utilizzare **Postman Environments** con variabili crittografate.  

    10. **Monitoraggio e Logging**:  
         - Implementare un sistema di **logging centralizzato** (es. ELK Stack, Splunk).  
         - Configurare **allarmi** per attività sospette o tentativi di accesso non autorizzati.  

    11. **Crittografia dei Dati**:  
         - Crittografare i dati sensibili sia **in transito** (HTTPS) che **a riposo** (AES-256).  

    12. **Aggiornamenti e Patch**:  
         - Mantenere aggiornati tutti i software, librerie e framework utilizzati.  
         - Applicare patch di sicurezza tempestivamente.  

    13. **Penetration Testing**:  
         - Eseguire test di sicurezza regolari per identificare e correggere vulnerabilità.  

    14. **Formazione del Personale**:  
         - Formare gli sviluppatori e gli utenti sulle best practice di sicurezza.  
         - Promuovere la consapevolezza sui rischi di phishing e social engineering.  
### **Timeline proposta**

- **Fase 1: Ricerca e Definizione del Framework**  
  Dal 3 febbraio al 23 febbraio (3 settimane)  
  - Studio della letteratura esistente su cybersecurity nel settore fintech.  
  - Definizione delle research questions e struttura della tesi.  
  - **Materiale da inviare:** Bozza dell'indice e introduzione.  

- **Fase 2: Analisi della Sicurezza a Livello di Codice**  
  Dal 24 febbraio al 17 marzo (3 settimane)  
  - Approfondimento delle pratiche di Secure Coding e SecDevOps.
  - attacco e difesa reverse engineering
  - traffico http e non HTTPS(link gimme5)
  - cve flutter
    - Hardcoded API Keys:
OneSignal and Mixpanel tokens are exposed in Constants
Recommendation: Move to environment variables or secure storage
Insecure Firebase Configuration:
No validation of Firebase initialization
Recommendation: Add initialization checks and fallback behavior
Insufficient Error Handling:
Critical error handlers are commented out
Recommendation: Implement proper error boundaries and logging
Debug Information Exposure:
Debug logging enabled in production
Recommendation: Remove debug logging from production builds
Insecure Data Storage:
SharedPreferences used without encryption
Recommendation: Use encrypted storage for sensitive data
Lack of Analytics Opt-out:
No way for users to disable analytics tracking
Recommendation: Add privacy controls and opt-out mechanism
  - Analisi di strumenti per l'analisi statica e dinamica del codice.  
  - **Materiale da inviare:** Capitolo su Secure Coding e SecDevOps.  

- **Fase 3: Sicurezza dell'Infrastruttura**  
  Dal 18 marzo al 7 aprile (3 settimane)  
  - Studio delle migliori pratiche per la progettazione di un'infrastruttura sicura, per ora analisi interfacce API Postman e analisi sicurezza Wordpress.  
  - Analisi di strumenti per la gestione dei dati e il monitoraggio.  
  - **Materiale da inviare:** Capitolo sulla sicurezza dell'infrastruttura.  

- **Fase 4: Ingegneria Sociale e Sensibilizzazione**  
  Dal 8 aprile al 28 aprile (3 settimane)  
  - Ricerca sulle tecniche di ingegneria sociale e metodologie di simulazione.  
  - Proposta di un piano di sensibilizzazione per i dipendenti.  
  - **Materiale da inviare:** Capitolo su ingegneria sociale e awareness.  

- **Fase 5: Conclusioni e Revisione Finale**  
  Dal 13 maggio al 2 giugno (3 settimane)  
  - Sintesi dei risultati e riflessioni conclusive.  
  - Revisione finale della tesi.  
  - **Materiale da inviare:** Bozza completa della tesi per feedback finale.  
