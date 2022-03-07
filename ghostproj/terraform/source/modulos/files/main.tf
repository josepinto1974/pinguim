resource "local_file" "criar_service_definition_json" {
    content     = <<EOF
[
      {
	    "cpu": "${var.fargate_cpu}",
        "memory": "${var.fargate_memory}",
        "name": "jenkins-agent",
        "image": "${var.imagem}",
        "essential": true,
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "/ecs/jenkins-agent",
            "awslogs-region": "us-west-1",
            "awslogs-stream-prefix": "ecs"
          }
        },
        "mountPoints": [
          {
            "sourceVolume": "efs_temp",
            "containerPath": "/efs",
            "readOnly": false
          }
        ]
      }
    ]
EOF
    filename = "service.json"
}