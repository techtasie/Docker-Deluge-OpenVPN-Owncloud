CONF_PATH="/etc/openvpn/openvpn.ovpn"

NEW_IP=$(dig +short $(./DomainExtractor.sh) | head -n 1);

NEW_PORT=$(./PortExtractor.sh);

NEW_LINE="remote ${NEW_IP} ${NEW_PORT}"

awk -v new_line="$NEW_LINE" 'BEGIN{ line=new_line; } { if($0 ~ /remote /) { print line; } else { print $0; } }' $CONF_PATH > /etc/openvpn/openvpn.conf
