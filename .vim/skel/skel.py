#!/usr/bin/env python3

# j4b0l's template library
# example Python script

import boto3

ready = True
# AWS regions, to avoid copy-pastes
def get_regions():
    client = boto3.client('ec2', region_name='us-east-1')
    return [i['RegionName'] for i in client.describe_regions()['Regions']]

regions = get_regions()
for r in regions:
    client = boto3.client('s3', region_name=r)
for region in regions:
    ec2_client = boto3.client('ec2', region_name=region)
    ec2_paginator = ec2_client.get_paginator('describe_instances')

print("Hello from HELLO.py")

