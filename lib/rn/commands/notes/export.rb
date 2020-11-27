module RN::Commands::Notes
  class Export < Dry::CLI::Command
    desc 'Translate a note to html or pdf'

    argument :title, required: true, desc: 'Title of the note'

    option :book, type: :string, desc: 'Book name'
    option :format, type: :string, desc: 'Format to translate(pdf or html)'

    example [
      'todo --to pdf               # Export a note titled "todo" from the global book to html',
      'thoughts --book Memoires    # Export a note titled "thoughts" from the book "Memoires"'
    ]

    def call(title:, book: RN::Configuration::DEFAULT_BOOK, format: "html")
      note = RN::Models::Note.open title, book
      note.export format
      puts "#{book}/#{title} was exported to #{format}."
    rescue RN::Exceptions::ModelException => e
      puts e.message
    end
  end
end
