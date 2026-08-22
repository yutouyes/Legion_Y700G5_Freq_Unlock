#!/system/bin/sh
# Customize script for Lenovo Y700 GamePerf module
# Note: MODPATH, OUTFD etc are provided by the calling update-binary

# Double-check target file
if [ -f "$MODPATH/system/etc/gameperfconfig.xml" ]; then
  ui_print "  customize: OK - system/etc/gameperfconfig.xml present"
  # Explicit 0644 root:root
  chmod 0644 "$MODPATH/system/etc/gameperfconfig.xml"
  chown 0:0 "$MODPATH/system/etc/gameperfconfig.xml"
  # Make sure parent dirs have correct perms
  chmod 0755 "$MODPATH/system" 2>/dev/null
  chmod 0755 "$MODPATH/system/etc" 2>/dev/null

fi
