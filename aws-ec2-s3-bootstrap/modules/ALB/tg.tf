resource "aws_alb_target_group" "tg" {
  for_each = var.tgnames
  name = each.key
  port = var.tgport
  protocol = var.tgprotocol
  vpc_id = data.aws_vpc.default.id

  tags = {
    Name = each.key
  }

  health_check {
    path = each.value
    protocol = var.tgprotocol
    matcher = "200"
    interval = 30
    timeout = 5
    healthy_threshold = 5
    unhealthy_threshold = 3
  }
}

resource "aws_alb_target_group_attachment" "tg_attach" {
  for_each = var.tgnames
  target_group_arn = aws_alb_target_group.tg[each.key].arn
  target_id = var.instances["${lower(each.key)}_instance"]
  port = var.tgport
}

resource "aws_alb_listener" "tg_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port = var.tgport
  protocol = var.tgprotocol
  default_action {
    type = "forward"
    target_group_arn = aws_alb_target_group.tg["Blue"].arn
  }
}

resource "aws_alb_listener_rule" "tg_listener_rule" {
  for_each = var.tgnames
  listener_arn = aws_alb_listener.tg_listener.arn
  action {
    type = "forward"
    target_group_arn = aws_alb_target_group.tg[each.key].arn
  }
  condition {
    path_pattern {
      values = ["/${lower(each.key)}*"]
    }
  }
}
