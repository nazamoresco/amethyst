module RN::Commands::Books
  class Create < Dry::CLI::Command
    desc 'Create a book'

    argument :name, required: true, desc: 'Name of the book'

    example [
      '"My book" # Creates a new book named "My book"',
      'Memoires  # Creates a new book named "Memoires"'
    ]

    def call(name:)
      book = RN::Models::Book.new name
      book.persist
      puts "Book created."
    rescue RN::Exceptions::ModelException => e
      puts e.message
    end
  end
end
