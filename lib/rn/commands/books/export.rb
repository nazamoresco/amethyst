module RN::Commands::Books
  class Export < Dry::CLI::Command
    desc 'Export a book'

    option :book, desc: 'Name of the book to export'
    option :all, type: :boolean, desc: 'Exports all books'
    option :format, desc: 'Exports all books'


    example [
      '                       # Exports all notes from the global book to html',
      '"My book" --format pdf # Exports a book named "My book" and all of its notes to pdf',
      '--all                  # Exports a book named "Memoires" and all of its notes'
    ]

    def call(book: RN::Configuration::DEFAULT_BOOK, all: false, format: "html")
      if all
        RN::Models::Book.list.map do |book_title|
          book_to_export = RN::Models::Book.open book_title
          book_to_export.export format
          puts "All the notes from #{book_to_export.title} where exported to #{format}."
        end
      else
        book = RN::Models::Book.open book
        book.export format
        puts "All the notes from #{book.title} where exported to #{format}."
      end
    rescue RN::Exceptions::ModelException => e
      puts e.message
    end
  end
end
