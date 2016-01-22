class InterestsController < ApplicationController
  def index
    term = params[:term] || ""
    exclude = params[:exclude] || ""
    @interests = Interest.autocomplete_results term, exclude.split(/\s*,\s*/)

    respond_to do |format|
      format.json { render :json => @interests.to_json }
    end
  end
end
