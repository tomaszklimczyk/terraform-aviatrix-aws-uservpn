# terraform-aviatrix-aws-uservpn

### Description
This module deploys a VPC, Aviatrix spoke gateways and one or more Aviatrix UserVPN gateways behind an elastic loadbalancer.

### Diagram
\<Provide a diagram of the high level constructs thet will be created by this module>
<img src="<IMG URL>"  height="250">

### Usage Example
```
module "vpn_1" {
  source  = "terraform-aviatrix-modules/aws-uservpn/aviatrix"
  version = "1.0.0"

  cidr = "10.1.0.0/20"
  region = "eu-west-1"
  aws_account_name = "AWS"
}
```

### Variables
The following variables are required:

key | value
:--- | :---
\<keyname> | \<description of value that should be provided in this variable>

The following variables are optional:

key | default | value 
:---|:---|:---
\<keyname> | \<default value> | \<description of value that should be provided in this variable>

### Outputs
This module will return the following outputs:

key | description
:---|:---
\<keyname> | \<description of object that will be returned in this output>
