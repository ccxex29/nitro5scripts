#!/bin/bash

if [[ $(systemctl is-enabled optimus-manager.service) = 'enabled' ]]; then
	optimus-manager-qt
fi
