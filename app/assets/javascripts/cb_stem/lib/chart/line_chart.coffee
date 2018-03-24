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
        padding: 0
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
    colors   = @$element.data('chart-colors') || ChartColors
    @options = $.extend @options, options
    datasets = []

    $.each data, (index, value) ->
      length = ChartColors.length
      color =
        if index > length
          colors[(index % length)]
        else
          colors[index]

      datasets[index] =
        label: value.label
        data: value.value
        pointRadius: 0
        pointHoverRadius: 2
        pointBorderWidth: 0
        borderWidth: 2
        borderColor: color
        pointBackgroundColor: color
        backgroundColor: hexToRgba(color, 0.4)
        lineTension: 0
        fill: true

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
