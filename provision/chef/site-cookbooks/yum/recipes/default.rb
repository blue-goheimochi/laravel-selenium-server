#
# Cookbook Name:: yum
# Recipe:: default
#

execute "yum update" do
  command "yum -y update"
end

package "yum-cron" do
  action :install
  not_if "rpm -q yum-cron"
end

service "yum-cron" do
 supports :status => true, :restart => true
 action [ :enable, :start ]
end

execute "yum groupinstall 'Base'" do
  command "yum -y groupinstall 'Base'"
  not_if "yum grouplist | sed -n -e '/Installed Groups/,$p' | sed -n -e '/Available Groups/,$!p' | grep -w 'Base'"
end

execute "yum groupinstall 'Development tools'" do
  command "yum -y groupinstall 'Base'"
  not_if "yum grouplist | sed -n -e '/Installed Groups/,$p' | sed -n -e '/Available Groups/,$!p' | grep -w 'Development tools'"
end

execute "yum groupinstall 'Japanese Support'" do
  command "yum -y groupinstall 'Japanese Support'"
  not_if "yum grouplist | sed -n -e '/Installed Groups/,$p' | sed -n -e '/Available Groups/,$!p' | grep -w 'Japanese Support'"
end

package "yum-plugin-fastestmirror" do
  action :install
  not_if "rpm -q yum-plugin-fastestmirror"
end

package "yum-plugin-priorities" do
  action :install
  not_if "rpm -q yum-plugin-priorities"
end
