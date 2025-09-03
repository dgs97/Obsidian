from google.cloud import compute_v1
from google.oauth2 import service_account

def get_compute_client():
    credentials = service_account.Credentials.from_service_account_file('service-account.json')
    return compute_v1.InstancesClient(credentials=credentials)

def create_instance_with_gcs_access(project_id, zone, instance_name):
    try:
        client = get_compute_client()
        
        # Конфигурация инстанса
        instance = {
            "name": instance_name,
            "machine_type": f"zones/{zone}/machineTypes/f1-micro",
            "disks": [
                {
                    "boot": True,
                    "auto_delete": True,
                    "initialize_params": {
                        "source_image": "projects/debian-cloud/global/images/family/debian-11"
                    }
                }
            ],
            "network_interfaces": [
                {
                    "network": "global/networks/default",
                    "access_configs": [
                        {"name": "External NAT", "type": "ONE_TO_ONE_NAT"}
                    ]
                }
            ],
            "service_accounts": [
                {
                    "email": "default",
                    "scopes": [
                        "https://www.googleapis.com/auth/devstorage.read_only",
                        "https://www.googleapis.com/auth/logging.write",
                        "https://www.googleapis.com/auth/monitoring.write"
                    ]
                }
            ]
        }
        
        operation = client.insert(
            project=project_id,
            zone=zone,
            instance_resource=instance
        )
        
        print(f"Инстанс {instance_name} создается. Операция: {operation.name}")
        return operation
    except Exception as e:
        print(f"Ошибка при создании инстанса: {e}")
        return None

if __name__ == "__main__":
    project_id = "prod-465907"  # Замените на ваш Project ID
    zone = "us-east1-b"
    instance_name = "hw-35-instance"
    
    create_instance_with_gcs_access(project_id, zone, instance_name)