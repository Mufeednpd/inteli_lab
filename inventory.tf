# Generate ansible inventory file

resource "local_file" "ansible_inventory" {
    content     =  templatefile(
                    "${path.cwd}/ansible/hosts.tftpl", {
                     hostname= "worker", workernode_ip =  "${data.aws_network_interface.kubeworkerworker.*.public_ip}",
                     jenkins_ip = "${data.aws_network_interface.jenkins.*.public_ip}"              
                     })
    filename    = "${path.cwd}/hosts"
    depends_on = [aws_instance.kubeworker,aws_instance.jenkins]
}
