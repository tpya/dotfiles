# ---- Powerlevel10k instant prompt ----
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---- Oh My Zsh ----
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Обновления Oh My Zsh
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14
zstyle ':omz:update' verbose minimal

# Показывать индикатор, если автодополнение долго думает
COMPLETION_WAITING_DOTS=true

# ---- Plugins ----
plugins=(
  git
  z
  colored-man-pages
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# ---- History ----
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt HIST_EXPIRE_DUPS_FIRST

# Если хочешь мгновенно шарить историю между вкладками,
# можно заменить INC_APPEND_HISTORY на SHARE_HISTORY,
# но не включай их одновременно.
# setopt SHARE_HISTORY

# ---- Key bindings ----
bindkey -e

# Удобная навигация по словам: Ctrl + Left / Ctrl + Right
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Ctrl+Backspace и Ctrl+Delete — удаление слова
bindkey '^[[3;5~' kill-word        # Ctrl+Delete
bindkey '^H' backward-kill-word    # Ctrl+Backspace (часто шлёт ^H)
bindkey '^[[1;5F' end-of-line      # на всякий случай, если переназначишь Home/End

# Поиск по истории стрелками по префиксу:
# набрал "git", нажал Up — ходишь только по git-командам
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# ---- fzf, если установлен ----
# Ctrl-R: fuzzy-поиск по истории
# Ctrl-T: вставить файл/папку
# Alt-C: перейти в папку
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
fi

# ---- zoxide, если установлен ----
# Более умный cd. Пример: zi project
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ---- aliases ----
source "$HOME/dotfiles/.aliases"

# ---- PATH: добавляй свои пути здесь ----
export PATH="$HOME/.local/bin:$PATH"

# ---- Powerlevel10k config ----
[[ ! -f "$HOME/dotfiles/.p10k.zsh" ]] || source "$HOME/dotfiles/.p10k.zsh"
