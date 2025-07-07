# chocolatey-ocsinventory-agent

This is a [Chocolatey](https://chocolatey.org) package that facilitates the installation of the [OCS Inventory NG](https://ocsinventory-ng.org) Agent on Windows systems.

The package allows for a silent, unattended installation of the OCS Inventory NG Agent through the Chocolatey package manager, making it suitable for automated deployments.

**OCS Inventory NG** is an open-source tool used for tracking and managing IT assets, including hardware and software. It also provides features for software distribution and network device discovery.

## Installation Examples

- **Standard Installation**
  Installs the OCS Inventory NG Agent using default configuration:

  ```batch
  choco install ocsinventory-agent
  ```

- **Custom Installation**
  To specify installation parameters, use Chocolatey’s `--installargs` option. For example, to set a custom server URL, disable the Systray icon, and perform an immediate inventory scan:

  ```batch
  choco install ocsinventory-agent --installargs "/server='http://ocs.example.com/ocsinventory' /no_systray /now"
  ```

Additional installation parameters and configuration options are documented in the official OCS Inventory NG guide:
[OCS Inventory NG Agent for Windows Setup Command Line Options](https://wiki.ocsinventory-ng.org/03.Basic-documentation/Setting-up-the-Windows-Agent-2.x-on-client-computers/#manually-installing-ocs-inventory-ng-agent-for-windows)
