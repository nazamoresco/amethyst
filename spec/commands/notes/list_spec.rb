require 'spec_helper'

describe "note list command" do
  context "the user ask for a note list" do
    it "list all note" do
      RN::Commands::Notes::Create.new.call(title: "note_1")
      RN::Commands::Notes::Create.new.call(title: "note_2")
      RN::Commands::Notes::Create.new.call(title: "note_3")

      expect{
        RN::Commands::Notes::List.new.call
      }.to output("* global/note_1\n* global/note_2\n* global/note_3\n").to_stdout
    end
  end
end
