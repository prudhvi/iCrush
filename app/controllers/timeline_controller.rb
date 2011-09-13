class TimelineController < ApplicationController
  before_filter :require_authentication

  def show
   # @posts = current_user.profile.home
    @gender = current_user.profile.gender
    if(@gender == 'male')
        gen_filter = 'female'
    else
        gen_filter = 'male'
    end
   @friends2 = current_user.profile.friends(:fields =>"name,id,gender,relationship_status",:access_token => current_user.profile.access_token)
    debugger
   @friends = @friends2.find_all { |obj| obj.gender == gen_filter && obj.relationship_status != "Married" && obj.relationship_status != 'In a Relationship'}
   @friends = @friends.paginate(:page=>params[:page],:per_page => 4)
  end

  def create
    current_user.profile.feed!(
      :message => params[:message]
    )
    redirect_to timeline_url
  end

end
