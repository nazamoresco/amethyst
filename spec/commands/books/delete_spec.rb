require 'spec_helper'
require 'rn/commands'
require 'rn/models'

describe "book creation command" do
  context "the user tries to delete a book that exists" do
    it "deletes a book" do
      RN::Commands::Books::Create.new.call name: "valid_name"
      expect {
        RN::Commands::Books::Delete.new.call name: "valid_name"
      }.to output("Book valid_name deleted.\n").to_stdout
    end
  end

  context "the user tries to delete a book that doesn't exist" do
    it "doesn't delete the book and fails" do
      expect {
        RN::Commands::Books::Delete.new.call name: "valid_name"
      }.to output("Book valid_name doesn't exist.\n").to_stdout
    end
  end
end
