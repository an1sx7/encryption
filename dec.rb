#!/usr/bin/env ruby
require "lockbox"

files = []

Dir.foreach(".") do |f|
   next if f == "enc.rb" ||  f.start_with?(".") ||  f == "TheKey.key" || f == "dec.rb"
   files.push(f)
end

key = File.read("TheKey.key")
box = Lockbox.new(key:key)

File.write("TheKey.key",key)

files.each do |f|
  content = File.binread(f)
  decrypted = box.decrypt(content)
  File.binwrite(f,decrypted)
end

File.delete("TheKey.key")
puts "All Files Are Decrypted"
