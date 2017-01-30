#!/bin/bash 



# Save this script into set_colors.sh, make this file executable and run it: 

# 

# $ chmod +x set_colors.sh 

# $ ./set_colors.sh 

# 

# Alternatively copy lines below directly into your shell. 



gconftool-2 -s -t string /apps/guake/style/background/color '#f3f3f3f3f3f3'

gconftool-2 -s -t string /apps/guake/style/font/color '#707070707070'

gconftool-2 -s -t string /apps/guake/style/font/palette 
'#d3d3d3d3d3d3:#efef6b6b7b7b:#a1a1d5d56969:#f5f593933535:#4e4ec2c2e8e8:#fefec7c7cdcd:#9595c1c1c0c0:#707070707070:#b3b3b3b3b3b3:#eded54546666:#afafdbdb8080:#f5f593933535:#5d5dc7c7eaea:#d2d2a4a4b4b4:#7575a1a1a0a0:#909090909090'


