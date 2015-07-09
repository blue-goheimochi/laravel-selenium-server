#
# Cookbook Name:: selinux
# Recipe:: default
#

execute "disable selinux" do
  command <<-EOS
    setenforce 0
  EOS
  only_if "getenforce | grep -w 'Enforcing'"
end

template "/etc/selinux/config" do
  source "config.erb"
  owner "root"
  group "root"
  mode "0644"
end