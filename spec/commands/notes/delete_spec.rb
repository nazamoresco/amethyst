require 'spec_helper'
require 'rn/commands'
require 'rn/models'

describe "delete note" do
  context "the user tries to delete a non existing note" do
    it "fails" do
      expect {
        RN::Commands::Notes::Delete.new.call title: "note_test", book: "book_test"
      }.to output("Can't delete, note_test doesn't exist in book_test.\n").to_stdout
    end
  end

  context "the user tries to delete a existing note" do
    it "deletes the note" do
      RN::Commands::Books::Create.new.call name: "book_test"
      RN::Commands::Notes::Create.new.call title: "note_test", book: "book_test"

      expect {
        RN::Commands::Notes::Delete.new.call title: "note_test", book: "book_test"
      }.to output("note_test deleted.\n").to_stdout
    end
  end
end

