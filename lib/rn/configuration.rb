module RN
  module Configuration
    BASE_PATH = File.join(ENV["HOME"], "/.my_rns/")
    TEST_BASE_PATH = File.join(ENV["HOME"], "/.my_test_rns/")

    DEFAULT_BOOK = "global"

    def self.start
      create_directory
    end

    def self.destroy
      destroy_directory
    end

    def self.reset
      destroy
      start
    end

    private

    def self.create_directory
      unless File.exists? BASE_PATH
        FileUtils.mkdir_p(File.join BASE_PATH, DEFAULT_BOOK)
      end
    end

    def self.destroy_directory
      FileUtils.rm_rf BASE_PATH if File.exists? BASE_PATH
    end
  end
end
