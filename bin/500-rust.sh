#!/usr/bin/env bash
set -xueo pipefail
# Install rust, rustup, cargo and rustfmt
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
  -y --no-modify-path --component rustfmt

for crate in zoxide cargo-add record-query
do
    cargo install "${crate}"
done
