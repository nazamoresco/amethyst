module RN::Commands::Notes
  class Retitle < Dry::CLI::Command
    desc 'Retitle a note'

    argument :old_title, required: true, desc: 'Current title of the note'
    argument :new_title, required: true, desc: 'New title for the note'
    option :book, type: :string, desc: 'Book'

    example [
      'todo TODO                                 # Changes the title of the note titled "todo" from the global book to "TODO"',
      '"New note" "Just a note" --book "My book" # Changes the title of the note titled "New note" from the book "My book" to "Just a note"',
      'thoughts thinking --book Memoires         # Changes the title of the note titled "thoughts" from the book "Memoires" to "thinking"'
    ]

    def call(old_title:, new_title:, book: "global")
      old_note = RN::Models::Note.open old_title, book
      new_note = RN::Models::Note.open new_title, book
      old_note.rename new_note
      puts "#{old_title} retitled to #{new_title}."
    rescue RN::Exceptions::ModelException => e
      puts e.message
    end
  end
end
