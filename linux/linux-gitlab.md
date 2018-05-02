## /etc/gitlab.rb

```
external_url 'http://192.168.1.236'

gitlab_rails['gitlab_email_from'] = 'danielluo@acingame.com'

gitlab_rails['smtp_enable'] = true

gitlab_rails['smtp_address'] = "smtp.mxichina.com"
gitlab_rails['smtp_prot'] = 26
gitlab_rails['smtp_user_name'] = "danielluo@acingame.com"
gitlab_rails['smtp_password'] = "lz@xxxxxx"
gitlab_rails['smtp_domain'] = "acingame.com"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_enable_starttls_auto'] = true
```
