# 功能
实现开机自启动，主要是synergy、shadowsocks

# 步骤

```shell
sudo cp after-local.service /usr/lib/systemd/system/after-local.service
echo "/home/usera/scripts/auto.sh >> /tmp/start.log 2>&1"
systemctl enable /usr/lib/systemd/system/after-local.service
reboot
```