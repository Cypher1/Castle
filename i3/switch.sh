#!/bin/bash
workspaceA=$1
workspaceB=$2
tmp="tmp"
i3-msg "rename workspace $workspaceA to $tmp; rename workspace $workspaceB to $workspaceA; rename workspace $tmp to $workspaceB"
