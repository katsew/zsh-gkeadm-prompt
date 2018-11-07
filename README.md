# zsh-gkeadm-prompt

zsh prompt layout for GKE Administrators.

## Installation

git clone this repo to certain directory.  
sourcing `/path/to/_prompt.zsh` on your .zshrc.

## Features

Change PROMPT format to `[$project/$cluster_name] ($namespace)`.  

If gcp project set by `gcloud config set project` is different from currently set on kubectl config,   
prompt become red, otherwise green.

## Demo

![Demo](https://github.com/katsew/zsh-gkeadm-prompt/blob/master/prompt.gif)
      
## License

MIT
