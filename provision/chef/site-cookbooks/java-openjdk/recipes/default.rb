#
# Cookbook Name:: java-openjdk
# Recipe:: default
#

package "#{node['java-openjdk']['package']}" do
  action :install
  not_if "rpm -q #{node['java-openjdk']['package']}"
end