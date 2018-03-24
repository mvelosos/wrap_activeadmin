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

    chartData =
      labels: labels
      datasets: [{
        borderWidth: 2
        borderColor: colors
        backgroundColor: $.map(colors, (n, i) -> hexToRgba(n, 0.4))
        data: data
      }]

    return if !@element
    new Chart(
      @element,
      type:    'bar'
      data:    chartData
      options: @options
    )

$.widget.bridge 'aaBarChart', ActiveAdmin.BarChart
