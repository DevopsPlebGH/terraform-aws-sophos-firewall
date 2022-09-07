{
%{ if central_username != "" ~}
  "centralusername": "${central_username}",
  "centralsecretId": "${central_password}",
%{ endif ~}
  "ssmkSecretId": "${ssmk_password}",
  "hostname": "${firewall_hostname}",
  "sendstats": "${send_stats}",
  "region": "${aws_region}",
  "secretId": "${admin_password}",
  "configSecretId": "${config_password}"
}


