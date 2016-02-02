class GoogleChart

  def bubbleRatingsChart(ratings_array, attribute, min, max, title)
    data_table_ratings = GoogleVisualr::DataTable.new
    data_table_ratings.new_column('string', 'ID')
    data_table_ratings.new_column('number', "#{attribute}")
    data_table_ratings.new_column('number', 'Rating')
    data_table_ratings.new_column('number', 'Count')
    data_table_ratings.add_rows(
      ratings_array.each do |x|
        [x[0],x[1],x[2],x[3]]
      end
    )
    opts_ratings   = { 
      :width => 1100, :height => 600,
      title: "#{title}",
      hAxis: {title: "#{attribute}", minValue: min, maxValue: max},
      vAxis: {title: 'Rating', minValue: 1, maxValue: 5},
      legend: 'none'
     }
    return GoogleVisualr::Interactive::BubbleChart.new(data_table_ratings, opts_ratings)
  end

  def scatterRatingsChart(ratings_array, attribute, min, max, title)
    puts ratings_array
    data_table_ratings = GoogleVisualr::DataTable.new
    data_table_ratings.new_column('number', "#{attribute}")
    data_table_ratings.new_column('number', 'Rating')
    data_table_ratings.add_rows(
      ratings_array.each do |x|
        [x[0],x[1]]
      end
    )
    return GoogleVisualr::Interactive::ScatterChart.new(data_table_ratings)
  end

  def cancelledPieChart(events_count_cancelled, events_count)
    cancelled_pie_chart = Array.new
    cancelled_pie_chart << ['Cancelled', events_count_cancelled]
    cancelled_pie_chart << ['Not Cancelled', (events_count - events_count_cancelled)]
    data_table_cancelled_pie = GoogleVisualr::DataTable.new
    data_table_cancelled_pie.new_column('string', 'Status')
    data_table_cancelled_pie.new_column('number', 'Status')
    data_table_cancelled_pie.add_rows(
      cancelled_pie_chart.each do |x|
        [x[0], x[1]]
      end
    )
    cancelled_opts   = { :width => 200, :height => 200, pieSliceText: 'none', :legend => "none", slices: {
             },
            chartArea: {top: 35, left: 10},
            tooltip: { :textStyle => {fontSize: 14} },
            pieHole: 0.4
          }
    return GoogleVisualr::Interactive::PieChart.new(data_table_cancelled_pie, cancelled_opts)
  end

  def eventsHourly(events_hourly_array)
    data_table_events_hourly = GoogleVisualr::DataTable.new
    data_table_events_hourly.new_column('string', 'Hour')
    data_table_events_hourly.new_column('number', 'No. of Events')
    data_table_events_hourly.add_rows(
      events_hourly_array.each do |x|
        [x[0],x[1]]
      end
    )
    opts_events_hourly   = { :width => 1100, :height => 200, :legend => "none",
      chartArea: {left: 5},
        hAxis: {
          textPosition: "none",
          baseline: -1,
          baselineColor: "none",
          gridlines: {color: "none"}
        },
        vAxis: {
          textPosition: "none",
          baselineColor: "none",
          gridlines: {color: "none"}
        },
        animation: {startup: true}
     }
    return GoogleVisualr::Interactive::ColumnChart.new(data_table_events_hourly, opts_events_hourly)
  end

  def logregchart
    arr= []
    yhats=[0.6800090688812132, 0.6800090688812132, 0.7012448669495471, 0.7012448669495471, 0.6579999803561284, 0.6800090688812132, 0.665418105694049, 0.7081410466005259, 0.7081410466005259, 0.6871767645720267, 0.7081410466005259, 0.6579999803561284, 0.6871767645720267, 0.6871767645720267, 0.7012448669495471, 0.7081410466005259, 0.6727553506534607, 0.6579999803561284, 0.6942560940694258, 0.665418105694049, 0.6800090688812132, 0.6727553506534607, 0.665418105694049, 0.7149427503125549, 0.6579999803561284, 0.7081410466005259, 0.7012448669495471, 0.7012448669495471, 0.6942560940694258, 0.7012448669495471, 0.6871767645720267, 0.6800090688812132, 0.6579999803561284, 0.6942560940694258, 0.6727553506534607, 0.7012448669495471, 0.665418105694049, 0.6942560940694258, 0.6871767645720267, 0.6871767645720267, 0.665418105694049, 0.6942560940694258, 0.7149427503125549, 0.6579999803561284, 0.6579999803561284, 0.6579999803561284, 0.6579999803561284, 0.665418105694049, 0.665418105694049, 0.665418105694049, 0.665418105694049, 0.6579999803561284, 0.7081410466005259, 0.6579999803561284, 0.6800090688812132, 0.7149427503125549, 0.665418105694049, 0.6579999803561284, 0.665418105694049, 0.7149427503125549, 0.7012448669495471, 0.6579999803561284, 0.665418105694049, 0.7081410466005259, 0.6579999803561284, 0.6800090688812132, 0.6579999803561284, 0.7012448669495471, 0.6800090688812132, 0.6800090688812132, 0.6800090688812132, 0.6579999803561284, 0.6579999803561284, 0.6727553506534607, 0.6579999803561284, 0.7012448669495471, 0.7012448669495471, 0.6800090688812132, 0.6800090688812132, 0.6800090688812132, 0.6800090688812132, 0.6800090688812132, 0.6579999803561284, 0.6871767645720267, 0.6727553506534607, 0.6727553506534607, 0.6352889953838575, 0.6871767645720267, 0.6800090688812132, 0.7149427503125549, 0.7012448669495471, 0.7012448669495471, 0.7012448669495471, 0.6942560940694258, 0.6942560940694258, 0.7012448669495471, 0.665418105694049, 0.7012448669495471, 0.6579999803561284, 0.6800090688812132, 0.6800090688812132, 0.6727553506534607, 0.6727553506534607, 0.7012448669495471, 0.6800090688812132, 0.6871767645720267, 0.6800090688812132, 0.665418105694049, 0.7012448669495471, 0.7081410466005259]
    x1s=[12, 12, 15, 15, 9, 12, 10, 16, 16, 13, 16, 9, 13, 13, 15, 16, 11, 9, 14, 10, 12, 11, 10, 17, 9, 16, 15, 15, 14, 15, 13, 12, 9, 14, 11, 15, 10, 14, 13, 13, 10, 14, 17, 9, 9, 9, 9, 10, 10, 10, 10, 9, 16, 9, 12, 17, 10, 9, 10, 17, 15, 9, 10, 16, 9, 12, 9, 15, 12, 12, 12, 9, 9, 11, 9, 15, 15, 12, 12, 12, 12, 12, 9, 13, 11, 11, 6, 13, 12, 17, 15, 15, 15, 14, 14, 15, 10, 15, 9, 12, 12, 11, 11, 15, 12, 13, 12, 10, 15, 16]
    (0..109).each do |x|
        arr.push([x1s[x].to_f, yhats[x].to_f])
    end
    puts arr
    data_table_logreg = GoogleVisualr::DataTable.new
    data_table_logreg.new_column('number', 'X')
    data_table_logreg.new_column('number', 'Yhat')
    data_table_logreg.add_rows(
      arr.each do |x|
        [x[0],x[1]]
      end
    )
    return GoogleVisualr::Interactive::ScatterChart.new(data_table_logreg)
  end

end