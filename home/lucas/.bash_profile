#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND'\n'};history -a;history -c;history -r"
