module RN::Commands::Notes
  class Show < Dry::CLI::Command
    desc 'Show a note'

    argument :title, required: true, desc: 'Title of the note'
    option :book, type: :string, desc: 'Book'

    example [
      'todo                        # Shows a note titled "todo" from the global book',
      '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
      'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
    ]

    def call(title:, book: "global")
      note = RN::Models::Note.open title, book
      puts note.show
    rescue RN::Exceptions::ModelException => e
      puts e.message
    end
  end
end
