class SimpsonMathClass

	def linearRegression(current_user, attributeA, attributeB)
		return query(current_user, attributeA, attributeB)
	end

	def query(current_user, attributeA, attributeB)
		test_attr = attributeA[0..-1]
		if Event.columns_hash["#{test_attr}"].type == :integer
			sumXarray = Event.where(user_id: current_user.id).where.not(status: 'cancelled').where.not(rating: nil).where.not(start: nil).pluck(attributeA)
			sumX = sumXarray.sum
	    elsif Event.columns_hash["#{test_attr}"].type == :datetime
	    	sumXarray = Event.where(user_id: current_user.id).where.not(status: 'cancelled').where.not(rating: nil).where.not(start: nil).map{|e|e.start.in_time_zone("Pacific Time (US & Canada)").hour}
			sumX = sumXarray.sum
	    elsif Event.columns_hash["#{test_attr}"].type == :boolean
	    	sumXarray = Event.where(user_id: current_user.id).where.not(status: 'cancelled').where.not(rating: nil).where.not(start: nil).map{|e| e.send(attributeA) == true ? 1 : 0}
	    	sumX = sumXarray.count
	    else
	    	reutrn "not correct data type"
	    end
	    
	    sumYarray = Event.where(user_id: current_user.id).where.not(status: 'cancelled').where.not(rating: nil).where.not(start: nil).pluck(attributeB)
	    sumY = sumYarray.sum
	    sumY2 = sumYarray.each_with_index.map{|x,i| x*sumYarray[i]}.sum
	    sumX2 = sumXarray.each_with_index.map{|x,i| x*sumXarray[i]}.sum
	    n = sumXarray.count
	    sumXY = sumXarray.each_with_index.map{|x,i| x*sumYarray[i]}.sum
	    hash = findLine(n, sumX, sumY, sumXY, sumX2, sumY2)
	    hash['title'] = "#{attributeA} vs. #{attributeB} Comparison"
	    hash['attributeX'] = attributeA
	    hash['attributeY'] = attributeB
	    return hash
	end

	def findLine(n, sumX, sumY, sumXY, sumX2, sumY2)
		b = findB(n, sumX, sumY, sumXY, sumX2, sumY2)
		m = findM(n, sumX, sumY, sumXY, sumX2, sumY2)
		answer = {b: b, m: m, line: "y = #{b.round(3)} + #{m.round(3)}x"}
		return answer
	end

	def findB(n, sumX, sumY, sumXY, sumX2, sumY2)
		top = ((sumY)*(sumX2))-((sumX)*(sumXY))
		bottom = ((n)*(sumX2))-((sumX)*(sumX))
		return top.to_f/bottom.to_f
	end

	def findM(n, sumX, sumY, sumXY, sumX2, sumY2)
		top = ((n)*(sumXY))-((sumX)*(sumY))
		bottom = ((n)*(sumX2))-((sumX)*(sumX))
		return top.to_f/bottom.to_f
	end

end