define (require) ->
  _ = require '_'
  TimelineModel = require 'models/analytics/timeline/TimelineModel'
  AreaChartView = require 'components/chart/AreaChartView'


  class ChartView extends AreaChartView

    yAxisMax: 0

    heightCoefficient: 80

    listen:
      '@timelineModel change:detail': 'resetYAxisMax'
      'sub context:changed': 'resetYAxisMax'

    initialize: (options) ->
      @color = options.color
      @timelineModel = new TimelineModel

      @listenTo @model, 'change', =>
        @setYAxisMax()
        @addSeries @model, true


    render: ->
      @chart = new Highcharts.Chart @getChartOptions()


    addSeries: (series, redraw) ->
      @getSeriesById(@model.id).remove()

      if @chart
        attrs = series.toJSON()
        attrs.color = @color
        @chart.addSeries attrs, redraw


    getLineWidth: ->
      0


    getFillOpacity: ->
      1


    getHeight: ->
      44


    getMarginRight: ->
      -30


    setYAxisMax: ->
      unless @chart then return
      max = _.max @model.get 'data'

      if @yAxisMax < max
        @yAxisMax = max
        @chart.yAxis[0].setExtremes 0, max / (@heightCoefficient / @getHeight()) # hack to set correct height for timelime area chart view


    resetYAxisMax: ->
      @yAxisMax = 0
