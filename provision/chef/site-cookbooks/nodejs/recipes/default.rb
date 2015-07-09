#
# Cookbook Name:: nodejs
# Recipe:: default
#

%w(openssl-devel).each do |pkg_name|
  package "#{pkg_name}" do
    action :install
    not_if "rpm -q #{pkg_name}"
  end
end

package "nodejs" do
  action :install
  options "--enablerepo=remi"
  not_if "rpm -q nodejs"
end
