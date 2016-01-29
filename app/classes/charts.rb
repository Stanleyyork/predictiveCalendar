class GoogleChart

  def scatterRatingsChart(ratings_array, attribute, min, max)
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
      title: "Rating vs. #{attribute} Comparison",
      hAxis: {title: "#{attribute}", minValue: min, maxValue: max},
      vAxis: {title: 'Rating', minValue: 1, maxValue: 5},
      legend: 'none'
     }
    return GoogleVisualr::Interactive::BubbleChart.new(data_table_ratings, opts_ratings)
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

end