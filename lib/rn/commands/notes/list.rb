module RN::Commands::Notes
  class List < Dry::CLI::Command
    desc 'List notes'

    option :book, type: :string, desc: 'Book'
    option :global, type: :boolean, default: false, desc: 'List only notes from the global book'

    example [
      '                 # Lists notes from all books (including the global book)',
      '--global         # Lists notes from the global book',
      '--book "My book" # Lists notes from the book named "My book"',
    ]

    def call(book: nil, global: false)
      books = []
      books << book if book
      books << RN::Configuration::DEFAULT_BOOK if global

      list = RN::Models::Note.list(books)
      if list.empty?
        puts "No notes to list."
      else
        puts list.map { |note_title| "* #{note_title}" }.join("\n")
      end
    end
  end
end
