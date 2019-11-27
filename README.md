[![](https://images.microbadger.com/badges/image/jbeley/volatility.svg)](https://microbadger.com/images/jbeley/volatility "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/jbeley/volatility.svg)](https://microbadger.com/images/jbeley/volatility "Get your own version badge on microbadger.com")
```
docker run --rm -it -v /data/mem/:/data/ jbeley/volatility vol.py -f Infected.vmem
```

To use volatility against a memory image:
```
docker run -v $YOUR_DATA_DIR:/data/ -u root -it jbeley/volatility:latest \
  vol.py --plugins /plugins -f MEMORYIMAGE.bin --profile Win10x64 pstree
```


To view plugins available:
```
docker run -v $YOUR_DATA_DIR:/data/ -u root -it jbeley/volatility:latest \
  vol.py --plugins /plugins -h | grep -A1000 "Supported Plugin Commands"
```

|plugin family | note | directory |
|--------|------|-------|
|community | community plugins from volatility | /plugins/community/ |
|cobalt strike | detect cobalt strike in memory (JPCERT) | /plugins/cobalt/ |
|malconfscan  | detect man families of malware in memory (JPCERT) | /plugins/malconfscan |