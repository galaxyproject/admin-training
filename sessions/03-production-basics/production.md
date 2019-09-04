layout: true
class: inverse, middle, large

---
class: special
#Gearing towards production

slides by @natefoo @dblankenberg @abdulrahmanazab @martenson

.footnote[\#usegalaxy / @galaxyproject]

---
# Authentication Options

* `require_login: false` Force everyone to log in (disable anonymous access).
* `allow_user_creation: true` Allow unregistered users to create new accounts (otherwise, they will have to be created by an admin).
* `allow_user_deletion: false` Allow administrators to delete accounts.
* `allow_user_impersonation: false` Allow administrators to log in as other users (useful for debugging)

.footnote[modifying the `galaxy.yml`]

---
# Customizing your "Brand"

* `brand` appends "/{brand}" to the "Galaxy" text in the masthead.
* `logo_url` sets the URL linked by the "Galaxy/brand" text.
* `wiki_url` sets the URL linked by the "Wiki" link in the "Help" menu.
* `support_url` sets the URL linked by the "Support" link in the "Help" menu.
* `citation_url` sets the URL linked by the "How to Cite Galaxy" link in the "Help" menu.
* `search_url` sets the URL linked by the "Search" link in the "Help" menu.
* `mailing_lists_url` sets the URL linked by the "Mailing Lists" link in the "Help" menu.
* `screencasts_url` sets the URL linked by the "Videos" link in the "Help" menu.
* `terms_url` sets the URL linked by the "Terms and Conditions".

.footnote[modifying the `galaxy.yml`]

---
# Adding a Notice box


* `message_box_visible: true`
* `message_box_content: Downtime scheduled Sunday at Noon to one.`
* `message_box_class: warning`

.footnote[modifying the `galaxy.yml`]

---
# galaxy.yml full options

a.k.a. Everything You Always Wanted to Know About `galaxy.yml`
* [config schema](https://github.com/galaxyproject/galaxy/blob/dev/lib/galaxy/webapps/galaxy/config_schema.ym)
* [config sample](https://raw.githubusercontent.com/galaxyproject/galaxy/dev/config/galaxy.yml.sample)

---
# Exercise: Changing the brand and adding a message box

* Edit galaxy.yml again (see previous slide set for how)
* Add the following entries to galaxy.yml
  ![cm-change-messagebox](images/cm-change-messagebox.png)

---
# Configuring SMTP

* SMTP server
  * `smtp_server` host:port of SMTP server to use. Uses STARTTLS, but will fallback.
  * `smtp_username` username for SMTP server
  * `smtp_password` password for SMTP server. STARTTLS recommended on SMTP server.
  * `smtp_ssl` if SMTP server requires SSL from connection start, set to true.
* Addresses
  * `error_email_to` address to send user error reports to.
  * `email_from` return address used in automatic user notifications. (`<galaxy-no-reply@HOSTNAME>`)
  * `mailing_join_addr` mailing list to subscribe users to during registration.

.footnote[modifying the `galaxy.yml`]

---
# Exercise: Configuring SMTP for Bug Reports

Install a mail tranfer agent (MTA):
* Here is a tutorial on how to [install Postfix MTA](https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postfix-as-a-send-only-smtp-server-on-ubuntu-14-04)

* set `smtp_server: localhost:25`
* set `error_email_to: you@email.tld` (use your email)
* Run a Galaxy tool the produces an error
* attempt to send a bug report

.footnote[modifying the `galaxy.yml`]
