require 'ostruct'

module Collins
  class AssetState
    include Collins::Util

    attr_accessor :description, :id, :label, :name, :status

    def self.from_json json
      Collins::AssetState.new json
    end

    def initialize opts = {}
      hash = symbolize_hash(opts).inject({}) do |result, (k,v)|
        key = k.to_s.downcase.to_sym
        result[key] = v
        result
      end
      @description = hash[:description].to_s
      @id = hash[:id].to_s.to_i
      @label = hash[:label].to_s
      @name = hash[:name].to_s
      @status = get_status hash[:status]
    end

    def empty?
      @id == 0
    end

    def to_s
      if empty? then
        "State(None)"
      else
        "State(id = #{id}, name = '#{name}', label = '#{label}', description = '#{description}')"
      end
    end

    private
    def get_status opt
      opts = opt || {}
      hash = symbolize_hash(opts).inject({}) do |result, (k,v)|
        key = k.to_s.downcase.to_sym
        result[key] = v
        result
      end
      OpenStruct.new(hash)
    end

  end
end
