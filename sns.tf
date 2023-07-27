resource "aws_autoscaling_notification" "autoscaling_notifications" {
  group_names = [
    aws_autoscaling_group.nf-auto-scaling-grp.name,
  ]
  notifications = [
    "autoscaling:EC2_INSTANCE_LAUNCH",
    "autoscaling:EC2_INSTANCE_TERMINATE",
    "autoscaling:EC2_INSTANCE_LAUNCH_ERROR",
    "autoscaling:EC2_INSTANCE_TERMINATE_ERROR",
  ]
  topic_arn = aws_sns_topic.autoscaling_updates.arn
}
resource "aws_sns_topic" "autoscaling_updates" {
  name = "autoscaling-updates"
}
resource "aws_sns_topic_subscription" "nf-sns-subscription" {
  topic_arn = aws_sns_topic.autoscaling_updates.arn
  protocol  = "email"
  endpoint  = "example@email.com"
}