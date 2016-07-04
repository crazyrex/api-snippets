module Model
  class SnippetModel
    SERVER_LANGUAGES = [
      'py',
      'rb',
      'js',
      'curl',
      'xml.curl',
      'json.curl',
      'php',
      '4.php',
      '5.php',
      'java',
      'cs'
    ].freeze

    attr_reader :output_folder, :relative_folder, :source_folder, :title, :type, :testable, :name, :langs, :available_langs

    alias testable? testable

    def initialize(meta_json_path, test_model)
      @source_folder    = File.dirname(meta_json_path)
      @relative_folder  = @source_folder.sub(test_model.root_source_folder,"")
      @output_folder    = test_model.root_output_folder + @relative_folder
      json_object       = JSON.parse(File.read(meta_json_path))
      @testable         = json_object.fetch('testable', test_model.testable).to_s.downcase == 'true'
      @name             = File.basename(@source_folder)
      @type             = json_object.fetch('type', 'server').downcase
      @title            = json_object.fetch('title') { raise "#{meta_json_path} has no title" }
      @langs            = @type == 'server' ? SERVER_LANGUAGES : []
      @testable         = false unless @type == 'server'
      @available_langs  = {}
      Dir.glob("#{source_folder}/**") do |file|
        lang = File.extname(file)[1..-1]
        if lang == 'curl'
          match = file.match(/\.(.+\.curl)$/)
          lang = match.captures.first unless match.nil?
        elsif lang == 'php'
          match = file.match(/\.(.+\.php)$/)
          lang = match.captures.first unless match.nil?
        end
        @available_langs.merge!(lang => File.basename(file)) if @langs.include?(lang)
      end
    end

    def get_input_file(lang_cname)
      "#{source_folder}/#{available_langs.fetch(lang_cname)}" if available_langs.key?(lang_cname)
    end

    def get_output_file(lang_cname)
      "#{output_folder}/#{available_langs.fetch(lang_cname)}" if available_langs.key?(lang_cname)
    end

    def to_s
      "[#{type}\t]\t#{@output_folder}"
    end
  end
end
