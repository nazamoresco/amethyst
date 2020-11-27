module RN::Commands::Notes
  class Delete < Dry::CLI::Command
    desc 'Delete a note'

    argument :title, required: true, desc: 'Title of the note'
    option :book, type: :string, desc: 'Book'

    example [
      'todo                        # Deletes a note titled "todo" from the global book',
      '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
      'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
    ]

    def call(title:, book: "global")
      note = RN::Models::Note.open(title, book)
      note.delete
      puts "#{title} deleted."
    rescue RN::Exceptions::ModelException => e
      puts e.message
    end
  end
end
