Linux is obsessed with binding every USB controller.
It is afraid that you have your keyboard and mouse
connected to it, and you'll get locked out.

This script fixes that up, so, for example, the
USB controller needs to be rebound to `vfio-pci`.

You still need to add `vfio`, `vfio_iommu_type1`, and 
`vfio_pci` module to `/etc/modules`
and add `vfio-pci.ids=10de:1c82,etc...` on the command line.
