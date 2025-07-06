resource "aws_efs_file_system" "app_efs" {
  creation_token = var.efs_name
  encrypted      = true
}

resource "aws_efs_mount_target" "mounts" {
  count          = length(var.private_subnets)
  file_system_id = aws_efs_file_system.app_efs.id
  subnet_id      = var.private_subnets[count.index]

  depends_on = [aws_efs_file_system.app_efs]
}