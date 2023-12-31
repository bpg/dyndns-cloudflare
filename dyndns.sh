#!/bin/sh

# Expected environment variables:
# API_TOKEN="<Cloudflare API Token>"
# HOSTED_ZONE_ID="<Cloudflare Zone ID>"
# RECORD_NAME="host.example.com"

TYPE="A"
COMMENT="Auto updated @ $(date)"

# get the current IP address
current_ip=$(curl --silent http://checkip.amazonaws.com/)

# validate the IP address
if [[ ! $current_ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
	echo "IP address is invalid: $current_ip"
	exit 1
fi

# find the current record in Cloudflare
get_record_response=$(curl --silent --request GET --url "https://api.cloudflare.com/client/v4/zones/${HOSTED_ZONE_ID}/dns_records" \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer ${API_TOKEN}")
if [ "$(echo "$get_record_response" | jq -r '.success' )" == "false" ]; then
  echo "Error getting record: $( echo "$get_record_response"| jq -r '.errors[0].message')"
  exit 1
fi

current_record=$(echo "$get_record_response" | jq -r '.result[] | select (.name == "'"$RECORD_NAME"'") | select (.type == "'"$TYPE"'") | .id, .content')
if [ -z "$current_record" ]; then
  echo "Record not found: $RECORD_NAME"
  exit 1
fi

{ read record_id; read record_ip; } << EOF
${current_record}
EOF

if [ "$current_ip" == "$record_ip" ]; then
	echo "The IP address $current_ip has not changed, exiting"
	exit 0
fi

echo "The IP address has changed from $record_ip to $current_ip, updating record $RECORD_NAME"

update_record_response=$(curl --silent --request PUT --url "https://api.cloudflare.com/client/v4/zones/56de39c55b0fb37eac751a5f39f50760/dns_records/${record_id}" \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer ${API_TOKEN}" \
  --data "{
  \"comment\": \"${COMMENT}\",
  \"content\": \"${current_ip}\",
  \"name\": \"$RECORD_NAME\",
  \"proxied\": false,
  \"type\": \"A\"
}")
if [ "$(echo "$get_record_response" | jq -r '.success' )" == "false" ]; then
  echo "Error updating record: $( echo "$update_record_response"| jq -r '.errors[0].message')"
  exit 1
else
  echo "The record $RECORD_NAME has been successfully updated"
  echo "$update_record_response" | jq
  exit 0
fi


