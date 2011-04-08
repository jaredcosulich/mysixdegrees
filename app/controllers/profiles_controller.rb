class ProfilesController < ApplicationController

  def index
    redirect_to direct_profile_path(current_user)
  end

  def show
    @profile = Profile.find_by_slug(params[:id], :include => :connections)
    @owner = session["profiles"] && session["profiles"].include?(params[:id])
    @connections = @profile.connections
    @from = ((params[:from] || "").split(",") << @profile.slug)
  end

  def new
    @join = params[:join]
  end

  def create
    profile = Profile.create(params[:profile])
    session["profiles"] = [] if session["profiles"].nil?
    session["profiles"] << profile.slug
    if (join_profile = Profile.find_by_slug(params[:join]))
      profile.connections.create(:to_profile => join_profile)
      join_profile.connections.create(:to_profile => profile)
    end
    redirect_to(profile_path(profile))
  end

  def update
    profile = Profile.find_by_slug(params[:id])
    profile.update_attributes(params[:profile])
    redirect_to direct_profile_path(profile)
  end

end
