define (require) ->
  View = require 'View'
  Highcharts = require 'Highcharts'
  _ = require '_'


  class HighchartView extends View

    render: ->
      if @template then super()
      @chart = new Highcharts.Chart @getChartOptions()
      @addSeriesList @getModels(), false
      @redraw()

      @chart.series[0].remove()


    getModels: ->
      @collection.models


    redraw: ->
      @chart.redraw()


    addSeriesList: (seriesList, redraw) ->
      for series in seriesList
        @addSeries series, redraw


    addSeries: (series, redraw) ->
      unless @chart then return
      @chart.addSeries series.toJSON(), redraw


    getSeriesById: (id) ->
      _.find @chart.series, (series) ->
        series.options.id == id


    removeSeries: (seriesModel) ->
      @getSeriesById(seriesModel.id).remove()