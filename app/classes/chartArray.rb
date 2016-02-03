class ChartArray
  
  def numberArray(x, current_user)
    return Event.where(user_id: current_user.id).where.not(status: 'cancelled').where.not(rating: nil).where.not(start: nil).map{|e| [e.send(x), e.rating]}
  end

  def dateTimeHourArray(x, current_user)
    return Event.where(user_id: current_user.id).where.not(status: 'cancelled').where.not(rating: nil).where.not(start: nil).map{|e|[e.send(x).in_time_zone("Pacific Time (US & Canada)").hour, e.rating]}
  end

  def categoricalArray(x, current_user)
    return Event.where(user_id: current_user.id).where.not(status: 'cancelled').where.not(rating: nil).where.not(start: nil).map{|e| e.send(x) == true ? [1, e.rating] : [0, e.rating]}.group_by{|e|e}.map{|k,v|[" ",k[0],k[1],v.count]}
  end

end