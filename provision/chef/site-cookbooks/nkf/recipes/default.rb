#
# Cookbook Name:: nkf
# Recipe:: default
#

package "nkf" do
  action :install
  not_if "rpm -q nkf"
end