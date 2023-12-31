# Build Process

## Jenkins_Runner

```
# vi terraform-ecs-jenkins/terraform/modules/jenkins-runner/variables.tf
```

```
variable "build_number" {
  type = string
  description = "Increase the build number to trigger an new ami build with packer"
  default = 1
}
```

```
# terraform workspace select dev
# terraform apply -var-file=vars/$(terraform workspace show).tfvars
```

## Jenkins Master

```
# vi terraform-ecs-jenkins/terraform/variables.tf
```

```
variable "build_number" {
  type = string
  description = "Increase the build number to trigger an new ami build with packer"
  default = 1
}
```

```
# terraform workspace select dev
# terraform apply -var-file=vars/$(terraform workspace show).tfvars
```

# Alexander Wiechert // Elastic2ls

[Website](https://www.elastic2ls.com/)

[Contact](info@elastic2ls.com)

[License](https://github.com/AlexanderWiechert/.github/blob/main/LICENSE)
