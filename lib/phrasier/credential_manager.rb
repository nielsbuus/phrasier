require 'ostruct'

module Phrasier
  class CredentialManager
    class << self

      def username
        read_file['email']
      end

      def password
        read_file['password']
      end

      def projects
        read_file['projects'].collect do |project|
          OpenStruct.new(project)
        end
      end

      def read_file
        filename = 'credentials.json'
        begin
          credentials = File.read(filename)
          JSON.parse(credentials)
        rescue Errno::ENOENT
          raise <<-error
Could not read your credential settings. Please ensure you've got a configuration file at
#{Dir.pwd}/#{filename}

See the README for information on structure.
error
        end
      end
    end
  end
end
