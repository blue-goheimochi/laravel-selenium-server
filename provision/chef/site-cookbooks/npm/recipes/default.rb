#
# Cookbook Name:: npm
# Recipe:: default
#

package "npm" do
  action :install
  options "--enablerepo=remi"
  not_if "rpm -q npm"
end
