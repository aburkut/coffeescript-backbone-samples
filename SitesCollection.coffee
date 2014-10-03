define (require) ->
  _ = require '_'
  utils = require 'utils'
  RowsCollection = require 'components/table/statistics/RowsCollection'
  FilterTypeModel = require 'models/sites/FilterTypeModel'
  SiteModel = require 'models/sites/SiteModel'
  apiRoutes = require 'components/api/apiRoutes'


  class SitesCollection extends RowsCollection

    model: SiteModel

    url: apiRoutes 'sites'

    section: 'site'

    initialize: (models, options) ->
      @filterModel = options.filterModel
      @statisticsModel = options.statisticsModel
      @filterTypeModel = new FilterTypeModel


    getStateWeight: (state) ->
      switch state
        when 'verification' then 0
        when 'wait' then 1
        when 'on' then 2
        when 'off' then 3
        when 'forbidden' then 4