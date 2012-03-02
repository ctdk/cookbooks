#
# Cookbook Name:: mysql
# Recipe:: percona_client
#
# Copyright 2008-2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Include Opscode helper in Recipe class to get access
# to debian_before_squeeze? and ubuntu_before_lucid?

# For percona stuff, we need the percona repos
# borrowing liberally from the percona cookbook
case node['platform']
  when "centos", "redhat", "suse", "fedora", "scientific", "amazon"

  when "ubuntu","debian"
    include_recipe "apt"

    execute "add percona key to gpg" do
      command "gpg --keyserver keys.gnupg.net --homedir /root " +
	"--recv-keys #{node['mysql']['percona']['key_id']}"
      not_if "gpg --list-keys #{node['mysql']['percona']['key_id']}"
    end

    execute "add percona key to apt" do
      command "gpg --homedir /root --armor " +
	"--export #{node['mysql']['percona']['key_id']} | apt-key add -"
      not_if "apt-get key list #{node['mysql']['percona']['key_id']}"
    end

    apt_repository "percona" do
      distro = case node['platform']
	when "debian"
	  (node[:platform_version].to_i == 5) ? "lenny" : "squeeze"
	when "ubuntu"
	  # TODO: hammer out how the fuck best to get this for ubuntu
	end
      uri "http://repo.percona.com/apt"
      distribution distro
      components [ "main" ]
      key node['mysql']['percona']['key_id']
      action :add
    end

end

::Chef::Recipe.send(:include, Opscode::Mysql::Helpers)

mysql_packages = case node['platform']
when "centos", "redhat", "suse", "fedora", "scientific", "amazon"
  %w{Percona-Server-client-55 Percona-Server-devel}
when "ubuntu","debian"
  if debian_before_squeeze? || ubuntu_before_lucid?
    %w{percona-server-client-5.5 libmysqlclient15-dev}
  else
    %w{percona-server-client-5.5 libmysqlclient-dev}
  end
else
  %w{percona-server-client-5.5 libmysqlclient-dev}
end

mysql_packages.each do |mysql_pack|
  package mysql_pack do
    action :install
  end
end

if platform?(%w{ redhat centos fedora suse scientific amazon })
  package 'ruby-mysql'
elsif platform?(%w{ debian ubuntu })
  package "libmysql-ruby"
else
  gem_package "mysql" do
    action :install
  end
end
