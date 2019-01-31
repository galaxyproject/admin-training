Playbooks
=========

Unfortunately today's playbooks are not idempotent - they must be run once, then change values, etc. We'll be working on
a solution to this, but in the meantime, we have split them up in to multiple playbooks.

1. Run `playbook-certbot-setpN.yml` in numerical order.
2. After the final step, run the regular `playbook.yml`
