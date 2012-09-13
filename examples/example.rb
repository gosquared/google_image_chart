#!/usr/bin/env ruby

require 'bundler/setup'
require 'awesome_print'
require 'pry'

def exemplify(description, object)
  puts "\n::: #{description} ".ljust(70, ":::")
  ap(object, indent: -2)
end
