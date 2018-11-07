# zsh-gkeadm-prompt

zsh prompt layout for GKE Administrators.

## Features

Change PROMPT format to `[$project/$cluster_name] ($namespace)`.  

If gcp project set by `gcloud config set project` is different from currently set on kubectl config,   
prompt become red, otherwise green.
