#!/usr/bin/env bash

confd -watch -backend consul -node ${CONSUL_ADDR}
