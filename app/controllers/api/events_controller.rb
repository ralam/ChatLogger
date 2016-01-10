class Api::EventsController < ApplicationController

  def create
    @event = Event.new(event_params)
    if @event.create
      render json: {"status": "ok"}, status: 200
    else
      render json: @event.errors.full_messages, status: 422
    end
  end

  def index
  end

  private

  def event_params
    params
      .require(:event)
      .permit(:date, :user, :type, :message, :otheruser)
  end
end
