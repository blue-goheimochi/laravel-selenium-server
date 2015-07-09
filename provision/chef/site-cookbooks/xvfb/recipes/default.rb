#
# Cookbook Name:: xvfb
# Recipe:: default
#

execute "yum groupinstall 'Japanese Support'" do
  command "yum -y groupinstall 'Japanese Support'"
  not_if "yum grouplist | sed -n -e '/Installed Groups/,$p' | sed -n -e '/Available Groups/,$!p' | grep -w 'Japanese Support'"
end

execute "yum groupinstall 'X Window System'" do
  command "yum -y groupinstall 'X Window System'"
  not_if "yum grouplist | sed -n -e '/Installed Groups/,$p' | sed -n -e '/Available Groups/,$!p' | grep -w 'X Window System$'"
end

package "xorg-x11-server-Xvfb" do
  action :install
  not_if "rpm -q xorg-x11-server-Xvfb"
end

execute "dbus-uuidgen" do
  command <<-EOS
    dbus-uuidgen > /var/lib/dbus/machine-id
  EOS
  not_if { File.exist?("/var/lib/dbus/machine-id") }
end

template "/etc/rc.d/init.d/xvfb" do
  source "xvfb.erb"
  owner "root"
  group "root"
  mode "0755"
  variables({
    :display_num => node['xvfb']['display_num'],
    :screen_w    => node['xvfb']['screen_w'],
    :screen_h    => node['xvfb']['screen_h'],
    :screen_bit  => node['xvfb']['screen_bit']
  })
  notifies :restart, "service[xvfb]"
end

execute "chkconfig --add xvfb" do
  command <<-EOS
    chkconfig --add xvfb
  EOS
end

service "xvfb" do
  supports :start => true, :status => true, :restart => true
  action [:enable]
end