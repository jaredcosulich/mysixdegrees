class ProfilesController < ApplicationController

  def index
    redirect_to profile_path(current_user)
  end

  def show
    @profile = Profile.find_by_slug(params[:id])
    @network = []
  end

  def new
    
  end

  def create
    profile = Profile.create(params[:profile])
    session["profiles"] = [] if session["profiles"].nil?
    session["profiles"] << profile.slug
    redirect_to(profile_path(profile))
  end

end
