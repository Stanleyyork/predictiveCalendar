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
      tooltip: {isHtml: true},
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
    scatter_ratings_opts = {
      :width => 1100, :height => 600,
      hAxis: {title: "#{attribute}", minValue: min, maxValue: max},
      vAxis: {title: 'Rating', minValue: 1, maxValue: 5},
      :trendlines => { 0 => {type: 'linear'}, 1 => {type: 'exponential'} }
    }
    return GoogleVisualr::Interactive::ScatterChart.new(data_table_ratings, scatter_ratings_opts)
  end

  def cancelledPieChart(events_count_cancelled, events_count)
    cancelled_pie_chart = Array.new
    cancelled_pie_chart << ['Cancelled', events_count_cancelled]
    cancelled_pie_chart << ['Not Cancelled', (events_count)]
    data_table_cancelled_pie = GoogleVisualr::DataTable.new
    data_table_cancelled_pie.new_column('string', 'Status')
    data_table_cancelled_pie.new_column('number', 'Status')
    data_table_cancelled_pie.add_rows(
      cancelled_pie_chart.each do |x|
        [x[0], x[1]]
      end
    )
    cancelled_opts   = { :width => 200, :height => 200, pieSliceText: 'none', :legend => "none",
      colors: ['#5bc0de', '#428bca'],
      backgroundColor: '#f5f5f5',
      tooltip: {isHtml: true},
      slices: {
             },
            chartArea: {top: 35, left: 10},
            tooltip: { :textStyle => {fontSize: 14} },
            pieHole: 0.4
          }
    return GoogleVisualr::Interactive::PieChart.new(data_table_cancelled_pie, cancelled_opts)
  end

  def eventsHourly(events_hourly_array, height, width, bgcolor='#f5f5f5')
    data_table_events_hourly = GoogleVisualr::DataTable.new
    data_table_events_hourly.new_column('string', 'Hour')
    data_table_events_hourly.new_column('number', 'No. of Events')
    data_table_events_hourly.add_rows(
      events_hourly_array.each do |x|
        [x[0],x[1]]
      end
    )
    opts_events_hourly   = {:width => width, :height => height, :legend => "none",
      chartArea: {left: 5},
      colors: ['#5cb85c'],
      backgroundColor: bgcolor,
      tooltip: {isHtml: true},
      curveType: 'function',
        hAxis: {
          baseline: -1,
          baselineColor: "none",
          gridlines: {color: "none"}
        },
        vAxis: {
          textPosition: "none",
          baselineColor: "none",
          gridlines: {color: "none"}
        }
     }
    return GoogleVisualr::Interactive::LineChart.new(data_table_events_hourly, opts_events_hourly)
  end

  def eventsDaily(events_daily_array, height, width)
    data_table_events_daily = GoogleVisualr::DataTable.new
    data_table_events_daily.new_column('string', 'Hour')
    data_table_events_daily.new_column('number', 'No. of Events')
    data_table_events_daily.add_rows(
      events_daily_array.each do |x|
        [x[0],x[1]]
      end
    )
    opts_events_dailiy   = {:width => width, :height => height, :legend => "none",
      chartArea: {left: 5},
      colors: ['#428bca'],
      backgroundColor: '#f5f5f5',
      tooltip: {isHtml: true},
      curveType: 'function',
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
        }
     }
    return GoogleVisualr::Interactive::BarChart.new(data_table_events_daily, opts_events_dailiy)
  end

  def sankey(data, height=500, width=1200)
    data_table_sankey = GoogleVisualr::DataTable.new
    data_table_sankey.new_column('string', 'From')
    data_table_sankey.new_column('string', 'To')
    data_table_sankey.new_column('number', '# of Meetings Together')
    data_table_sankey.add_rows(
      data.each do |x|
        [x[0], x[1], x[2]]
      end
    )
    colors = ['#e0e0e0', '#5cb85c', '#5bc0de', '#428bca', '#d9534f']
    sankey_options = {
        height: height,
        width: width,
        sankey: {
        node: {
          colors: colors,
          label: { color: '#636363' }
        },
        link: {
          colorMode: 'gradient',
          colors: colors
        }
      }
      };
    return GoogleVisualr::Interactive::Sankey.new(data_table_sankey, sankey_options)
  end

end