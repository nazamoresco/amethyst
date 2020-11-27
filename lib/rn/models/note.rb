module RN::Models
  class Note
    attr_accessor :title, :book, :path, :content

    singleton_class.send(:alias_method, :open, :new)

    def initialize(title, book_title, content: nil)
      self.title = title
      self.book = Book.open book_title
      self.path = File.join book.path, "#{title}.rn"

      if exists?
        self.content = File.read path
      else
        self.content = content
      end
    end

    def exists?
      File.file? path
    end

    def append new_text
      File.open path, 'a' do |file|
        file.puts new_text
      end
    end

    def book_exists?
      File.exists? book.path
    end

    def delete
      validate_existence
      %x{rm -rf #{path}}
    end

    def edit new_text
      File.write path, new_text
    end

    def self.list selected_books
      books = RN::Models::Book.all
      books = books.select { |book| selected_books.any? { |title| title == book.title } } if selected_books.any?

      books.map do |book|
        Dir["#{book.path}/*.rn"].sort.map do |note_path|
          note_path.split("/")[-2..-1].join("/").chomp(".rn")
        end
      end.flatten
    end

    def rename new_note
      validate_existence
      new_note.validate_absence

      File.rename path, new_note.path
      self.title = new_note.title
      self.path = new_note.path
    end

    def show
      validate_existence
      File.read path
    end

    def persist(force: false)
      validate_absence unless force
      validate_title
      book.validate_existence

      File.new(path, 'w')
      File.write(path, content) if content
      self
    end

    def export(format)
      validate_existence
      validate_format format

      create_book_export_dir(format)
      formatted_text = Kramdown::Document.new(content).send("to_#{format}".to_sym)
      file_path = File.join RN::Configuration::TRANSLATIONS_PATH, "#{format}/#{book.title}/#{title}.#{format}"
      File.write file_path, formatted_text
    end

    # Validations
    def validate_existence
      book.validate_existence
      raise RN::Exceptions::MissingNote, "#{title} doesn't exist in #{book.title}." unless exists?
    end

    def validate_absence
      raise RN::Exceptions::ExistingNote, "#{title} already exists in #{book.title}." if exists?
    end

    def validate_title
      raise RN::Exceptions::InvalidTitle, "#{title} is a invalid name. Valid chars: Letters, numbers and underscore." if title =~ /\W/
    end

    def validate_format format
      raise RN::Exceptions::InvalidFormat, "#{format} is not a valid format yet." unless ["pdf", "html"].any? format
    end

    private
    def create_book_export_dir(format)
      FileUtils.mkdir_p(File.join RN::Configuration::TRANSLATIONS_PATH, "#{format}/#{book.title}")
    end
  end
end
