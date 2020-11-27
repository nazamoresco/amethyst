module RN::Commands::Books
  class Delete < Dry::CLI::Command
    desc 'Delete a book'

    argument :name, required: false, desc: 'Name of the book'
    option :global, type: :boolean, default: false, desc: 'Operate on the global book'

    example [
      '--global  # Deletes all notes from the global book',
      '"My book" # Deletes a book named "My book" and all of its notes',
      'Memoires  # Deletes a book named "Memoires" and all of its notes'
    ]

    def call(name: nil, global: false)
      book_names = []
      book_names << name if name
      book_names << "global" if global

      outputs = book_names.map do |book_name|
        book = RN::Models::Book.open book_name

        book.delete
        "Book #{book.title} deleted."
      rescue RN::Exceptions::ModelException => e
        puts e.message
      end.join "\n"

      puts outputs
    end
  end
end
