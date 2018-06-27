#!/usr/bin/env bash
echo "Raising firewall"
ufw allow OpenSSH
ufw --force enable
ufw status