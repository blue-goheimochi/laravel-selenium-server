#
# Cookbook Name:: java-openjdk-devel
# Recipe:: default
#

package "#{node['java-openjdk-devel']['package']}" do
  action :install
  not_if "rpm -q #{node['java-openjdk-devel']['package']}"
end