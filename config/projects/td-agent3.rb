require 'erb'
require 'fileutils'
require 'rubygems'

name "td-agent"
#maintainer "Treasure Data, Inc"
#homepage "http://treasuredata.com"
#description "Treasure Agent: A data collector for Treasure Data"
maintainer "Delphix Engineering <eng@delphix.com>"
homepage "https://www.delphix.com"
description "Insight Data pipeline"

if windows?
  install_dir "#{default_root}/opt/#{name}"
else
  install_dir "#{default_root}/#{name}"
end

build_version   "3.5.1"
build_iteration 0
# Custom Delphix version & revision
pkg_ver = ENV["PACKAGE_VERSION"]
pkg_rev = ENV["PACKAGE_REVISION"]
build_version "#{pkg_ver}"
build_iteration "#{pkg_rev}"

# creates required build directories
dependency "preparation"

override :ruby, :version => '2.4.9'
override :zlib, :version => '1.2.11'
override :jemalloc, :version => '4.5.0'
override :rubygems, :version => '2.6.14'
override :postgresql, :version => '9.6.9'
override :fluentd, :version => '9c577a78e69fb3bc1fc1faf0ef425091b9180987' # v1.7.4

# td-agent dependencies/components
#dependency "td-agent"
#dependency "td-agent-files"
#dependency "td"
#dependency "td-agent-ui" # fluentd-ui doesn't work with ruby 2.4 because some gems depend on json 1.8
#dependency "td-agent-cleanup"

# Use core td-agent and custom Delphix ones below
dependency "td-agent"
dependency "delphix-fluentd-files"
dependency "delphix-fluentd-cleanup"
# Add Delphix custom splunk-hec plugin
dependency "splunk-hec"

# version manifest file
dependency "version-manifest"

case ohai["os"]
when "linux"
  case ohai["platform_family"]
  when "debian"
    runtime_dependency "lsb-base"
  when "rhel", "amazon"
    runtime_dependency "cyrus-sasl-lib" # for rdkafka
    if ohai["platform_version"][0].to_i <= 7
      runtime_dependency "initscripts"
      runtime_dependency "redhat-lsb-core"
    end
  end
end

exclude "\.git*"
exclude "bundler\/git"

compress :dmg do
end

package :msi do
  upgrade_code "76dcb0b2-81ad-4a07-bf3b-1db567594171"
  parameters({
    'InstallDir' => install_dir,
    'TDAgentConfDir' => "#{install_dir}/etc/td-agent",
  })
end
