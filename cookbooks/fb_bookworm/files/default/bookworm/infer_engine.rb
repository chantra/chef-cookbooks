# Copyright (c) 2022-present, Meta, Inc.
# All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require_relative 'knowledge_base'
require_relative 'infer_base_classes'

module Bookworm
  class InferEngine
    def initialize(knowledge_base, rules = [])
      @kb = knowledge_base

      rules.each do |rule|
        process_rule(rule)
      end
    end

    def process_rule(rule)
      klass = Module.const_get("Bookworm::InferRules::#{rule}")
      klass.keys.each do |key|
        @kb.send(BOOKWORM_KEYS[key]['plural'].to_sym).each do |name, metadata|
          out = klass.new(metadata).output
          @kb.add_metadata(key, name, rule, out)
        end
      end
    end

    def knowledge_base
      @kb
    end
  end
end
