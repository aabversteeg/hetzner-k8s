resource "local_file" "inventory" {
  filename = "../.inventory.ini"
  content  = <<-EOT
[nodes]
%{for node in hcloud_server.nodes~}
${node.name} ansible_host=${node.ipv4_address} ip=${tolist(node.network)[0].ip}
%{endfor~}

[k8s-cluster:children]
kube-master
kube-node
kube-control-plane

%{for label in ["etcd", "kube-master", "kube-control-plane", "kube-node"]~}
[${label}]
%{for node in hcloud_server.nodes~}
%{if(node.labels[label])~}
${node.name}
%{endif~}
%{endfor~}

%{endfor~}
  EOT
}
