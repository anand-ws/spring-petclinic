output "jenkins_public_ip" {
  value = module.jenkinsVM.public_ip
}

output "lb_public_dns" {
  value = module.alb.lb_dns_name

}

