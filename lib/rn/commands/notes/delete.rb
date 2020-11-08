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
      if note.exists?
        note.delete
        puts "#{title} deleted."
      else
        puts "Can't delete, #{title} doesn't exist in #{book}."
      end
    end
  end
end
