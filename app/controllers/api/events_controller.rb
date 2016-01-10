class Api::EventsController < ApplicationController

  def create
    @event = Event.new(event_params)
    if @event.create
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
    params
      .require(:event)
      .permit(:date, :user, :type, :message, :otheruser)
  end

  def query_params
    params
      .require(:event).permit(:from, :to)
  end
end
