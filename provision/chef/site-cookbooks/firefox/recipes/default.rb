#
# Cookbook Name:: firefox
# Recipe:: default
#

package "firefox" do
  action :install
  not_if "rpm -q firefox"
end