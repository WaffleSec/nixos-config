{config, pkgs, ... }:

{
 services.nfs.server.enable = true;
 services.nfs.server.exports = ''
   /export 100.110.0.0/16(rw,fsid=0,sync,no_subtree_check) fdc8:d5bb:2a02:6e0::/64(rw,fsid=0,sync,no_subtree_check)
   /export/share 100.110.0.0/16(rw,nohide,sync,no_subtree_check) fdc8:d5bb:2a02:6e0::/64(rw,nohide,sync,no_subtree_check)
 ''; 
}
