#
# Cookbook Name:: epel
# Recipe:: default
#

execute "add epel repo" do
  command <<-EOS
    rpm -Uhv #{node['epel']['rpm_url']}
  EOS
  not_if "rpm -q epel-release"
end

execute "update epel repo" do
  command <<-EOS
    yum -y update epel-release
  EOS
end
