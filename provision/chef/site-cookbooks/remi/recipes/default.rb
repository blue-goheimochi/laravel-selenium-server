#
# Cookbook Name:: remi
# Recipe:: default
#

execute "add remi repo" do
  command <<-EOS
    rpm -Uhv #{node['remi']['rpm_url']}
  EOS
  not_if "rpm -q remi-release"
end

execute "update remi repo" do
  command <<-EOS
    yum -y update remi-release
  EOS
end
