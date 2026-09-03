{config, pkgs, ... }:

{
 services.nfs.server.enable = true;
 services.nfs.server.exports = ''
   /mnt/misc/code_projects 100.110.0.0/16(rw,sync,no_subtree_check) fdc8:d5bb:2a02:6e0::/64(rw,sync,no_subtree_check)
   /mnt/misc/waffles_stuff 100.110.0.0/16(rw,sync,no_subtree_check) fdc8:d5bb:2a02:6e0::/64(rw,sync,no_subtree_check)
 ''; 
}
