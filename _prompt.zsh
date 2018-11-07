setopt prompt_subst
autoload -U add-zsh-hook
autoload -U colors; colors

function _zsh_gkeadm_prompt_precmd() {

    if [ -z "$ZSH_GKEADM_PROMPT_GKE_PRJ" ]; then
      ZSH_GKEADM_PROMPT_GKE_PRJ=`gcloud config get-value project 2>/dev/null`
    fi

    if [ -z "$ZSH_GKEADM_PROMPT_CTX" ]; then
      ZSH_GKEADM_PROMPT_CTX=`kubectl config current-context 2>/dev/null`
    fi

    if [ -z "$ZSH_GKEADM_PROMPT_NS" ]; then
      ZSH_GKEADM_PROMPT_NS=`kubectl config get-contexts 2>/dev/null | grep '*' | awk '{print $5}'` 
    fi

    kprj=`echo $ZSH_GKEADM_PROMPT_CTX | cut -f 2 -d '_'`
    kclu=`echo $ZSH_GKEADM_PROMPT_CTX | cut -f 4 -d '_'`

    ZSH_GKEADM_PROMPT_FORMAT="[${kprj}/${kclu}] (${ZSH_GKEADM_PROMPT_NS})"
    if [ "$kprj" = "$ZSH_GKEADM_PROMPT_GKE_PRJ" ]; then
      PROMPT='%{$fg[green]%}${ZSH_GKEADM_PROMPT_FORMAT}%{$reset_color%} '
    else
      PROMPT='%{$fg[red]%}${ZSH_GKEADM_PROMPT_FORMAT}%{$reset_color%} '
    fi

    return 0

}

function _zsh_gkeadm_prompt_preexec() {

    local cmd

    cmd=`echo $1 | cut -d ' ' -f 1`
    if [ "$cmd" = "gcloud" ]; then
        unset ZSH_GKEADM_PROMPT_GKE_PRJ
    fi
  
    if [ "$cmd" = "kubectl" ]; then
        unset ZSH_GKEADM_PROMPT_CTX
        unset ZSH_GKEADM_PROMPT_NS
    fi

    # unset env value if user execute related command.
    case "$cmd" in
        "gcloud" ) unset ZSH_GKEADM_PROMPT_GKE_PRJ;;
        "k" | "kns" | "c" | "ns" | "kubectl" ) unset ZSH_GKEADM_PROMPT_CTX && unset ZSH_GKEADM_PROMPT_NS;;
    esac
    return 0
}

add-zsh-hook precmd _zsh_gkeadm_prompt_precmd
add-zsh-hook preexec _zsh_gkeadm_prompt_preexec
