module RN::Commands::Notes
  class Edit < Dry::CLI::Command
    desc 'Edit the content a note'

    argument :title, required: true, desc: 'Title of the note'
    option :book, type: :string, desc: 'Book'
    option :editor, type: :string, desc: 'Note editor'
    option :append, type: :boolean, desc: 'The input text will be appended to the note'

    example [
      'todo                        # Edits a note titled "todo" from the global book',
      '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
      'todo --editor vim           # Edits a note titled "todo" with the edit vim',
      'todo --append               # Edits the note title "todo" appending the input text',
    ]

    def call(title:, book: "global", editor: nil, append: false)
      note = RN::Models::Note.open(title, book)

      if editor
        system(editor, note.path)
      else
        puts "You are in edit mode, press Enter + [CTRL D] to stop writing"
        new_text = STDIN.gets(sep=nil)

        edit_mode = append ? :append : :edit
        note.send(edit_mode, new_text)
      end
      puts "Note edited."
    end
  end
end
