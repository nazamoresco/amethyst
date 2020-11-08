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

    def call(title:, book: "global", force: false)
      note = RN::Models::Note.new(title, book)

      if title =~ /\W/
        puts "Invalid name. Valid chars: Letters, numbers and underscore."
      elsif note.exists? && !force
        puts "Can't create test, the note already exist.\n"\
        "Try using the flag force."
      elsif !note.book_exists?
        puts "Can't create the note, the book #{book} doesn't exist."
      else
        note.persist
        puts "#{title} created."
      end
    end
  end
end
