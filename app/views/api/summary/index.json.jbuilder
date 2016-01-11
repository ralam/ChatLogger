# helper method to generate frequency hash, zeros must be set to ensure they're printed in JSON object

def generate_freq_hash
  counts = Hash.new
  counts[:date]
  counts[:enters] = 0
  counts[:leaves] = 0
  counts[:comments] = 0
  counts[:highfives] = 0

  counts
end

counts = generate_freq_hash
if @interval
  json.lol "asdf"
  intervals = []
  @events.order(:date)
  if @interval == 'minute'
    current_time = @events[0].date
    @events.each do |event|
      if current_time < event.date
        counts[:date] = current_time
        intervals << counts
        counts = generate_freq_hash
        current_time += 1.minutes
      end

      action = event.type_of
      if action == "enter"
        counts[:enters] += 1
      elsif action == "leave"
        counts[:leaves] += 1
      elsif action == "comment"
        counts[:comments] += 1
      elsif action == "highfive"
        counts[:highfives] += 1
      end
    end
    counts[:date] = current_time
    intervals << counts
  elsif @interval == 'hour'
    current_time = @events[0].date
    current_time.change({minutes: 0})
    @events.each do |event|
      if current_time + 1.hours <= event.date
        counts[:date] = current_time
        intervals << counts
        counts = generate_freq_hash
        current_time += 1.hours
      end

      action = event.type_of
      if action == "enter"
        counts[:enters] += 1
      elsif action == "leave"
        counts[:leaves] += 1
      elsif action == "comment"
        counts[:comments] += 1
      elsif action == "highfive"
        counts[:highfives] += 1
      end
    end
    counts[:date] = current_time
    intervals << counts
  elsif @interval == 'day'
    current_time = @events[0].date
    current_time = current_time.beginning_of_day
    @events.each do |event|
      if current_time + 1.days <= event.date
        counts[:date] = current_time
        intervals << counts
        counts = generate_freq_hash
        current_time += 1.days
      end

      action = event.type_of
      if action == "enter"
        counts[:enters] += 1
      elsif action == "leave"
        counts[:leaves] += 1
      elsif action == "comment"
        counts[:comments] += 1
      elsif action == "highfive"
        counts[:highfives] += 1
      end
    end
    counts[:date] = current_time
    intervals << counts
  end

  json.data intervals
else
  @events.each do |event|
    action = event.type_of
    if action == "enter"
      counts[:enters] += 1
    elsif action == "leave"
      counts[:leaves] += 1
    elsif action == "comment"
      counts[:comments] += 1
    elsif action == "highfive"
      counts[:highfives] += 1
    end
  end

  json.enters counts[:enters]
  json.leaves counts[:leaves]
  json.comments counts[:comments]
  json.highfives counts[:highfives]
end
