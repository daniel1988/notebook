sudo dpkg --add-architecture amd64

sudo dpkg --add-architecture i386



## virtual box share dir

```
mount -t vboxsf linux_share /pcshare
```




curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh| sudo bash