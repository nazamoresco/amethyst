module RN::Models
  class Book
    attr_accessor :title, :path

    singleton_class.send(:alias_method, :open, :new)

    def initialize(title)
      self.title = title
      self.path = File.join RN::Configuration::BASE_PATH, title
    end

    def self.all
      list.map do |book_title|
        Book.open(book_title)
      end
    end

    def delete
      FileUtils.rm_rf path
      FileUtils.mkdir path if title == RN::Configuration::DEFAULT_BOOK
    end

    def exists?
      File.exists? path
    end

    def self.list
      Dir["#{ RN::Configuration::BASE_PATH }*"].map do |book_path|
        book_path.split("/")[-1]
      end
    end

    def any?
      RN::Models::Note.list([title]).any?
    end

    def rename new_name
      new_path = File.join RN::Configuration::BASE_PATH, new_name
      File.rename path, new_path

      self.title = new_name
      self.path = new_path
    end

    def persist
      Dir.mkdir path
    end
  end
end
