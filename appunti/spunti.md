**servizi da implementare**
rds multi-az Your ability for your service to ensure there is no
no single point of failure. Preventing the chance of failure
Fail-overs is when you have
a plan to shift traffic to a
redundant system in case
the primary system fails
Primary 
Failover
Sync
RDS Multi-AZ is when you run a
duplicate standby database in another
Availability Zone in case your primary
database fails.
Secondary
Your ability to automatically increase or decrease your capacity based on
the current demand of traffic, memory and computing power
Auto Scaling Groups (ASG) is an AWS feature that
will automatically add or remove servers based on
scaling rules you define based on metrics
Horizonal Scaling
Scaling Out — Add more servers of the same size
Scaling In — Removing underutilized servers of the same size
Your ability to
from a disaster and to prevent the loss of data
recover
Solutions that recover from a disaster is known as Disaster Recovery (DR)
Do you have a backup?
How fast can you restore that backup?
Does your backup still work?
How do you ensure current live data is not corrupt?
CloudEndure Disaster Recovery continuously replicates your machines into a low-cost
staging area in your target AWS account and preferred Region enabling fast and reliable
recovery in case of I
Bosmess Con Inol y P an BCP
Cheat sheets, Practice Exams and Flash cards www.exampro.co/clf-c01
A business continuity plan (BCP) is a document that outlines how a business will
continue operating during an unplanned disruption in services
Recovery Point Objective (RPO)
the maximum acceptable amount of
data loss after an unplanned data-loss
incident, expressed as an amount of
time
How much data are you willing to lose?
Recovery Point (RPO)
Data Loss
Disaster
Recovery Time Objective (RTO)
the maximum amount of downtime your
business can tolerate without incurring a
significant financial loss
Recovery Time (RTO)
Downtime