#!/bin/bash
while true; do
  curl -d "{\"jsonrpc\":\"2.0\",\"id\":\"1\",\"method\":\"generatetoaddress\",\"params\":[1,\"mzJx22fprF3tVgyo9Qirxykz8UYzWMa5nS\"]}" -u bitcoin:bitcoin localhost:18332
  sleep 10
done
