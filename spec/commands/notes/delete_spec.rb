require 'spec_helper'

describe "delete note" do
  context "the user tries to delete a non existing note" do
    it "fails" do
      expect {
        RN::Commands::Notes::Delete.new.call title: "note_test", book: "book_test"
      }.to output("book_test doesn't exist.\n").to_stdout
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

