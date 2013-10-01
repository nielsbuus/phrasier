module Phrasier
  class Phrasier
    attr_accessor :session, :keys, :auth_token

    def initialize
      sign_in
      refresh
    end

    def sign_in
      @current_project = CredentialManager.projects.first
      username = CredentialManager.username
      password = CredentialManager.password

      authentication_response = RestClient.post base_url("sessions"), email: username, password: password
      parsed_response = JSON.parse(authentication_response)

      if parsed_response['success']
        @auth_token = parsed_response['auth_token']
      else
        raise "Failed to sign in."
      end
    end

    def current_project
      @current_project.name
    end

    def switch_project(project_name)
      new_project = CredentialManager.projects.find do |project|
        project.name == project_name
      end
      if new_project
        @current_project = new_project
        refresh
      else
        puts "No project found named '#{project_name}'. Sticking to '#{@current_project.name}'."
      end
    end

    def projects
      CredentialManager.projects.collect do |project|
        project.name
      end
    end

    def logged_in?
      session_status['logged_in'] == true
    end

    def session_status
      JSON.parse(RestClient.post base_url("auth/check_login"), auth_token: auth_token)
    end

    def current_project_auth_token
      @current_project.project_auth_token
    end

    def refresh
      @keys = {}
      fetch_keylist.each do |key|
        @keys[key['name']] = key
      end
      nil
    end

    def delete_keys_by_name(*key_names)
      keys = key_names.collect do |name|
        key = @keys[name]
        puts "Warning: No key found for name #{name}. Skipping key." if key.nil?
        key
      end
      keys.compact!
      delete_keys(keys)
    end

    def delete_keys(keys)
      puts "Deleting #{keys.length} keys in batches of 10."
      keys.each_slice(10) do |slice|
        puts "Now deleting..."
        slice.each do |keys|
          puts keys['name']
        end
        target_url = paramize_url(base_url("translation_keys/destroy_multiple"), tokens.merge({"ids[]" => key_ids(slice)}))
        RestClient.delete(target_url)
        puts "Done.\n\n"
      end
    end

    def has_key?(key_name)
      @keys.has_key?(key_name)
    end

    def tags
      resp = RestClient.get paramize_url(base_url("tags"), tokens)
      JSON.parse(resp).collect do |tag|
        tag['name']
      end
    end

    def count
      @keys.count
    end

    private

    def fetch_keylist
      JSON.parse(RestClient.get paramize_url(base_url('translation_keys'), tokens))
    end

    def key_ids(keys)
      keys.collect do |key|
        key['id']
      end
    end

    def tokens
      {auth_token: auth_token, project_auth_token: current_project_auth_token}
    end

    def paramize_url(url, params)
      "#{url}?#{URI.encode_www_form(params)}"
    end

    def base_url(path)
      "https://phraseapp.com/api/v1/#{path}"
    end

  end

end
