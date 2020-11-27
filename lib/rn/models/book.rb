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
      validate_existence

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

    def notes
      RN::Models::Note.list([title]).map { |note_title| RN::Models::Note.open note_title.split("/")[1], title}
    end

    def rename new_book
      validate_existence
      new_book.validate_absence

      File.rename path, new_book.path

      self.title = new_book.title
      self.path = new_book.path
    end

    def persist
      validate_absence

      Dir.mkdir path
    end

    def export(format)
      validate_existence
      validate_format(format)

      notes.each { |note| note.export format}
      self
    end

    # Validations
    def validate_absence
      raise RN::Exceptions::ExistingBook, "#{title} already exists." if exists?
    end

    def validate_existence
      raise RN::Exceptions::MissingBook, "#{title} doesn't exist." unless exists?
    end

    def validate_format(format)
      raise RN::Exceptions::InvalidFormat, "#{format} is not a valid format yet." unless ["pdf", "html"].any? format
    end
  end
end
