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
        JSON.parse(File.read('credentials.json'))
      end
    end
  end
end
