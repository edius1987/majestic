#!/bin/bash
if $(gsettings get org.mate.Marco.general compositing-manager) == "true"
then
  gsettings set org.mate.Marco.general compositing-manager false
else
  gsettings set org.mate.Marco.general compositing-manager true
fi
