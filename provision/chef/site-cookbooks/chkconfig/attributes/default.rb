#
# Cookbook Name:: chkconfig
# Attributes:: default

default['chkconfig']['off'] = [
  'acpid',
  'auditd',
  'blk-availability',
  'cpuspeed',
  'haldaemon',
  'ip6tables',
  'kdump',
  'lvm2-monitor',
  'mdmonitor',
  'messagebus',
  'netfs',
  'nfslock',
  'rpcbind',
  'rpcgssd'
]