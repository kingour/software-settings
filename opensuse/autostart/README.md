# 功能
实现开机自启动，主要是synergy、shadowsocks

# 步骤

```shell
sudo cp after-local.service /usr/lib/systemd/system/after-local.service
sudo echo "/home/usera/scripts/auto.sh" >> /etc/init.d/after.local
sudo systemctl enable /usr/lib/systemd/system/after-local.service
sudo reboot
```
