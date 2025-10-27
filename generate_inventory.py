#!/usr/bin/env python3
# Usage: python3 generate_inventory.py tf-output.json inventory.ini
import sys, json
if len(sys.argv) < 3:
    print('Usage: generate_inventory.py tf-output.json inventory.ini')
    sys.exit(2)
tfjson = sys.argv[1]
out = sys.argv[2]
with open(tfjson) as f:
    data = json.load(f)
# expected keys: instance_public_ip
public_ip = None
if 'instance_public_ip' in data:
    # terraform output -json format: { "instance_public_ip": { "value": "1.2.3.4", ... } }
    val = data['instance_public_ip']
    if isinstance(val, dict) and 'value' in val:
        public_ip = val['value']
    else:
        public_ip = val
if not public_ip:
    print('No instance_public_ip found in terraform output JSON.')
    sys.exit(1)
with open(out, 'w') as f:
    f.write('[webservers]\n')
    f.write(f"{public_ip} ansible_user=ec2-user\n")
