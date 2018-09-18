class ActiveAdmin.BarChart

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
      maintainAspectRatio: true
      labels: false
      layout:
        padding: 0
      scales:
        yAxes: [
          maxBarThickness: 50
          gridLines:
            zeroLineColor: '#E6E6E6'
            color: '#E6E6E6'
          ticks:
            display: true
            beginAtZero: true
        ]
        xAxes: [
          maxBarThickness: 50
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
    @options = $.extend true, @options, options
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
        borderWidth: 2
        borderColor: color
        backgroundColor: hexToRgba(color, 0.4)

    chartData =
      labels: labels
      datasets: datasets

    return if !@element
    new Chart(
      @element,
      type:    'bar'
      data:    chartData
      options: @options
    )

$.widget.bridge 'aaBarChart', ActiveAdmin.BarChart
