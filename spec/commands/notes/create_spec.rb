require 'spec_helper'

describe "Create note command" do
  context "a user creates a note with an already existing file name without the force flag" do
    it "doesn't create the note" do
      RN::Commands::Notes::Create.new.call(title: "test")

      expect {
        RN::Commands::Notes::Create.new.call(title: "test")
      }.to output("test already exists in global.\nTry using the flag force.\n").to_stdout
    end
  end

  context "a user creates a note with an already existing file name with the force flag" do
    it "overwrite the note" do
      RN::Commands::Notes::Create.new.call(title: "test")

      expect {
        RN::Commands::Notes::Create.new.call(title: "test", force: true)
      }.to output("test created.\n").to_stdout
    end
  end

  context "a user creates a note with a book that doesn't exist" do
    it "fails" do
    expect {
      RN::Commands::Notes::Create.new.call(title: "test", book: "no-where-to-be-find")
    }.to output("no-where-to-be-find doesn't exist.\n").to_stdout
    end
  end

  context "a user creates a note with an existing book" do
    it "creates the note" do
      RN::Commands::Books::Create.new.call(name: "new-book")
      expect {
        RN::Commands::Notes::Create.new.call(title: "test", book: "new-book")
      }.to output("test created.\n").to_stdout
    end
  end

  context "a user tries to create a note with an invalid name" do
    it "creates the note" do
      expect {
        RN::Commands::Notes::Create.new.call title: "-name>"
      }.to output("-name> is a invalid name. Valid chars: Letters, numbers and underscore.\n").to_stdout

      expect {
        RN::Commands::Notes::Create.new.call title: "name//"
      }.to output("name// is a invalid name. Valid chars: Letters, numbers and underscore.\n").to_stdout
    end
  end
end
