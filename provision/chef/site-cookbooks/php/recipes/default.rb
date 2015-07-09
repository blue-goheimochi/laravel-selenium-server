#
# Cookbook Name:: php
# Recipe:: default
#

package "php" do
  action :install
  options "--enablerepo=remi,remi-php56"
  not_if "rpm -q php"
end

package "php-mcrypt" do
  action :install
  options "--enablerepo=remi,remi-php56"
  not_if "rpm -q php-mcrypt"
end

package "php-pdo" do
  action :install
  options "--enablerepo=remi,remi-php56"
  not_if "rpm -q php-pdo"
end

package "php-mbstring" do
  action :install
  options "--enablerepo=remi,remi-php56"
  not_if "rpm -q php-mbstring"
end

package "php-xml" do
  action :install
  options "--enablerepo=remi,remi-php56"
  not_if "rpm -q php-xml"
end

package "php-pecl-uopz" do
  action :install
  options "--enablerepo=remi,remi-php56"
  not_if "rpm -q php-pecl-uopz"
end

package "php-soap" do
  action :install
  options "--enablerepo=remi,remi-php56"
  not_if "rpm -q php-soap"
end

package "php-pecl-xdebug" do
  action :install
  options "--enablerepo=remi,remi-php56"
  not_if "rpm -q php-pecl-xdebug"
end

package "php-redis" do
  action :install
  options "--enablerepo=remi,remi-php56"
  not_if "rpm -q php-redis"
end

template "/etc/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[httpd]"
end

template "/etc/httpd/conf.d/php.conf" do
  source "php.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[httpd]"
end

execute "install composer" do
  command <<-EOS
    curl -sS #{node['composer']['url']} | php -- --install-dir=#{node['composer']['install_dir']}
    ln -s #{node['composer']['install_dir']}composer.phar #{node['composer']['bin']}
  EOS
  not_if { File.exist?("#{node['composer']['bin']}") }
end
