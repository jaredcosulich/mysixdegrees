class PhotosController < ApplicationController
  before_filter :load_profile

  def create
    @profile.photos.create(params[:photo])
    redirect_to direct_profile_path(@profile)
  end

  private
  def load_profile
    @profile = Profile.find_by_slug(params[:profile_id])
  end
end
