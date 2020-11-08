module RN::Commands::Books
  class List < Dry::CLI::Command
    desc 'List books'

    example [
      '          # Lists every available book'
    ]

    def call(*)
      puts RN::Models::Book.list.sort.map { |book_path| "* #{book_path}" }.join("\n")
    end
  end
end
