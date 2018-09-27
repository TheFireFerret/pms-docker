#!/bin/bash

function getVersionInfo {
}


function installFromUrl {
  installFromRawUrl "https://downloads.plex.tv/plex-media-server-new/1.13.6.283-9e747cb50/debian/plexmediaserver_1.13.6.283-9e747cb50_amd64.deb?_ga=2.119707852.593178946.1537855749-1267310604.1479612636"
}

function installFromRawUrl {
  local remoteFile="$1"
  curl -J -L -o /tmp/plexmediaserver.deb "${remoteFile}"
  local last=$?

  # test if deb file size is ok, or if download failed
  if [[ "$last" -gt "0" ]] || [[ $(stat -c %s /tmp/plexmediaserver.deb) -lt 10000 ]]; then
    echo "Failed to fetch update"
    exit 1
  fi

  dpkg -i --force-confold /tmp/plexmediaserver.deb
  rm -f /tmp/plexmediaserver.deb
}
