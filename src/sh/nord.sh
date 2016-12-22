#!/usr/bin/env bash
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# title      Nord Guake                                    +
# project    nord-guake                                    +
# repository https://github.com/arcticicestudio/nord-guake +
# author     Arctic Ice Studio                             +
# email      development@arcticicestudio.com               +
# copyright  Copyright (C) 2016                            +
# ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
set -e

_ct="\e[0;37m"
_ctb_error="\e[1;31m"
_ctb_success="\e[1;32m"
_ctb="\e[1;37m"
_c_reset="\e[0m"

NORD_GUAKE_VERSION=

__cleanup() {
  trap '' SIGINT SIGTERM
  unset -v _ct_error _ct _ctb_error _ctb_success _ctb _c_reset
  unset -v GCONFTOOL2 NORD_GUAKE_VERSION
  unset -f __cleanup __log_error __log_success __log_info
}

__log_error() {
  printf "${_ctb_error}[ERROR] ${_ct}$1${_c_reset}\n"
}

__log_info() {
  printf "${_ctb}[INFO] ${_ct}$1${_c_reset}\n"
}

__log_success() {
  printf "${_ctb_success}[OK] ${_ct}$1${_c_reset}\n"
}

trap "printf '${_ctb_error}User aborted.${_c_reset}\n' && exit 1" SIGINT SIGTERM

[[ -z "$GCONFTOOL2" ]] && GCONFTOOL2=gconftool-2

if which "$GCONFTOOL2" > /dev/null 2>&1; then
  $GCONFTOOL2 -s -t string /apps/guake/style/background/color '#2e2e34344040'
  __log_info "Background color has been set"
  $GCONFTOOL2 -s -t string /apps/guake/style/font/color '#d8d8dedee9e9'
  __log_info "Font color has been set"
  $GCONFTOOL2 -s -t string /apps/guake/style/font/palette '#3b3b42425252:#bfbf61616a6a:#a3a3bebe8c8c:#ebebcbcb8b8b:#8181a1a1c1c1:#b4b48e8eadad:#8888c0c0d0d0:#e5e5e9e9f0f0:#4c4c56566a6a:#bfbf61616a6a:#a3a3bebe8c8c:#ebebcbcb8b8b:#8181a1a1c1c1:#b4b48e8eadad:#8f8fbcbcbbbb:#ececefeff4f4'
  __log_info "Color palette has been set"
  __log_success "Nord Guake has been installed"
else
  __log_error "Could not execute $GCONFTOOL2 command"
  __cleanup
  exit 1
fi

__cleanup
exit 0
