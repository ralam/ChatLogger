class Api::EventsController < ApplicationController
  def index
  end

  private

  def event_params
    params.require(:from, :to)
  end
end
