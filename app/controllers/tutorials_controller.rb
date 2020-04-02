class TutorialsController < ApplicationController
  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
    flash[:notice] = "User must login to bookmark videos." if params[:output_flash] == "Yes"
  end
end
