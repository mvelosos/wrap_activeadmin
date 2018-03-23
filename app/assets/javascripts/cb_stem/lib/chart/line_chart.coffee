class ActiveAdmin.LineChart

  constructor: (@options, @element) ->
    @$element = $(@element)

    defaults = {
      legend:
        display: false
        position: 'bottom'
        labels:
          usePointStyle: true
          fontSize: 10
      responsive: true
      maintainAspectRatio: false
      labels: false
      layout:
        padding: 10
      scales:
        yAxes: [
          gridLines:
            zeroLineColor: '#E6E6E6'
            color: '#E6E6E6'
          ticks:
            display: true
            beginAtZero: true
        ]
        xAxes: [
          gridLines:
            drawBorder: false
            zeroLineColor: '#E6E6E6'
            color: '#E6E6E6'
            borderDash: [3]
          ticks:
            maxRotation: 45
            callback: (value, index, values) ->
              if value
                return value
              else
                return ''
        ]
    }

    @options = $.extend defaults, @options

    @_bind()

  # Private
  _bind: ->
    labels   = @$element.data('chart-label')
    data     = @$element.data('chart-data')
    options  = @$element.data('chart-options')
    @options = $.extend @options, options
    datasets = []

    $.each data, (index, value) ->
      length = ChartColors.length
      color =
        if index > length
          ChartColors[(index % length)]
        else
          ChartColors[index]

      datasets[index] =
        label: value.label
        data: value.value
        pointRadius: 4
        pointHoverRadius: 4
        pointBorderWidth: 2
        borderWidth: 2
        borderColor: color
        pointBackgroundColor: 'white'
        lineTension: 0
        fill: false

    chartData =
      labels: labels
      datasets: datasets

    return if !@element
    new Chart(
      @element,
      type:    'line'
      data:    chartData
      options: @options
    )

$.widget.bridge 'aaLineChart', ActiveAdmin.LineChart
