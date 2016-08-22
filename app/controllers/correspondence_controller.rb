class CorrespondenceController < ApplicationController

  def new
    @correspondence = Correspondence.new
  end

  def create
    @correspondence = Correspondence.new(correspondence_params)

    if @correspondence.valid?
      EmailCorrespondenceJob.perform_later(YAML.dump(@correspondence))
      render 'correspondence/confirmation'
    else
      render :new
    end
  end

  def start
    render :start
  end

  private

  def correspondence_params
    params.require(:correspondence).permit(
      :name,
      :email,
      :email_confirmation,
      :type,
      :topic,
      :message
      ) 
  end

end
