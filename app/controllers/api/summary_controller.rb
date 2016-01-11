class Api::SummaryController < ApplicationController
  def index
    if query_params[:from] && query_params[:to]
      @from_date = DateTime.strptime(query_params[:from], "%FT%RZ")
      @to_date = DateTime.strptime(query_params[:to], "%FT%RZ")
      @events = Event.where("date > ? AND date < ?", @from_date, @to_date)
    elsif query_params[:from]
      @from_date = DateTime.strptime(query_params[:from], "%FT%RZ")
      @events = Event.where("date > ?", @from_date)
    elsif query_params[:to]
      @to_date = DateTime.strptime(query_params[:to], "%FT%RZ")
      @events = Event.where("date < ?", @to_date)
    else
      @events = Event.all
    end

    @interval = query_params[:by] if query_params[:by]

    if @events
      render :index
    else
      render :json => "No events found", status: 404
    end
  end


  private

  def query_params
    params.slice(:from, :to, :by)
  end
end
