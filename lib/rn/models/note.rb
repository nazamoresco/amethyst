module RN::Models
  class Note
    attr_accessor :title, :book, :path

    singleton_class.send(:alias_method, :open, :new)

    def initialize(title, book_title)
      self.title = title
      self.book = Book.open book_title
      self.path = File.join book.path, "#{title}.rn"
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

    def rename new_name
      # Seria mejor pasarle el path del new_note
      File.rename path, File.join(book.path, new_name + ".rn")
    end

    def show
      File.read path
    end

    def persist
      File.new(path, 'w')
    end
  end
end
