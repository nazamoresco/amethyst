module RN::Commands::Books
  class Rename < Dry::CLI::Command
    desc 'Rename a book'

    argument :old_name, required: true, desc: 'Current name of the book'
    argument :new_name, required: true, desc: 'New name of the book'

    example [
      '"My book" "Our book"         # Renames the book "My book" to "Our book"',
      'Memoires Memories            # Renames the book "Memoires" to "Memories"',
      '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
    ]

    def call(old_name:, new_name:)
      old_book = RN::Models::Book.new old_name
      new_book = RN::Models::Book.new new_name
      if !old_book.exists?
        puts "Can't rename #{old_name}, that doesn't exist."
      elsif new_book.exists?
        puts "Can't rename to #{new_name}, that book already exists."
      else
        old_book.rename new_name
        puts "#{old_name} renamed to #{new_name}."
      end
    end
  end
end
