# dyndns-cloudflare

A tiny docker image to dynamically update a cloudflare DNS record with your current public IP address.

Environment variables:

| Variable       | Description              |
|----------------|--------------------------|
| API_TOKEN      | Cloudflare API Token     |
| HOSTED_ZONE_ID | Cloudflare Zone ID       |
| RECORD_NAME    | FQDN of record to update |
