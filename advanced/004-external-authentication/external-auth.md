layout: true
class: inverse, middle, large

---
class: special
# External Authentication

slides by @martenson

.footnote[\#usegalaxy / @galaxyproject]

---
class: larger

## Please Interrupt!
Answer your questions we will.

---
# Auth Mechanisms supported

* Galaxy-specific login using e-mail address and password.
* OpenID authentication with Galaxy as a relying party.
* HTTP remote user provided by any front-end Web server.
* Galaxy authentication framework (LDAP, Kerberos).

---
# Galaxy account

* Stored in DB, passwords hashed and salted, using PBKDF2 (default).
  * Unique in both email and username.
  * Table `galaxy_user`.
  * Abstracted as `User` in `lib/galaxy/model/mapping.py`.
* Session cookie expires after 3 months.
  * Configurable with `session_duration`.
* Password reset uses 'visit-link' mechanism.
* `require_login` can be enabled to disable anonyms.

---
class: normal
# Authentication tweaks

In `galaxy.ini`:
* Activation
  * `user_activation_on` will prevent accounts from running jobs until they visit activation link.
  * `activation_grace_period` gives users some time before their jobs are ignored.
  * `inactivity_box_content` defines the message shown to inactive users.
* Expiration
  * `password_expiration_period` forces users to change password.
* Disposable domain blacklist
  * `blacklist_file` defines domains in XXX.YYY format that will be rejected as user emails.

???
https://github.com/martenson/disposable-email-domains

---
# OpenID

In `galaxy.ini`:
* Set `enable_openid = True`.
* Consumer cache in `openid_consumer_cache_path = database/openid_consumer_cache`
* Specify provider list in `openid_config_file = config/openid_conf.xml`.

---
# Default OpenID providers

```xml
<openid>
    <provider file="google.xml" />
    <provider file="yahoo.xml" />
    <provider file="aol.xml" />
    <provider file="launchpad.xml" />
    <provider file="genomespace.xml" />
</openid>
```

---
# Webserver

In `galaxy.ini`:
* `use_remote_user` will enable upstream authentication server to be used.
  * The server should set `REMOTE_USER` header.
  * Disables regular logins.

Dedicated Galaxy external auth [wiki page](https://wiki.galaxyproject.org/Admin/Config/ExternalUserAuth).

---
# General configuration

* Set `remote_user_maildomain` if server returns only usernames.
* Set shared `remote_user_secret` to disable impersonating with headers.

---
# Nginx

* Modules exist for Kerberos and LDAP.
* Most likely you'll need to recompile Nginx as none of them are included by default.

---
# example PAM stack

* You'll need to set up your system's PAM stack (very site-specific)
* If your 'shell accounts' authenticate the same way as your 'galaxy users' you can likely copy the PAM configuration.
* A PAM configuration that would be suitable for authentication with Kerberos (placed in /etc/pam.d/nginx) might look like:
```
auth    [success=1 default=ignore]    pam_krb5.so minimum_uid=1000 ignore_k5login
auth    requisite            pam_deny.so
auth    required            pam_permit.so
```

---
# example nginx.conf
```
location / {
        auth_pam "Basic Auth Realm Name";
        auth_pam_service_name "nginx";
        proxy_pass http://galaxy_app;
        proxy_set_header REMOTE_USER $remote_user;
        proxy_set_header X-Forwarded-Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-URL-SCHEME https;
}
```
Dedicated Galaxy with Nginx [wiki page](https://wiki.galaxyproject.org/Admin/Config/NginxExternalUserAuth).

.footnote[The value of auth_pam_service_name must match the filename of the pam configuration you created in /etc/pam.d/.]

---
# Apache

The authentication module (basic authentication, mod_auth_kerb, mod_authn_ldap, mod_auth_cas, Cosign, etc.) is responsible for providing a username, which we will pass through the proxy to Galaxy as `$REMOTE_USER`.

In addition to the modules above, mod_headers must be enabled in the Apache config, for some types of authentication.


Dedicated Galaxy with Apache [wiki page](https://wiki.galaxyproject.org/Admin/Config/ApacheExternalUserAuth).

---
# Galaxy (Internal) Pluggable Authentication Modules

Authenticate to external services directly in Galaxy

Available [provider modules](https://github.com/galaxyproject/galaxy/tree/dev/lib/galaxy/auth/providers) for:
- Local Galay DB (default)
- LDAP/Active Directory
- [System (Linux) PAM](http://www.linux-pam.org/)

---
# Galaxy PAM Exercise

[PAM Authentication in Galaxy - Exercise](https://github.com/martenson/dagobah-training/blob/master/advanced/004-external-authentication/ex1-pam-auth.md)
