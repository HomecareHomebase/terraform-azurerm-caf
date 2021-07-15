# Cloud Adoption Framework for Azure - Terraform module

> Fork of [aztfmod/terraform-azurerm-caf](https://github.com/aztfmod/terraform-azurerm-caf) with additional features and capabilities that have yet to be merged into [aztfmod/terraform-azurerm-caf](https://github.com/aztfmod/terraform-azurerm-caf).

[Terraform Registry: HomecareHomebase/caf](https://registry.terraform.io/modules/HomecareHomebase/caf/azurerm/latest)

Microsoft [Cloud Adoption Framework for Azure](https://aka.ms/caf) provides you with guidance and best practices to adopt Azure.

This module allows you to create resources on Microsoft Azure, is used by the Cloud Adoption Framework for Azure (CAF) landing zones to provision resources in an Azure subscription and can deploy resources being directly invoked from the Terraform registry.

## Prerequisites

- Setup your **environment** using the following guide [Getting Started](https://github.com/Azure/caf-terraform-landingzones/blob/master/documentation/getting_started/getting_started.md) or you use it online with [GitHub Codespaces](https://github.com/features/codespaces).
- Access to an **Azure subscription**.


## Getting started

This module can be used inside [Cloud Adoption Framework Landing zones](https://github.com/Azure/caf-terraform-landingzones), or can be used as standalone, directly from the [Terraform registry](https://registry.terraform.io/modules/aztfmod/caf/azurerm/)

```terraform
module "caf" {
  source  = "HomecareHomebase/caf/azurerm"
  version = "5.3.11"
  # insert the 6 required variables here
}

```

Fill the variables as needed and documented, there is a [quick example here](./examples/standalone.md).

For a complete set of examples you can review the [full library here](./examples).

<img src="https://aztfmod.blob.core.windows.net/media/standalone.gif" width="720"/> <br/> <br/>


## Community

Feel free to open an issue for feature or bug, or to submit a PR, [please review the module contribution and conventions guidelines](./documentation/conventions.md)

In case you have any question, you can reach out to tf-landingzones at microsoft dot com.

You can also reach us on [Gitter](https://gitter.im/aztfmod/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

## Code of conduct

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.


## Upstream Merge

Initially upstream merges will be handled manually until the upstream is a little more stable. 

```sh
git remote add upstream https://github.com/aztfmod/terraform-azurerm-caf
git fetch --all
git checkout master
git pull upstream master
```

## GitHub Push

Changes need to be pushed to GitHub for publishing module changes out to the [Terraform Registry](https://registry.terraform.io/).

```sh
git remote add upstream https://github.com/aztfmod/terraform-azurerm-caf
git fetch --all
git checkout master
git pull master
git push upstream master
```

## Versioning Strategy

Versioning of this module diverged with upstream with the tag `v100.0.0` to prevent upstream collisions and provide a clearer delineation. From `v100.0.0` the component will follow [Semantic Versioning 2.0](https://semver.org/).
