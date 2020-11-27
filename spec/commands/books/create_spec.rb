require 'spec_helper'

describe "book creation command" do
  context "the user creates a book with and existing name" do
    it "doesn't create the book and fails" do
      RN::Commands::Books::Create.new.call name: "invalid_name"

      expect{
        RN::Commands::Books::Create.new.call name: "invalid_name"
      }.to output("invalid_name already exists.\n").to_stdout
    end
  end
  context "the user creates a book" do
    it "creates a book" do
      expect {
        RN::Commands::Books::Create.new.call name: "valid_name"
      }.to output("Book created.\n").to_stdout
    end
  end
end


