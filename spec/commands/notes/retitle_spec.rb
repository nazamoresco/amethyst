require 'spec_helper'

describe "note retitle command" do
  context "the user retitles a note with a valid new title" do
    it "retitle a note" do
      RN::Commands::Notes::Create.new.call title: "old_title"

      expect {
        RN::Commands::Notes::Retitle.new.call old_title: "old_title", new_title: "new_title"
      }.to output("old_title retitled to new_title.\n").to_stdout
    end
  end

  context "the user retitles a note that doesn't exists" do
    it "doesn't retitle the note and fails" do
      expect {
        RN::Commands::Notes::Retitle.new.call old_title: "old_title", new_title: "new_title"
      }.to output("old_title doesn't exist in global.\n").to_stdout
    end
  end

  context "the user retitle a note with a title that already exists" do
    it "doesn't retitle the note and fails" do
      RN::Commands::Notes::Create.new.call title: "old_title"
      RN::Commands::Notes::Create.new.call title: "new_title"

      expect {
        RN::Commands::Notes::Retitle.new.call old_title: "old_title", new_title: "new_title"
      }.to output("new_title already exists in global.\n").to_stdout
    end
  end
end
