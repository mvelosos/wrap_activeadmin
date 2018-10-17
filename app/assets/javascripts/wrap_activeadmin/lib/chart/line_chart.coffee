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
      elements:
        point:
          radius: 0
          hitRadius: 10
          hoverRadus: 5
      scales:
        yAxes: [
          gridLines:
            zeroLineColor: '#f0f0f0'
            color: '#f0f0f0'
          ticks:
            display: true
            beginAtZero: true
            fontSize: 9
        ]
        xAxes: [
          gridLines:
            drawBorder: false
            zeroLineColor: '#f0f0f0'
            color: '#f0f0f0'
          ticks:
            maxRotation: 45
            fontSize: 9
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
        pointBackgroundColor: '#FFFFFF'
        pointBorderColor: color
        pointBorderWidth: 2
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
