require 'spec_helper'
require 'rn/commands'
require 'rn/models'

describe "book list command" do
  context "the user ask for a book list" do
    it "list all book" do
      RN::Commands::Books::Create.new.call(name: "book_1")
      RN::Commands::Books::Create.new.call(name: "book_2")
      RN::Commands::Books::Create.new.call(name: "book_3")

      expect {
        RN::Commands::Books::List.new.call
      }.to output("* book_1\n* book_2\n* book_3\n* global\n").to_stdout
    end
  end
end
