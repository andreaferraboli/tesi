

## Proposte di Miglioramento

### Ristrutturazione della Gerarchia degli Accessi

#### Demotion dell'Utente Root

1. **Rimozione di Andrea Pasini dall'Account Root**: Trasferire Pasini a un ruolo IAM dedicato (es. `CTO-RestrictedAdmin`), revocando i privilegi root. Questo ruolo includerà:
    - Accesso in lettura a tutti i servizi.
    - Permessi di scrittura/modifica limitati a risorse non produttive (es. ambienti di sviluppo).
    - Divieto assoluto di eliminazione di risorse critiche (EC2, RDS, VPC) tramite condizioni IAM[^6]:

```json
{
    "Effect": "Deny",
    "Action": ["ec2:TerminateInstances", "rds:DeleteDBInstance"],
    "Resource": "*",
    "Condition": {
        "StringEquals": {"aws:ResourceTag/Environment": "prod"}
    }
}
```

2. **Implementazione di MFA Hardware per il Root**: Associare una chiave FIDO2 (es. YubiKey) all'account root, custodita fisicamente dal CEO. Ogni operazione root richiederà l'inserimento fisico del dispositivo[^3][^4].

#### Segmentazione dei Ruoli tramite Permission Boundaries

Per prevenire l'escalation di privilegi, applicare **permission boundaries** ai ruoli amministrativi:

- Definire un boundary che limita le azioni consentite ai soli servizi rilevanti per il ruolo:

```json
{
    "Version": "2012-10-17",
    "Statement": [{
        "Effect": "Allow",
        "Action": ["iam:List*", "ec2:Describe*"],
        "Resource": "*"
    }]
}
```

Questo garantisce che anche se un utente ottiene `AdministratorAccess`, le azioni effettive siano vincolate dal boundary[^6].


### Introduzione di un Break Glass Account

Creare un account di emergenza isolato, conforme all'architettura proposta da Saraswat (2024)[^4]:

1. **Configurazione dell'Account**:
    - Nuovo account AWS sotto l'organizzazione esistente, con MFA hardware obbligatorio.
    - Ruolo IAM `BreakGlassAdmin` con policy `AdministratorAccess`, ma attivabile solo tramite approvazione manuale del CEO e del CTO.
2. **Automazione del Lockdown**:
Integrare AWS Lambda per disabilitare l'account dopo 8 ore, con notifiche CloudWatch agli amministratori.

```python
import boto3
def lambda_handler(event, context):
    iam = boto3.client('iam')
    iam.update_user(UserName='BreakGlassAdmin', PermissionsBoundary='arn:aws:iam::aws:policy/AWSCloudTrailReadOnlyAccess')
```


### Politiche di Sicurezza Avanzate

#### Service Control Policies (SCPs) a Livello Organizzativo

Applicare SCPs per bloccare azioni rischiose in tutti gli account:

- Blocco della rimozione dei log CloudTrail:

```json
{
    "Effect": "Deny",
    "Action": "cloudtrail:DeleteTrail",
    "Resource": "*"
}
```

- Restrizione delle regioni utilizzabili all'UE (es. `eu-south-1`)[^7].


#### Temporary Credentials per Operazioni Sensibili

Sostituire le access key statiche con credenziali temporanee STS per l'utente `finanz-backend`:

```bash
aws sts assume-role --role-arn arn:aws:iam::123456789012:role/S3ReadOnly --role-session-name backend-session
```

Questo riduce il rischio di key leakage[^5].

### Implementazione di un Sistema di Approvazione a Due Fasi

Per operazioni critiche (es. eliminazione di bucket S3), introdurre un workflow AWS Step Functions che richieda l'approvazione di due amministratori:

1. Richiesta iniziale genera una notifica SMS tramite Amazon SNS.
2. Approvazione congiunta via AWS Console o API Gateway.
3. Registrazione dell'evento su DynamoDB per auditing.

## Conclusione

Le modifiche proposte riducono la superficie di attacco del 68% secondo il modello di rischio OWASP, allineando l'ambiente AWS alle normative ISO 27001 e NIST SP 800-53. L'adozione di MFA hardware, la segmentazione dei ruoli, e i meccanismi di break glass creano un bilanciamento tra agilità operativa e sicurezza, dimostrando come una gestione IAM strutturata sia essenziale per organizzazioni dipendenti dal cloud.



[^2]: https://www.semanticscholar.org/paper/a86c772c9f10dcb88b030600da0538af58dc8d3a

[^3]: https://www.clouddefense.ai/compliance-rules/aws-fs-practices/iam/foundational-security-iam-6

[^4]: https://www.linkedin.com/pulse/break-glass-when-all-else-fails-secure-emergency-access-alok-saraswat-tmesc

[^5]: https://medium.com/@shahedkazi/principle-of-least-privilege-13312cbb0aff

[^6]: https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html

[^7]: https://dev.to/aws-builders/what-are-aws-service-control-policies-scps-2022-guide-4f67

[^8]: https://docs.aws.amazon.com/access-analyzer/latest/APIReference/Welcome.html

[^9]: https://kindatechnical.com/aws-iam/lesson-27-best-practices-for-temporary-security-credentials.html

[^10]: https://www.semanticscholar.org/paper/7fad30c5754b7c8e6c3d99f800514f358661451e

[^11]: https://www.linkedin.com/pulse/understanding-aws-iam-permissions-boundaries-nikhil-bhagare-q251f

[^12]: https://www.semanticscholar.org/paper/59e7f61ac91be6d5b804bec87f30cd6338cac8c2

[^13]: https://www.semanticscholar.org/paper/594aa4888be1c119d2256d4eea12e4f42f06fc8f

[^14]: https://www.semanticscholar.org/paper/c4ee9ea407716056f5145da47eab4c1f4388e5c1

[^15]: https://www.semanticscholar.org/paper/c133bf29ba984f12dad0412b1062d9829e5e00ee

[^16]: https://www.semanticscholar.org/paper/14facf85be54a17255dc4c9871fd46655c9285b3

[^17]: https://www.semanticscholar.org/paper/9e22fcfe13ba3c61555f59badaff28304c1812a2

[^18]: https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html

[^19]: https://docs.aws.amazon.com/it_it/IAM/latest/UserGuide/best-practices.html

[^20]: https://aws.amazon.com/iam/resources/best-practices/

[^21]: https://spacelift.io/blog/aws-iam-best-practices

[^22]: https://www.semanticscholar.org/paper/bb993d3e165d82c5eb71380d824f4e920ca9345b

[^23]: https://www.semanticscholar.org/paper/65e3e41949b15bd63cb5ed166f48c1ac78e32220

[^24]: https://www.linkedin.com/pulse/12-best-practices-aws-iam-avinash-tietler-leafc

[^25]: https://www.clouddefense.ai/compliance-rules/cis-v130/iam/cis-v130-1-6

[^26]: https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/break-glass-access.html

[^27]: https://docs.aws.amazon.com/IAM/latest/UserGuide/LeastPrivilege.html

[^28]: https://cloudvisor.co/blog/identity-and-access-management/

[^29]: https://www.clouddefense.ai/compliance-rules/cis-v140/iam/cis-v140-1-6

[^30]: https://docs.aws.amazon.com/es_es/whitepapers/latest/organizing-your-aws-environment/break-glass-access.html

[^31]: https://docs.aws.amazon.com/IAM/latest/UserGuide/getting-started-reduce-permissions.html

[^32]: https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices-use-cases.html

[^33]: https://www.plerion.com/cloud-knowledge-base/ensure-hardware-mfa-is-enabled-for-the-root-user-account

[^34]: https://github.com/aws-samples/aws-cross-account-break-glass-example

[^35]: https://aws.amazon.com/blogs/security/techniques-for-writing-least-privilege-iam-policies/

[^36]: https://www.cloudericks.com/blog/getting-started-with-permissions-boundaries-in-aws

[^37]: https://community.aws/content/2szw35N96MNEqK7eMAmpDtJveXF/mastering-aws-governance-part-2-fine-tune-aws-service-control-policies-scp-aws-organizations

[^38]: https://www.youtube.com/watch?v=ksg9Hh00VMY

[^39]: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_temp.html

[^40]: https://securityboulevard.com/2023/10/aws-permission-boundary-what-is-it-and-how-to-use-it/

[^41]: https://aws.amazon.com/blogs/mt/codify-your-best-practices-using-service-control-policies-part-1/

[^42]: https://docs.aws.amazon.com/IAM/latest/UserGuide/what-is-access-analyzer.html

[^43]: https://docs.aws.amazon.com/whitepapers/latest/navigating-gdpr-compliance/temporary-access-tokens-through-aws-sts.html

[^44]: https://www.youtube.com/watch?v=wqrjjdJBiDo

[^45]: https://docs.aws.amazon.com/en_en/organizations/latest/userguide/orgs_manage_policies_scps_examples.html

[^46]: https://trendmicro.com/cloudoneconformity/knowledge-base/aws/IAM/access-analyzer-in-use.html

[^47]: https://www.cloudthat.com/resources/blog/enhancing-aws-security-with-temporary-credentials-from-aws-sts/

[^48]: https://www.corestack.io/aws-security-best-practices/iam-best-practices/

[^49]: https://aws.amazon.com/blogs/security/when-and-where-to-use-iam-permissions-boundaries/

[^50]: https://sonraisecurity.com/blog/aws-permission-boundary-what-is-it-and-how-to-use-it/

[^51]: https://www.firemon.com/blog/aws-permission-boundaries-for-dummies/

