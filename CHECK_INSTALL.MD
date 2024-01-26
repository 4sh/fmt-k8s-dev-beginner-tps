## Check tools

execute command
```
echo "----- sdk version" && sdk version
curl -s https://raw.githubusercontent.com/4sh/fmt-k8s-dev-beginner-tps/main/scripts/check-tools.sh | sh
k version --short > /dev/null || echo "FAILED - k alias not defined for kubectl"
```

## Check k8s

execute command
```
curl -s https://raw.githubusercontent.com/4sh/fmt-k8s-dev-beginner-tps/main/scripts/check-k8s.sh > check-k8s.sh
chmod +x check-k8s.sh
./check-k8s.sh
rm check-k8s.sh
```