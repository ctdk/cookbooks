#
# Cookbook Name:: mysql
# Attributes:: general
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

default['mysql']['bind_address']               = attribute?('cloud') ? cloud['local_ipv4'] : ipaddress

if attribute?('ec2')
  default['mysql']['ec2_path']    = "/mnt/mysql"
  default['mysql']['ebs_vol_dev'] = "/dev/sdi"
  default['mysql']['ebs_vol_size'] = 50
end

default['mysql']['port'] = "3306"
default['mysql']['nice'] = "0"
default['mysql']['tmpdir'] = "/tmp"
default['mysql']['lc_messages'] = "en_US"
default['mysql']['character_set_server'] = "utf8"
default['mysql']['character_set_client'] = "utf8"
default['mysql']['collation_server'] = "utf8_general_ci"
default['mysql']['default_storage_engine'] = "MyISAM"
default['mysql']['server_id'] = "1"
default['mysql']['default_character_set'] = "utf8"

default['mysql']['allow_remote_root']               = false
default['mysql']['tunable']['back_log']             = "128"
default['mysql']['tunable']['key_buffer']           = "256M"
default['mysql']['tunable']['max_allowed_packet']   = "16M"
default['mysql']['tunable']['max_connections']      = "800"
default['mysql']['tunable']['max_heap_table_size']  = "32M"
default['mysql']['tunable']['myisam_recover']       = "BACKUP"
default['mysql']['tunable']['net_read_timeout']     = "30"
default['mysql']['tunable']['net_write_timeout']    = "30"
default['mysql']['tunable']['table_cache']          = "128"
default['mysql']['tunable']['table_open_cache']     = "128"
default['mysql']['tunable']['thread_cache']         = "128"
default['mysql']['tunable']['thread_cache_size']    = 8
default['mysql']['tunable']['thread_concurrency']   = 10
default['mysql']['tunable']['thread_stack']         = "256K"
default['mysql']['tunable']['wait_timeout']         = "180"

default['mysql']['tunable']['query_cache_limit']    = "1M"
default['mysql']['tunable']['query_cache_size']     = "16M"

default['mysql']['tunable']['log_slow_queries']     = "/var/log/mysql/slow.log"
default['mysql']['tunable']['long_query_time']      = 2

default['mysql']['tunable']['expire_logs_days']     = 10
default['mysql']['tunable']['max_binlog_size']      = "100M"

default['mysql']['tunable']['innodb_buffer_pool_size']  = "256M"

default['mysql']['tunable']['connect_timeout']	    = 10
default['mysql']['tunable']['max_connect_errors']   = 10
default['mysql']['tunable']['binlog_cache_size']    = 32768
default['mysql']['tunable']['table_open_cache']	    = 400
default['mysql']['tunable']['read_buffer_size']	    = 131072
default['mysql']['tunable']['read_rnd_buffer_size'] = 262144
default['mysql']['tunable']['sort_buffer_size']	    = 2097144
default['mysql']['tunable']['memlock']		    = true
default['mysql']['tunable']['transaction_isolation'] = "REPEATABLE-READ"
default['mysql']['tunable']['log_bin']		    = "mysql-log"
default['mysql']['tunable']['binlog_format']	    = "mixed"
default['mysql']['tunable']['slow_query_log']	    = true
