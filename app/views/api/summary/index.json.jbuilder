enters_count, leaves_count, comments_count, highfives_count = 0,0,0,0

@events.each do |event|
  action = event.type_of
  if action == "enter"
    enters_count += 1
  elsif action == "leave"
    leaves_count += 1
  elsif action == "comment"
    comments_count += 1
  elsif action == "highfive"
    highfives_count += 1
  end
end


json.enters enters_count
json.leaves leaves_count
json.comments comments_count
json.highfives highfives_count
