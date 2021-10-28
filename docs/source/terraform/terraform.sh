#!/bin/bash

docker run --rm \
-v $(pwd):/go/src/github.com/hashicorp/terraform \
-w /go/src/github.com/hashicorp/terraform \
hashicorp/terraform:latest \
--init