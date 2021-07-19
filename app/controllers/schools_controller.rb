class SchoolsController < ApplicationController

  def index
    @schools = []
    if params[:search].present?
      @schools = CollegeScorecard.schools.search({"school.name" => params[:search]}).to_json
    end
  end
end
