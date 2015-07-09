#
# Cookbook Name:: selenium-server
# Recipe:: default
#

include_recipe "java-openjdk"
include_recipe "java-openjdk-devel"

execute "set selenium server" do
  command <<-EOS
    mkdir #{node['selenium-server']['install-dir']}
    cd #{node['selenium-server']['install-dir']}
    wget -O #{node['selenium-server']['jar-name']} #{node['selenium-server']['download-url']}
  EOS
  not_if { File.exist?("#{node['selenium-server']['install-dir']}/#{node['selenium-server']['jar-name']}") }
end

template "/etc/rc.d/init.d/selenium-server" do
  source "selenium-server.erb"
  owner "root"
  group "root"
  mode "0755"
  variables({
    :jar_file => "#{node['selenium-server']['install-dir']}/#{node['selenium-server']['jar-name']}",
    :port     => node['selenium-server']['port']
  })
  notifies :restart, "service[selenium-server]"
end

execute "chkconfig --add selenium-server" do
  command <<-EOS
    chkconfig --add selenium-server
  EOS
end

service "selenium-server" do
  supports :start => true, :status => true, :restart => true
  action [:enable]
end
