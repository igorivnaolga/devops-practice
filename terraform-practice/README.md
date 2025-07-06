# Завдання:

- Налаштувати S3 бакет для зберігання стейт-файлів Terraform з увімкненим версіонуванням та шифруванням AES256.
- Створити VPC з 2 публічними та 2 приватними підмережами, Internet Gateway, NAT Gateway та таблицями маршрутів.
- Створити кластер RDS PostgreSQL у приватних підмережах.
- Створити файлову систему EFS з монтуванням у приватних підмережах.
- Створити S3 бакет для логів із політикою видалення об'єктів старших за 30 днів.

### Note: to reduce the cost we commented out the creation of the NAT Gateway

# Steps

Rename `terraform.tfvars.example` to `terraform.tfvars`

Init terraform

```shell
terraform init
```

Check the resources that should be created

```shell
terraform plan
```

Apply the changes

```shell
terraform apply
```

Check the output: `Apply complete! Resources: 17 added, 0 changed, 0 destroyed.`

```shell
terraform destroy
```

Check the output: `Destroy complete! Resources: 17 destroyed.`