# resource "aws_lb" "example" {
#   name               = "example-lb"
#   load_balancer_type = "application"
#   subnets            = [aws_subnet.public.*.id]

#   security_groups    = [aws_security_group.lb.id]

#   tags = {
#     Name = "example-lb"
#   }
# }

# resource "aws_lb_listener" "example" {
#   load_balancer_arn = aws_lb.example.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     target_group_arn = aws_lb_target_group.backend.arn
#     type             = "forward"
#   }
# }

# resource "aws_lb_target_group" "backend" {
#   name     = "backend-tg"
#   port     = 3003
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.main.id

#   health_check {
#     path                = "/health"
#     protocol            = "HTTP"
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 5
#     interval            = 10
#   }

#   stickiness {
#     enabled       = false
#     type          = "lb_cookie"
#     cookie_name   = "example"
#     cookie_expiration_seconds = 86400
#   }

#   tags = {
#     Name = "backend-tg"
#   }
# }

# resource "aws_lb_target_group" "frontend" {
#   name     = "frontend-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.main.id

#   health_check {
#     path                = "/"
#     protocol            = "HTTP"
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#     timeout             = 5
#     interval            = 10
#   }

#   stickiness {
#     enabled       = false
#     type          = "lb_cookie"
#     cookie_name   = "example"
#     cookie_expiration_seconds = 86400
#   }

#   tags = {
#     Name = "frontend-tg"
#   }
# }
