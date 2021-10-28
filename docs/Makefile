.PHONY: terraform

terraform:
	@docker run --rm \
		-v ${CURDIR}:/go/src/github.com/hashicorp/terraform \
		-w /go/src/github.com/hashicorp/terraform \
		hashicorp/terraform:latest \
		$(cmd)