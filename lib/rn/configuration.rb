module RN
  module Configuration
    BASE_PATH = File.join(ENV["HOME"], "/.my_rns/")
    TEST_BASE_PATH = File.join(ENV["HOME"], "/.my_test_rns/")
    TRANSLATIONS_PATH = File.join(BASE_PATH, "/.my_rns_translations/")

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

      unless File.exists? TRANSLATIONS_PATH
        FileUtils.mkdir_p(File.join TRANSLATIONS_PATH, "html/")
        FileUtils.mkdir_p(File.join TRANSLATIONS_PATH, "pdf/")
      end
    end

    def self.destroy_directory
      FileUtils.rm_rf BASE_PATH if File.exists? BASE_PATH
      FileUtils.rm_rf TRANSLATIONS_PATH if File.exists? TRANSLATIONS_PATH
    end
  end
end
