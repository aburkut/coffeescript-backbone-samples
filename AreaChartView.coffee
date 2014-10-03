define (require) ->
  HighchartView = require 'components/chart/HighchartView'
  Highcharts = require 'Highcharts'


  class AreaChartView extends HighchartView

    getRenderTo: ->
      @el


    getChartType: ->
      'area'


    getChartOptions: ->
      that = @

      chart:
        renderTo: that.getRenderTo()
        type: that.getChartType()
        animation: false
        marginBottom: 0
        marginLeft: that.getMarginLeft()
        marginRight: that.getMarginRight()
        height: that.getHeight()

      title:
        text: null

      credits:
        enabled: false

      legend:
        enabled: false

      tooltip:
        useHtml: true
        formatter: -> that.getTooltipFormatter(this)

      plotOptions:
        area:
          stacking: true
        series:
          animation: false
          enableMouseTracking: that.getEnableMouseTracking()
          lineWidth: that.getLineWidth()
          marker:
            enabled: that.getMarkerEnabled()
        areaspline:
          fillOpacity: that.getFillOpacity()

      yAxis:
        labels:
          enabled: false

        title:
          text: null

        gridLineWidth: 0
        min: 0
        max: that.getMaxYAxis()

      xAxis:
        type: 'datetime'
        labels:
          enabled: false

        lineColor: 'transparent'
        tickLength: 0

      series: [
        {}
      ]


    getLineWidth: ->
      2


    getFillOpacity: ->
      0.1


    getMarginLeft: ->
      -15


    getMarginRight: ->
      -15


    getMaxYAxis: ->
      null


    getMarkerEnabled: ->
      false


    getEnableMouseTracking: ->
      false


    getTooltipFormatter: ->
      null