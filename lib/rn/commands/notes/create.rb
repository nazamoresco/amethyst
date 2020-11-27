module RN::Commands::Notes
  class Create < Dry::CLI::Command
    desc 'Create a note'

    argument :title, required: true, desc: 'Title of the note'
    option :book, type: :string, desc: 'Book'
    option :force, type: :boolean, desc: 'Overwrite file if it exists', aliases: ['f']

    example [
      'todo                        # Creates a note titled "todo" in the global book',
      '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
      'todo --force                # Creates the note even if it already exits'
    ]

    def call(title:, book: RN::Configuration::DEFAULT_BOOK, force: false)
      note = RN::Models::Note.new(title, book)

      note.persist force: force
      puts "#{title} created."
    rescue RN::Exceptions::ExistingNote => e
      puts e.message + "\nTry using the flag force."
    rescue RN::Exceptions::ModelException => e
      puts e.message
    end
  end
end
