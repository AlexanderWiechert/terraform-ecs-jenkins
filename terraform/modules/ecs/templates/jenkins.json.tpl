[
  {
    "name": "${name}",
    "image": "${image}",
    "cpu": 1024,
    "memory": 3072,
    "essential": true,
    "privileged": true,
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group}",
        "awslogs-region": "${region}"
      }
    },
    "portMappings": [
      {
        "containerPort": ${port},
        "hostPort": ${port}
      },
      {
        "containerPort": ${agent},
        "hostPort": ${agent}
      }
    ]
  }
]
