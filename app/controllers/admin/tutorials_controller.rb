class Admin::TutorialsController < Admin::BaseController
  def edit
    @tutorial = Tutorial.find(params[:id])
  end

  def create
    tutorial = Tutorial.new(create_params)
    if tutorial.save
      redirect_to tutorial_path(tutorial)
      flash[:success] = "Successfully created tutorial."
    else
      flash[:error] = "Tutorial did not save."
      render :new
    end
  end

  def new
    @tutorial = Tutorial.new
  end

  def update
    tutorial = Tutorial.find(params[:id])
    if tutorial.update(tutorial_params)
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to edit_admin_tutorial_path(tutorial)
  end

  def destroy
    tutorial = Tutorial.find(params[:id])
    if tutorial.destroy
      flash[:success] = "#{tutorial.title} tagged!"
    end
    redirect_to admin_dashboard_path
  end

  private
  def tutorial_params
    params.require(:tutorial).permit(:tag_list)
  end

  def create_params
    params.require(:tutorial).permit(:title, :description, :thumbnail)
  end
end
