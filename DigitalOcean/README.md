# DigitalOcean Examples

The following is a summary of the [digitalocean upporting Guidance](https://www.digitalocean.com/community/tutorials/how-to-create-digitalocean-snapshots-using-packer-on-ubuntu-16-04)

---

## Variables

| Key                  | Required | Description                                                                                                                                             |
|----------------------|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| `api_token`          | Yes      | DigitalOcean API Token - env var `DIGITALOCEAN_API_TOKEN`                                                                                               |
| `image`              | Yes      | Image slug name for base image - [full list](https://developers.digitalocean.com/documentation/v2/#list-all-images)                                     |
| `region`             | Yes      | Region name or slug - [full list](https://developers.digitalocean.com/documentation/v2/#list-all-regions)                                               |
| `size`               | Yes      | Slug or name of droplet size to use - [full list](https://developers.digitalocean.com/documentation/v2/#list-all-sizes)                                 |
| `api_url`            | No       | The URL of a non-standard API endpoint to be set if using a DigitalOcean API-compatible service.                                                        |
| `droplet_name`       | No       | The name assigned to the Droplet. DigitalOcean sets the hostname of the machine to this value.                                                          |
| `private_networking` | No       | Set to true to enable private networking for the Droplet being created. This defaults to false, or not enabled.                                         |
| `snapshot_name`      | No       | The name of the resulting snapshot that will appear in your account. This must be unique.                                                               |
| `state_timeout`      | No       | The time to wait, as a duration string, for a Droplet to enter a desired state (such as "active") before timing out. The default state timeout is "6m". |
| `user_data`          | No       | User data to launch with the droplet - [further information](https://www.digitalocean.com/community/tutorials/an-introduction-to-droplet-metadata).     |

- Once the template is defined with the variables above, where appropriate, the `packer` commands can be ran without issue.
