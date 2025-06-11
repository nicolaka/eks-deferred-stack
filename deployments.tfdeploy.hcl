# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

identity_token "aws" {
  audience =  ["aws.workload.identity"]
}


deployment "development-east" {
  inputs = {
    cluster_name        = "stacks-eks-us-east-2-dev"
    kubernetes_version  = "1.30"
    region              = "us-east-2"
    role_arn            = "arn:aws:iam::713653441474:role/nk-aws-openid-role"
    identity_token      = identity_token.aws.jwt
    default_tags        = { stacks-preview-example = "eks-deferred-stack" }
  }
}

/*
deployment "development-west" {
  inputs = {
    cluster_name        = "stacks-eks-west-dev"
    kubernetes_version  = "1.30"
    region              = "us-west-2"
    role_arn            = "arn:aws:iam::713653441474:role/nk-aws-openid-role"
    identity_token      = identity_token.aws.jwt
    default_tags        = { stacks-preview-example = "eks-deferred-stack" }
  }
}
*/

deployment "production-east" {
  inputs = {
    cluster_name        ="stacks-eks-east-prod"
    kubernetes_version  = "1.30"
    region              = "us-east-2"
    role_arn            = "arn:aws:iam::713653441474:role/nk-aws-openid-role"
    identity_token      = identity_token.aws.jwt
    default_tags        = { stacks-preview-example = "eks-deferred-stack" }
  }
}


orchestrate "auto_approve" "successful_plan" {
  check {
    condition = context.plan.deployment == deployment.development-east
    reason    = "Auto-approve development deployment"
  }
}

/*
orchestrate "auto_approve" "successful_plan" {
  check {
    condition = context.plan.deployment == deployment.development-west
    reason    = "Auto-approve development deployment"
  }
}

*/