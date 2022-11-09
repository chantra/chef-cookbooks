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
require 'rubocop'
module Bookworm
  class InferRule
    class << self
      {
        'description' => '',
        'keys' => [],
      }.each do |attribute, default_value|
        instance_variable_set("@#{attribute}".to_sym, default_value)
        define_method(attribute.to_sym) do |val = nil|
          instance_variable_set("@#{attribute}", val) unless val.nil?
          instance_variable_get("@#{attribute}")
        end
      end
    end

    extend RuboCop::NodePattern::Macros
    def initialize(metadata)
      @metadata = metadata
      output
    end

    def to_a
      []
    end

    def to_h
      {}
    end

    def default_output
      :to_a
    end

    def output
      send(default_output)
    end
  end

  # Initializing constant for Bookworm::InferRules
  module InferRules; end

  def self.load_rule_class(name, dir: '')
    f = File.read "#{dir}/#{name.to_sym}.rb"
    ::Bookworm::InferRules.const_set(name.to_sym, ::Class.new(::Bookworm::InferRule))
    ::Bookworm::InferRules.const_get(name.to_sym).class_eval(f)
  rescue StandardError
    raise Bookworm::ClassLoadError
  end
end
