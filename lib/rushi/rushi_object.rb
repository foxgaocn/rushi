require 'json'
require 'ostruct'

module Rushi
  class RushiObject
    def self.objectify(json)
      hash = JSON.parse(json)
      rubify_hash(hash)
    end

    private 
    def self.rubify_hash(hash)
      hash.kind_of?(Array) ? generate_array(hash) : generate_openstruct(hash)
    end

    def self.generate_array(hash)
      array = Array.new
      hash.each { |item| array.push(rubify_hash(item)) }
      array
    end

    def self.generate_openstruct(hash)
      open_struct = OpenStruct.new
      hash.each  do |key, value| 
        rubified_key = rubify_key(key)
        open_struct.new_ostruct_member rubified_key
        if(value.is_a?(Hash))
          obj_val = self.rubify_hash(value)
        elsif (value.kind_of?(Array))
          obj_val = generate_array(value)
        else
          obj_val = value
        end
        open_struct.send "#{rubified_key}=" , obj_val
      end
      open_struct
    end

    def self.rubify_key(key)
      s = StringScanner.new(key)
      ret = ""
      remaining = key
      while (val = s.scan_until(/[A-Z]+/)) do
        if (s.pos == 1 || s.pos - s.matched_size == 0)
          ret << val.downcase
          remaining = s.post_match
        elsif(s.pos == key.size)
          ret << val[0, val.size - s.matched.size]
          ret << '_'
          ret << s.matched.downcase
          remaining = s.post_match
        elsif(s.matched.size == 1)
          ret << val[0, val.size - 1]
          ret << '_'
          ret << s.matched.downcase
          remaining = s.post_match
        else
          ret << val[0, val.size - s.matched.size]
          ret << '_'
          ret << val[val.size - s.matched.size, s.matched.size - 1].downcase
          ret << '_'
          ret << val[val.size - 1 , 1].downcase
          remaining = s.post_match
        end  
      end
      ret << remaining
    end
  end	
end