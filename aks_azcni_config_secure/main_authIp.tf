resource "null_resource" "authIPInstall" {
  
  provisioner "local-exec" {
        command = "az extension add --name aks-preview && az aks update --api-server-authorized-ip-ranges ${var.AUTH_IP_RANGES},${azurerm_public_ip.azfwpip.ip_address}/32 -g ${azurerm_resource_group.main.name} -n ${azurerm_kubernetes_cluster.main.name} && az aks update -g ${azurerm_resource_group.main.name} -n ${azurerm_kubernetes_cluster.main.name} --enable-pod-security-policy"

    environment = {
            AKS_NAME   = "${azurerm_kubernetes_cluster.main.name}"
            AKS_RG     = "${azurerm_resource_group.main.name}"
            AUTH_RANGE = "${var.AUTH_IP_RANGES}"
            AZ_FW_IP   = "${azurerm_public_ip.azfwpip.ip_address}/32"
        }
    }
  }