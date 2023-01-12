# smb-mount-Docker

SMB 挂载 Docker 镜像

```bash
docker run -d \
    --name smb-mount \
    --restart=always \
    --cap-add SYS_ADMIN \
    --cap-add DAC_READ_SEARCH \
    --security-opt apparmor:unconfined \
    -e SERVERPATH="//192.168.1.1/example" \
    -e MOUNTOPTIONS="vers=3.1.1,uid=1000,gid=1000,file_mode=0755,dir_mode=0755,rw,username=user,password=password" \
    -v /home/smb:/mnt/smb:shared \
    ddsderek/smb-mount:latest
```

```yaml
version: '3.3'
services:
    smb-mount:
        container_name: smb-mount
        restart: always
        environment:
            - "SERVERPATH=//192.168.1.1/example"
            - "MOUNTOPTIONS=vers=3.1.1,uid=1000,gid=1000,file_mode=0755,dir_mode=0755,rw,username=user,password=password"
        volumes:
            - '/home/smb:/mnt/smb:shared'
        cap_add:
            - SYS_ADMIN
            - DAC_READ_SEARCH
        security_opt:
            - apparmor:unconfined
        image: ddsderek/smb-mount:latest
```