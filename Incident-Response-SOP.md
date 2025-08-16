# Incident Response SOP (P1/P2 Issues)

**Author:** Ashish (L2 Technical Support Engineer)  
**Purpose:** Standard operating procedure for handling high-priority incidents (P1/P2).

---

## 1. Incident Acknowledgment
- Acknowledge the alert/ticket within 5 minutes.  
- Confirm if the issue impacts production, multiple users, or client SLAs.  
- Assign incident severity (P1 or P2) as per guidelines.  

---

## 2. Initial Triage
- Gather logs using automation (`Collect-Logs.ps1`) or manual checks.  
- Verify current system health (CPU, memory, disk, services).  
- Check monitoring dashboards (Sumo Logic / Grafana) for anomalies.  
- Identify scope: single user, group, or full environment.  

---

## 3. Containment Actions
- If service is down, restart critical components where permitted.  
- Communicate to stakeholders about temporary mitigations.  
- Escalate to infra/app teams if deeper intervention is needed.  

---

## 4. Communication & Updates
- Update ticket every 30 minutes with current status.  
- For P1 issues, join bridge calls with stakeholders.  
- Maintain timeline notes for RCA.  

---

## 5. Escalation Path
- If resolution not found within SLA window, escalate to L3/DevOps.  
- Provide collected logs, error snapshots, and summary of actions taken.  

---

## 6. Post-Incident Activities
- Perform RCA (Root Cause Analysis) with relevant teams.  
- Document resolution steps in knowledge base.  
- Identify repetitive patterns → suggest automation or monitoring improvements.  

---

## References
- ITIL v4 guidelines
- Internal escalation matrix (redacted)  
- Tools: Sumo Logic, Grafana, ServiceNow, PowerShell
