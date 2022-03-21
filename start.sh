DEFAULT_INI="$PROFILE_DIR/default.ini"

  # create default.ini if it doesn't exist
if [ ! -f $DEFAULT_INI ]; then
    cp "./rocketstation_DedicatedServer_Data/StreamingAssets/default.ini" "$PROFILE_DIR"
    # change default password
    RCONPASSWORD="${RCONPASSWORD:-`pwgen 7 1`}"
    ADMINPASSWORD="${ADMINPASSWORD:-`pwgen 7 1`}"
    PASSWORD="${PASSWORD:-`pwgen 7 1`}"
    sed -i "s/^SERVERNAME=.*/SERVERNAME=$SERVERNAME/g" $DEFAULT_INI
    sed -i s/^RCONPASSWORD=.*/RCONPASSWORD=$RCONPASSWORD/g $DEFAULT_INI
    sed -i s/^ADMINPASSWORD=.*/ADMINPASSWORD=$ADMINPASSWORD/g $DEFAULT_INI
    sed -i s/^PASSWORD=.*/PASSWORD=$PASSWORD/g $DEFAULT_INI
    #    sed -i s/^WORLDNAME=.*/WORLDNAME=$WORLDNAME/g $DEFAULT_INI
    sed -i s/^MAPNAME=.*/MAPNAME=$WORLDTYPE/g $DEFAULT_INI
fi

./rocketstation_DedicatedServer.x86_64 -batchmode -nographics -autostart \
    -autosaveinterval="$AUTOSAVEINTERVAL" \
    -basedirectory="$PROFILE_DIR" \
    -loadworld="$WORLDNAME" \
    -worldtype="$WORLDTYPE"