#!/bin/bash
# ==============================================================================
# Automated Layer 7 HTTP Burst Test for SafeLine WAF Rate Limiting (Linux/macOS)
# ==============================================================================

TARGET_URL="http://10.157.52.217/DVWA/login.php"
BURST_COUNT=15

echo "[*] Initiating Layer 7 burst test against: $TARGET_URL"
echo "[*] Total Requests: $BURST_COUNT"
echo ""

for i in $(seq 1 $BURST_COUNT); do
    STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" "$TARGET_URL")
    if [ "$STATUS_CODE" -eq "200" ]; then
        echo -e "Request [$i]: HTTP $STATUS_CODE (\e[32mAllowed\e[0m)"
    elif [ "$STATUS_CODE" -eq "429" ] || [ "$STATUS_CODE" -eq "403" ]; then
        echo -e "Request [$i]: HTTP $STATUS_CODE (\e[33mIntercepted / Throttled by WAF\e[0m)"
    else
        echo -e "Request [$i]: HTTP $STATUS_CODE (\e[31mOther\e[0m)"
    fi
done