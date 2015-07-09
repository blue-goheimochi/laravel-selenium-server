#
# Cookbook Name:: chkconfig
# Recipe:: default
#

node['chkconfig']['off'].each do |service|
  execute "chkconfig #{service} off" do
    command <<-EOS
      chkconfig #{service} off
    EOS
    only_if "chkconfig --list | grep #{service} | grep '3:on'"
  end
end