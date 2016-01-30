class SimpsonMathClass

	def linearRegression(current_user, attributeA, attributeB)
		return query(current_user, attributeA, attributeB)
	end

	def query(current_user, attributeA, attributeB)
		test_attr = attributeA[0..-1]
		if Event.columns_hash["#{test_attr}"].type == :integer
			sumX = Event.where(user_id: current_user.id).where.not(status: 'cancelled').where.not(rating: nil).where.not(start: nil).sum(attributeA)
	    elsif Event.columns_hash["#{test_attr}"].type == :datetime
			sumX = Event.where(user_id: current_user.id).where.not(status: 'cancelled').where.not(rating: nil).where.not(start: nil).map{|e|e.start.hour}.sum
	    elsif Event.columns_hash["#{test_attr}"].type == :boolean
	    	sumX = Event.where(user_id: current_user.id).where.not(status: 'cancelled').where.not(rating: nil).where.not(start: nil).where("#{attributeA} = ?", true).count
	    else
	    	reutrn "not correct data type"
	    end
	    sumX2 = sumX*sumX
	    sumY = Event.where(user_id: current_user.id).where.not(status: 'cancelled').where.not(rating: nil).where.not(start: nil).sum(attributeB)
	    sumY2 = sumY*sumY
	    n = Event.where(user_id: current_user.id).where.not(status: 'cancelled').where.not(rating: nil).where.not(start: nil).count
	    sumXY = sumX*sumY
	    hash = findLine(n, sumX, sumY, sumXY, sumX2, sumY2)
	    hash['title'] = "#{attributeA} vs. #{attributeB} Comparison"
	    hash['attributeX'] = attributeA
	    hash['attributeY'] = attributeB
	    return hash
	end

	def findLine(n, sumX, sumY, sumXY, sumX2, sumY2)
		a = findA(n, sumX, sumY, sumXY, sumX2, sumY2)
		b = findB(n, sumX, sumY, sumXY, sumX2, sumY2)
		answer = {a: a, b: b, line: "y = #{a.round(3)} + #{b.round(3)}x"}
		return answer
	end

	def findA(n, sumX, sumY, sumXY, sumX2, sumY2)
		top = ((sumY)*(sumX2))-((sumX)*(sumXY))
		bottom = ((n)*(sumX2))-((sumX)*(sumX))
		return top.to_f/bottom.to_f
	end

	def findB(n, sumX, sumY, sumXY, sumX2, sumY2)
		top = ((n)*(sumXY))-((sumX)*(sumY))
		bottom = ((n)*(sumX2))-((sumX)*(sumX))
		return top.to_f/bottom.to_f
	end

end