#
# Cookbook Name:: ruby_rbenv
# Provider:: rehash
#
# Author:: Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright 2011, 2014, Fletcher Nichol
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

def whyrun_supported?
  true
end

use_inline_resources

provides :rbenv_rehash if respond_to?(:provides)

include Chef::Rbenv::ScriptHelpers

action :run do
  set_updated { run_script }
end

def run_script
  command = %(rbenv rehash)

  rbenv_script "#{command} #{which_rbenv}" do
    code command
    user new_resource.user if new_resource.user
    root_path new_resource.root_path if new_resource.root_path
    action :run
  end
end
