# Azure_DNS
### ✅ `README.md`

```markdown
# 🌐 Azure DNS Zone Deployment with Terraform & GitHub Actions

This project automates the provisioning of an **Azure DNS Zone** and **A Record** using Terraform. It integrates with **GitHub Actions** to create a CI/CD pipeline that applies infrastructure changes upon pushing to the `main` branch.

---

## 📦 What This Project Deploys

- A unique **Azure Resource Group** (with a random suffix).
- An **Azure DNS Zone**:
  - Uses a custom name if provided, or generates one like `www.abcd123456789.azurequickstart.org`.
- An **A Record**:
  - Associated with multiple IPv4 addresses (default: `1.2.3.4`, `1.2.3.5`).
  - TTL is configurable (default: 3600 seconds).

---

## 📁 Project Structure

```

.
├── main.tf                     # Terraform resource definitions
├── providers.tf                # Provider and Terraform version
├── variables.tf                # Input variables
├── outputs.tf                  # Output values
└── .github/
└── workflows/
└── terraform-deploy.yml  # GitHub Actions CI/CD pipeline

````

---

## ⚙️ Prerequisites

- Azure Subscription
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Terraform](https://developer.hashicorp.com/terraform/install)
- GitHub Repository

---

## 🔐 Setup Azure Authentication (Service Principal)

1. **Create a Service Principal** with Contributor access:

   ```bash
   az ad sp create-for-rbac --role="Contributor" \
     --scopes="/subscriptions/<YOUR_SUBSCRIPTION_ID>" \
     --sdk-auth
````

2. **Save the following values from the output** into your GitHub repo under:

   **GitHub → Settings → Secrets and variables → Actions → New repository secret**

   | GitHub Secret Name    | Value from SP Output |
   | --------------------- | -------------------- |
   | `ARM_CLIENT_ID`       | `clientId`           |
   | `ARM_CLIENT_SECRET`   | `clientSecret`       |
   | `ARM_SUBSCRIPTION_ID` | `subscriptionId`     |
   | `ARM_TENANT_ID`       | `tenantId`           |

---

## 🚀 CI/CD Pipeline (GitHub Actions)

**File:** `.github/workflows/terraform-deploy.yml`

### 💡 Pipeline Features:

* Runs on push or pull request to `main` branch
* Validates, plans, and applies infrastructure
* Authenticates securely with GitHub secrets

### 🧪 Triggering the Pipeline

Simply push a change to the `main` branch:

```bash
git add .
git commit -m "Update DNS configuration"
git push origin main
```

Check progress under **GitHub → Actions** tab.

---

## 🛠️ Customization Options

You can override default settings via `terraform.tfvars` or CLI flags:

```hcl
resource_group_location = "eastus"
dns_zone_name           = "yourdomain.com"
dns_ttl                 = 300
dns_records             = ["10.0.0.1", "10.0.0.2"]
```

Or pass them via CLI:

```bash
terraform apply -var="dns_zone_name=yourdomain.com" -var="dns_records=[\"10.0.0.1\"]"
```

---

## 📤 Terraform Outputs

After successful deployment, you’ll get:

| Output                | Description                                          |
| --------------------- | ---------------------------------------------------- |
| `resource_group_name` | The generated Azure resource group name              |
| `dns_zone_name`       | Name of the created DNS zone                         |
| `name_servers`        | List of Azure-assigned name servers (for delegation) |

---

## 🌍 DNS Delegation

If you're using a custom domain and want it publicly resolvable:

1. Go to your domain registrar (e.g., GoDaddy, Namecheap).
2. Add the **name servers** returned by Terraform.
3. DNS records will now resolve through Azure.

---

## 🧹 Cleanup

To destroy all resources:

```bash
terraform destroy -auto-approve
```

---

## 🧠 Learn More

* [Azure DNS Documentation](https://learn.microsoft.com/en-us/azure/dns/)
* [Terraform AzureRM Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
* [GitHub Actions for Terraform](https://github.com/hashicorp/setup-terraform)

---
