#!/bin/bash

# 检查镜像仓库数量以及镜像名

python3 -c "\

import json,requests; \
response = requests.get('http://localhost:4001/v2/_catalog'); \
result = response.json(); \
print(len(result[\"repositories\"])); \
print(\"\n\".join([images for images in result[\"repositories\"]]))
"
