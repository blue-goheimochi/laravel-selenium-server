#
# Cookbook Name:: rpmforge
# Recipe:: default
#

execute "add rpmforge repo" do
  command <<-EOS
    rpm -Uhv #{node['rpmforge']['rpm_url']}
  EOS
  not_if "rpm -q rpmforge-release"
end

execute "update rpmforge repo" do
  command <<-EOS
    yum -y update rpmforge-release
  EOS
end
