#
# Cookbook Name:: mysql
# Attributes:: server
#
# Copyright 2008-2009, Opscode, Inc.
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

include_attribute "mysql::general"

case node["platform"]
when "centos", "redhat", "fedora", "suse", "scientific", "amazon"
  default['mysql']['package_name']            = "mysql-server"
  default['mysql']['service_name']            = "mysqld"
  default['mysql']['basedir']                 = "/usr"
  default['mysql']['lc_messages_dir']	      = "/usr/share/mysql"
  default['mysql']['data_dir']                = "/var/lib/mysql"
  default['mysql']['root_group']              = "root"
  default['mysql']['mysqladmin_bin']          = "/usr/bin/mysqladmin"
  default['mysql']['mysql_bin']               = "/usr/bin/mysql"

  set['mysql']['conf_dir']                    = '/etc'
  set['mysql']['socket']                      = "/var/lib/mysql/mysql.sock"
  set['mysql']['pid_file']                    = "/var/run/mysqld/mysqld.pid"
  set['mysql']['old_passwords']               = 1
  set['mysql']['grants_path']                 = "/etc/mysql_grants.sql"
when "freebsd"
  default['mysql']['package_name']            = "mysql55-server"
  default['mysql']['service_name']            = "mysql-server"
  default['mysql']['basedir']                 = "/usr/local"
  default['mysql']['lc_messages_dir']	      = "/usr/local/share/mysql"
  default['mysql']['data_dir']                = "/var/db/mysql"
  default['mysql']['root_group']              = "wheel"
  default['mysql']['mysqladmin_bin']          = "/usr/local/bin/mysqladmin"
  default['mysql']['mysql_bin']               = "/usr/local/bin/mysql"

  set['mysql']['conf_dir']                    = '/usr/local/etc'
  set['mysql']['socket']                      = "/tmp/mysqld.sock"
  set['mysql']['pid_file']                    = "/var/run/mysqld/mysqld.pid"
  set['mysql']['old_passwords']               = 0
  set['mysql']['grants_path']                 = "/var/db/mysql/grants.sql"
else
  default['mysql']['package_name']            = "mysql-server"
  default['mysql']['service_name']            = "mysql"
  default['mysql']['basedir']                 = "/usr"
  default['mysql']['lc_messages_dir']	      = "/usr/share/mysql"
  default['mysql']['data_dir']                = "/var/lib/mysql"
  default['mysql']['root_group']              = "root"
  default['mysql']['mysqladmin_bin']          = "/usr/bin/mysqladmin"
  default['mysql']['mysql_bin']               = "/usr/bin/mysql"

  set['mysql']['conf_dir']                    = '/etc/mysql'
  set['mysql']['socket']                      = "/var/run/mysqld/mysqld.sock"
  set['mysql']['pid_file']                    = "/var/run/mysqld/mysqld.pid"
  set['mysql']['old_passwords']               = 0
  set['mysql']['grants_path']                 = "/etc/mysql/grants.sql"
end
