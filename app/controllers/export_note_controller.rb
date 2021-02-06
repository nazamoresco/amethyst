class ExportNoteController < ApplicationController
  before_action :set_note, only: [:create]

  # POST /notes
  # POST /notes.json
  def create
    render pdf: @note.title
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:format])
  end
end
