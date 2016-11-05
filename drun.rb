#Include library fileutils so ruby can make directories in the operating system
require 'fileutils'
#Create varible that has all possible charaters the varible NAME can have
characters = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
# Start variable creations that we will use in the commands that we will execute
NAME = (0..5).map{characters.sample}.join
ROLE="go"
TMPDIR = "/home/conrad"
TMPVOL="#{TMPDIR}/drun/#{NAME}"
COMMON="#{TMPDIR}/drun/common"

#Make directories in the filesystem
FileUtils.mkdir_p COMMON
FileUtils.mkdir_p TMPVOL
#go get -t github.com/ParsePlatform/parse-cli
#Commands to execute put into variables
exec_docker = "docker run -it -d -p 0:80 --name=#{NAME} -e PATH=$GOPATH/bin:$PATH -e GOPATH=$HOME/go -e PATH=$PATH:/usr/local/go/bin --hostname "\
  "#{NAME}-#{ROLE} --dns=8.8.8.8 --volume=/var/run/docker.sock:"\
  "/var/run/docker.sock --volume=#{TMPVOL}:/host --volume=#{COMMON}:/common debian:jessie"
exec_init = "docker exec #{NAME} /common/init/runinit.sh"
exec_update = "docker exec #{NAME} apt-get update"
exec_install = "docker exec #{NAME} apt-get -y install ansible"
exec_ansible = "docker exec #{NAME} ansible-playbook -i /host/host -c local /host/setup.yml -vvvv"
exec_attach = "docker attach #{NAME}"

#Execute comands
system(exec_docker)
system(exec_init)
system(exec_update)
system(exec_install)
system(exec_ansible)
exec(exec_attach)
