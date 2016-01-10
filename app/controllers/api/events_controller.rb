class Api::EventsController < ApplicationController

  def create
    # cannot use type as a field name in Rails, so have to create the event object manually
    @event = Event.new
    @event.date = Date.strptime(event_params[:date], "%FT%RZ")
    @event.user = event_params[:user]
    @event.message = event_params[:message]
    @event.otheruser = event_params[:otheruser]
    @event.type_of = event_params[:type]

    if @event.save
      render :json => "status: ok", status: 200
    else
      render :json => @event.errors.full_messages, status: 422
    end
  end

  def index
    query_params = query_params
    if query_params
      @events = Event.where("date: > ? AND date: < ?", query_params[:from], query_params[:to])
    else
      @events = Event.all
    end
    if @events
      render :json => @events, status: 200
    else
      render :json => "No events found", status: 404
    end
  end

  private

  def event_params
    params.require(:event).permit(:date, :user, :message, :otheruser, :type)
  end

  def query_params
    params.require(:event).permit(:from, :to)
  end
end
