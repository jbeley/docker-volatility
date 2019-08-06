docker run --rm -it -v /data/mem/:/data/ jbeley/volatility vol.py -f Infected.vmem

|plugin family | note | directory |
|--------|------|-------|
|community | community plugins from volatility | /plugins/community/ |
|cobalt strike | detect cobalt strike in memory (JPCERT) | /plugins/cobalt/ |
|malconfscan  | detect man families of malware in memory (JPCERT) | /plugins/malconfscan |