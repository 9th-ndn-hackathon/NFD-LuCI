# NDN in OpenWrt LuCI

Team Members:

* [Junxiao Shi](https://yoursunny.com)
* [Hunter](https://github.com/jdellaverson19)
* [Xinyu Ma](https://github.com/zjkmxy)

Usage:

1. Install [NDN packages](https://github.com/yoursunny/OpenWrt-packages) to router.
2. `opkg install luci-lib-json`
3. Copy files `./luci` to `/usr/lib/lua/luci` on OpenWrt router.
   Example: `bash upload.sh 192.168.1.1`
4. Access LuCI via browser.

To build IPK packages, use [yoursunny OpenWrt Packages](https://github.com/yoursunny/OpenWrt-packages) feed.

Presentation: [NFD on OpenWrt Home Router](https://www.slideshare.net/yoursunny/nfd-luci)
