from google.cloud import storage
from google.oauth2 import service_account

# Инициализация клиента GCS
def get_storage_client():
    credentials = service_account.Credentials.from_service_account_file('service-account.json')
    return storage.Client(credentials=credentials)

# 1. Создание бакета
def create_bucket(bucket_name, location='us-east1'):
    try:
        client = get_storage_client()
        bucket = client.create_bucket(bucket_name, location=location)
        print(f"Бакет {bucket_name} успешно создан")
        return bucket
    except Exception as e:
        print(f"Ошибка при создании бакета: {e}")
        return None

# 2. Загрузка файла в бакет
def upload_file(bucket_name, file_path, object_name=None):
    try:
        client = get_storage_client()
        bucket = client.get_bucket(bucket_name)
        
        if object_name is None:
            object_name = file_path.split('/')[-1]
        
        blob = bucket.blob(object_name)
        blob.upload_from_filename(file_path)
        
        print(f"Файл {file_path} успешно загружен в {bucket_name}/{object_name}")
        return blob
    except Exception as e:
        print(f"Ошибка при загрузке файла: {e}")
        return None

# 3. Изменение настроек доступа
def set_file_public(bucket_name, object_name):
    try:
        client = get_storage_client()
        bucket = client.get_bucket(bucket_name)
        blob = bucket.blob(object_name)
        
        blob.make_public()
        print(f"Доступ к файлу {object_name} установлен как public-read")
        return blob.public_url
    except Exception as e:
        print(f"Ошибка при изменении ACL: {e}")
        return None

if __name__ == "__main__":
    bucket_name = "my-unique-bucket-name-hw-35"  # Замените на уникальное имя
    file_path = "hw-35.txt"  # Создайте тестовый файл
    
    # Создаем бакет
    create_bucket(bucket_name)
    
    # Загружаем файл
    upload_file(bucket_name, file_path)
    
    # Меняем права доступа
    set_file_public(bucket_name, file_path.split('/')[-1])