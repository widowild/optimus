#!/bin/bash
VIDEO=`/usr/sbin/lspci|grep -c Intel`

if [ "$VIDEO" == 16 ]; then
   echo "NVidia GPU detected"
   ln -sf /etc/X11/xorg.nvidia.conf /etc/X11/xorg.conf
   OPENGL_DEJA_INSTALL=`apt-cache --installed libglu1-mesa 2>/dev/null|grep -c libglu1-mesa`
      if [ "$OPENGL_DEJA_INSTALL" == 1 ]; then
          echo "Switching OpenGL implementation to nvidia-utils"
          apt-get remove -y libglu1-mesa 2>/dev/null
          apt-get install -y nvidia-utils 2>/dev/null
      fi
else
echo "Intel GPU detected"
ln -sf /etc/X11/xorg.intel.conf /etc/X11/xorg.conf
sudo modprobe acpi_call
echo "'\_SB.PCI0.P0P2.PEGP._OFF' > /proc/acpi/call"
OPENGL=`apt-cache --installed libglu1-mesa 2>/dev/null|grep -c libgl`
      if [  $OPENGL != 1 ]; then
          apt-get remove -y nvidia-utils 2>/dev/null
          apt-get install -y libglu1-mesa 2>/dev/null
      fi
fi
