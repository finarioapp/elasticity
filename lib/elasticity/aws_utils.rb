module Elasticity

  class AwsUtils

    # Escape a string according to Amazon's rules.
    # See: http://docs.amazonwebservices.com/AmazonSimpleDB/2007-11-07/DeveloperGuide/index.html?REST_RESTAuth.html
    def self.aws_escape(param)
      param.to_s.gsub(/([^a-zA-Z0-9._~-]+)/n) do
        '%' + $1.unpack('H2' * $1.size).join('%').upcase
      end
    end

    # With the advent of v4 signing, we can skip the complex translation from v2
    # and ship the JSON over with nearly the same structure.
    def self.convert_ruby_to_aws_v4(value, options = {})
      case value
        when Array
          return value.map{|v| convert_ruby_to_aws_v4(v)}
        when Hash
          value_options = options.clone
          result = {}
          value.each do |k,v|
            key = options[:skip_key_camelize] ? k.to_s : camelize(k.to_s)
            value_options.merge!( skip_key_camelize: true ) if key == "Properties"
            result[key] = convert_ruby_to_aws_v4(v, value_options)
          end
          return result
        else
          return value
      end
    end

    def self.camelize(word)
      word.to_s.gsub(/\/(.?)/) { '::' + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
    end

  end

end
