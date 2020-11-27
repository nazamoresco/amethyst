require 'spec_helper'

describe "book rename command" do
  context "the user renames a book with a valid new name" do
    it "rename a book" do
      RN::Commands::Books::Create.new.call name: "old_name"

      expect {
        RN::Commands::Books::Rename.new.call old_name: "old_name", new_name: "new_name"
      }.to output("old_name renamed to new_name.\n").to_stdout
    end
  end

  context "the user renames a book that doesn't exists" do
    it "doesn't rename the book and fails" do
      expect {
        RN::Commands::Books::Rename.new.call old_name: "old_name", new_name: "new_name"
      }.to output("old_name doesn't exist.\n").to_stdout
    end
  end

  context "the user rename a book with a name that already exists" do
    it "doesn't rename the book and fails" do
      RN::Commands::Books::Create.new.call name: "old_name"
      RN::Commands::Books::Create.new.call name: "new_name"

      expect {
        RN::Commands::Books::Rename.new.call old_name: "old_name", new_name: "new_name"
      }.to output("new_name already exists.\n").to_stdout
    end
  end
end
